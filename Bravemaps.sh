#!/usr/bin/env bash
#
# gmaps2brave.sh — Convert Google Maps URLs → Brave Maps and open in Brave
#

set -uo pipefail

BRAVE_BASE="https://search.brave.com/maps/search"
BRAVE_BIN="${BRAVE_BIN:-}"
DEBUG="${DEBUG:-0}"

die() { zenity --error --width=440 --text="$1" >&2; exit 1; }

# ── helpers ───────────────────────────────────────────────────────────
open_in_brave() {
    local url="$1"
    [[ -n "$BRAVE_BIN" ]] && { "$BRAVE_BIN" "$url" >/dev/null 2>&1 & return; }
    for c in brave-browser brave brave-browser-stable; do
        command -v "$c" >/dev/null 2>&1 && { "$c" "$url" >/dev/null 2>&1 & return; }
    done
    flatpak list --app 2>/dev/null | grep -qi com.brave.Browser && \
        { flatpak run com.brave.Browser "$url" >/dev/null 2>&1 & return; }
    command -v xdg-open >/dev/null 2>&1 && { xdg-open "$url" >/dev/null 2>&1 & return; }
    die "Brave browser not found. Install it or set BRAVE_BIN."
}

copy_clip() {
    if   command -v wl-copy >/dev/null 2>&1; then printf '%s' "$1" | wl-copy
    elif command -v xclip   >/dev/null 2>&1; then printf '%s' "$1" | xclip -selection clipboard
    elif command -v xsel    >/dev/null 2>&1; then printf '%s' "$1" | xsel -ib
    fi
}

# ── 1. input (clipboard prefill) ──────────────────────────────────────
clip=""
if   command -v wl-paste >/dev/null 2>&1; then clip="$(wl-paste -n 2>/dev/null)"
elif command -v xclip    >/dev/null 2>&1; then clip="$(xclip -o -selection clipboard 2>/dev/null)"
elif command -v xsel     >/dev/null 2>&1; then clip="$(xsel -ob 2>/dev/null)"
fi
[[ "$clip" != *google.com/maps* && "$clip" != *maps.app.goo.gl* ]] && clip=""

gurl="$(zenity --entry --width=620 \
        --title="Google Maps → Brave Maps" \
        --text="Paste a Google Maps URL:" \
        --entry-text="$clip")" || exit 0
[[ -z "${gurl// }" ]] && die "No URL entered."

# ── 2. expand short links ─────────────────────────────────────────────
case "$gurl" in
    *goo.gl*|*g.co/*)
        gurl="$(curl -sIL -o /dev/null -w '%{url_effective}' \
                -A 'Mozilla/5.0' --max-time 15 "$gurl" 2>/dev/null)" || true
        ;;
esac

# ── 3. parse Google URL and build Brave URL ───────────────────────────
# NOTE: BRAVE_BASE is passed as argv[2] because the quoted heredoc
# ('PY') intentionally blocks shell expansion inside the Python code.
result="$(python3 - "$gurl" "$BRAVE_BASE" <<'PY'
import re, sys, math, urllib.parse

BRAVE_BASE = sys.argv[2]

raw = sys.argv[1].strip()
u    = urllib.parse.urlsplit(raw if '://' in raw else 'https://' + raw)
path = urllib.parse.unquote(u.path)
qs   = urllib.parse.parse_qs(u.query)
blob = u.path + '&' + u.query

def num(x):
    return format(float(x), '.6f').rstrip('0').rstrip('.')

lat = lng = zoom = query = None

# (1) precise pin from data blob: !3dLAT!4dLNG (most accurate)
m3 = re.search(r'!3d(-?\d+(?:\.\d+))', blob)
m4 = re.search(r'!4d(-?\d+(?:\.\d+))', blob)
if m3 and m4:
    lat, lng = num(m3.group(1)), num(m4.group(1))

# (2) viewport: /@lat,lng[,zoomz] (fallback, also provides zoom)
mv = re.search(r'@(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)(?:,(\d+(?:\.\d+)?)z)?', path)
if mv:
    if not lat: lat = num(mv.group(1))
    if not lng: lng = num(mv.group(2))
    if mv.group(3): zoom = int(float(mv.group(3)))

# (3) legacy params
for k in ('ll', 'sll', 'center'):
    if (not lat or not lng) and k in qs:
        mm = re.match(r'(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)', qs[k][0])
        if mm:
            lat = lat or num(mm.group(1))
            lng = lng or num(mm.group(2))
if zoom is None and 'z' in qs:
    zoom = int(float(qs['z'][0]))

# (4) human-readable query term
if (m := re.search(r'/maps/place/([^/@?]+)', path)):
    query = m.group(1).replace('+', ' ').strip()
elif (m := re.search(r'/maps/search/([^/@?]+)', path)):
    query = m.group(1).replace('+', ' ').strip()
elif (m := re.search(r'/maps/dir/([^/]+)/([^/@?]+)', path)):
    query = f"{m.group(1)} to {m.group(2)}".replace('+', ' ').strip()
elif 'q' in qs or 'query' in qs:
    query = (qs.get('q') or qs.get('query'))[0].strip()

# Query-only mode (no coords available)
if not lat or not lng:
    if query:
        print("URL\t" + f"{BRAVE_BASE}?q={urllib.parse.quote(query)}")
    else:
        print("ERR\tCould not extract coordinates or a search term.")
    sys.exit(0)

# (5) zoom → bbox: 360° / 2^zoom = world width in degrees
z = zoom if zoom is not None else 13
half_lng = 360.0 / (2 ** z) * 0.5
half_lat = half_lng * math.cos(math.radians(float(lat)))

min_lat = float(lat) - half_lat
max_lat = float(lat) + half_lat
min_lng = float(lng) - half_lng
max_lng = float(lng) + half_lng

bbox = f"{min_lng:.6f},{min_lat:.6f},{max_lng:.6f},{max_lat:.6f}"
bbox_enc = urllib.parse.quote(bbox, safe='')
q_enc   = urllib.parse.quote(query) if query else ""

print("URL\t" + f"{BRAVE_BASE}?q={q_enc}&bbox={bbox_enc}")
print(f"INFO\tlat={lat} lng={lng} zoom={z} query='{query or '(none)'}' bbox=[{min_lng:.4f}, {min_lat:.4f}] → [{max_lng:.4f}, {max_lat:.4f}]")
PY
)" || die "Parsing failed — check Python is installed."

brave_url="$(sed -n 's/^URL\t//p' <<< "$result")"
info="$(sed -n 's/^INFO\t//p' <<< "$result")"

[[ -z "$brave_url" ]] && die "Unexpected parse failure."
[[ "$brave_url" == ERR* ]] && die "$brave_url"

[[ "$DEBUG" == "1" ]] && echo "$brave_url" >&2

# ── 4. confirm and open ───────────────────────────────────────────────
if zenity --question --width=640 --title="Open in Brave Maps?" \
        --text="<b>Parsed</b>\n${info//&/&amp;}\n\n<b>Brave URL</b>\n${brave_url//&/&amp;}\n\nOpen it?" \
        --ok-label="Open" --cancel-label="Copy only"; then
    copy_clip "$brave_url"
    open_in_brave "$brave_url"
else
    copy_clip "$brave_url"
    zenity --info --width=440 --text="Brave Maps URL copied to clipboard."
fi
