

![Project Image](project-image-url)
# G-remap
A privacy bash script to redirect Google Maps urls to Brave Maps

---

### Table of Contents
You're sections headers will be used to reference location of destination.

- [Description](#description)
- [Dependencies](#dependencies)
- [How To Use](#how-to-use)
- [References](#references)
- [License](#license)
- [Author Info](#author-info)

---

## Description

Using zenity with python powered parsing the standard Google Maps location structure is translated into the current (10/15/2026) Brave Maps format.


[Back To The Top](#read-me-template)

---

## Dependencies

</head>

<body dir="ltr" style="max-width:8.5in;margin-top:0.7874in; margin-bottom:0.7874in; margin-left:0.7874in; margin-right:0.7874in; ">
<p class="paragraph-P1"> </p><h2 class="paragraph-P2"><a id=""><span/></a></h2>


<table border="0" cellspacing="0" cellpadding="0" class="table-Table1"><colgroup><col width="173"/><col width="293"/><col width="303"/></colgroup><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P3">Dependency</p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P3">Purpose</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P3">Installation</p>
</td></tr><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">bash</span></span><span class="text-T2"> (v4+)</span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">Script execution, string manipulation, arrays</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P5">Usually pre-installed on Linux</p>
</td></tr><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">python3</span></span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">URL parsing and bbox calculation</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">sudo apt install python3</span></span><span class="text-T2"> / </span><span class="text-Source_20_Text"><span class="text-T3">dnf install python3</span></span></p>
</td></tr><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">zenity</span></span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">GTK dialog boxes (input, confirmation, errors)</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">sudo apt install zenity</span></span><span class="text-T2"> / </span><span class="text-Source_20_Text"><span class="text-T3">dnf install zenity</span></span></p>
</td></tr><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">curl</span></span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">Expanding goo.gl/g.co short links</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">sudo apt install curl</span></span><span class="text-T2"> / </span><span class="text-Source_20_Text"><span class="text-T3">dnf install curl</span></span></p>
</td></tr><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">sed</span></span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">Extracting lines from Python output</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P5">Pre-installed on all Linux systems</p>
</td></tr><tr class="row-Table1_1"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">grep</span></span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">Checking for Flatpak/Snap packages</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P5">Pre-installed on all Linux systems</p>
</td></tr><tr class="row-Table1_8"><td style="text-align:left;width:1.5576in; " class="cell-Table1_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">flatpak</span></span><span class="text-T2"> or </span><span class="text-Strong_20_Emphasis"><span class="text-T1">snap</span></span><span class="text-T2"> (optional)</span></p>
</td><td style="text-align:left;width:2.6389in; " class="cell-Table1_A1">
<p class="paragraph-P5">Detecting Brave if installed via package managers</p>
</td><td style="text-align:left;width:2.7285in; " class="cell-Table1_A1">
<p class="paragraph-P6">Optional, not strictly required</p>
</td></tr></table>

<h2 class="paragraph-P2"><a id="a__Clipboard_Utilities__Need_at_least_one_"><span/></a>Clipboard Utilities (Need at least one)</h2>


<table border="0" cellspacing="0" cellpadding="0" class="table-Table2"><colgroup><col width="75"/><col width="314"/><col width="238"/></colgroup><tr class="row-Table2_1"><td style="text-align:left;width:0.6764in; " class="cell-Table2_A1">
<p class="paragraph-P3">Tool</p>
</td><td style="text-align:left;width:2.8264in; " class="cell-Table2_A1">
<p class="paragraph-P3">Desktop Environment</p>
</td><td style="text-align:left;width:2.1424in; " class="cell-Table2_A1">
<p class="paragraph-P3">Command</p>
</td></tr><tr class="row-Table2_1"><td style="text-align:left;width:0.6764in; " class="cell-Table2_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">wl-copy</span></span></p>
</td><td style="text-align:left;width:2.8264in; " class="cell-Table2_A1">
<p class="paragraph-P5">Wayland (GNOME, KDE Plasma, Sway)</p>
</td><td style="text-align:left;width:2.1424in; " class="cell-Table2_A1">
<p class="paragraph-P4"><span class="text-T2">Part of </span><span class="text-Source_20_Text"><span class="text-T3">wl-clipboard</span></span><span class="text-T2"> package</span></p>
</td></tr><tr class="row-Table2_1"><td style="text-align:left;width:0.6764in; " class="cell-Table2_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">xclip</span></span></p>
</td><td style="text-align:left;width:2.8264in; " class="cell-Table2_A1">
<p class="paragraph-P5">X11/X.org</p>
</td><td style="text-align:left;width:2.1424in; " class="cell-Table2_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">sudo apt install xclip</span></span></p>
</td></tr><tr class="row-Table2_1"><td style="text-align:left;width:0.6764in; " class="cell-Table2_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">xsel</span></span></p>
</td><td style="text-align:left;width:2.8264in; " class="cell-Table2_A1">
<p class="paragraph-P5">X11/X.org (alternative)</p>
</td><td style="text-align:left;width:2.1424in; " class="cell-Table2_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">sudo apt install xsel</span></span></p>
</td></tr></table>


<p class="paragraph-P7">If none are found, the clipboard copy silently fails but the script continues (you can still manually open the URL).</p>
<h2 class="paragraph-P2"><a id="a__Browser_Launch_Fallbacks"><span/></a>Browser Launch Fallbacks</h2>


<table border="0" cellspacing="0" cellpadding="0" class="table-Table3"><colgroup><col width="227"/><col width="258"/><col width="283"/></colgroup><tr class="row-Table3_1"><td style="text-align:left;width:2.0438in; " class="cell-Table3_A1">
<p class="paragraph-P3">Method</p>
</td><td style="text-align:left;width:2.3278in; " class="cell-Table3_A1">
<p class="paragraph-P3">Binary</p>
</td><td style="text-align:left;width:2.5535in; " class="cell-Table3_A1">
<p class="paragraph-P3">Notes</p>
</td></tr><tr class="row-Table3_1"><td style="text-align:left;width:2.0438in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">brave-browser</span></span></p>
</td><td style="text-align:left;width:2.3278in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">/usr/bin/brave-browser</span></span></p>
</td><td style="text-align:left;width:2.5535in; " class="cell-Table3_A1">
<p class="paragraph-P5">Preferred (Debian/Ubuntu/Fedora repos)</p>
</td></tr><tr class="row-Table3_1"><td style="text-align:left;width:2.0438in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">brave</span></span></p>
</td><td style="text-align:left;width:2.3278in; " class="cell-Table3_A1">
<p class="paragraph-P5">Various locations</p>
</td><td style="text-align:left;width:2.5535in; " class="cell-Table3_A1">
<p class="paragraph-P5">Standalone installations</p>
</td></tr><tr class="row-Table3_1"><td style="text-align:left;width:2.0438in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">brave-browser-stable</span></span></p>
</td><td style="text-align:left;width:2.3278in; " class="cell-Table3_A1">
<p class="paragraph-P5">AUR/PKG systems</p>
</td><td style="text-align:left;width:2.5535in; " class="cell-Table3_A1">
<p class="paragraph-P5">Arch/Manjaro</p>
</td></tr><tr class="row-Table3_1"><td style="text-align:left;width:2.0438in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">com.brave.Browser</span></span><span class="text-T2"> (Flatpak)</span></p>
</td><td style="text-align:left;width:2.3278in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Source_20_Text"><span class="text-T3">~/.var/app/com.brave.Browser</span></span></p>
</td><td style="text-align:left;width:2.5535in; " class="cell-Table3_A1">
<p class="paragraph-P5">Detected automatically</p>
</td></tr><tr class="row-Table3_1"><td style="text-align:left;width:2.0438in; " class="cell-Table3_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">xdg-open</span></span></p>
</td><td style="text-align:left;width:2.3278in; " class="cell-Table3_A1">
<p class="paragraph-P5">Any registered browser</p>
</td><td style="text-align:left;width:2.5535in; " class="cell-Table3_A1">
<p class="paragraph-P6">Universal fallback</p>
</td></tr></table>


<p class="paragraph-P7">The script attempts each in sequence until one succeeds.</p>
<p class="paragraph-Horizontal_20_Line"> </p><h2 class="paragraph-P2"><a id="a__Quick_Install_Summary__Debian_Ubuntu_Mint_"><span/></a>Quick Install Summary (Debian/Ubuntu/Mint)</h2>

<p class="paragraph-P8"><span class="text-Source_20_Text"><span class="text-T4">sudo</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">apt</span></span><span class="text-Source_20_Text"><span class="text-T5"> update</span></span></p>

<p class="paragraph-P9"><span class="text-Source_20_Text"><span class="text-T4">sudo</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">apt</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">install</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">bash</span></span><span class="text-Source_20_Text"><span class="text-T5"> python3 </span></span><span class="text-Source_20_Text"><span class="text-T4">zenity</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">curl</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip</span></span></p>
<h2 class="paragraph-P2"><a id="a__Quick_Install_Summary__Fedora_RHEL_CentOS_"><span/></a>Quick Install Summary (Fedora/RHEL/CentOS)</h2>

<p class="paragraph-P9"><span class="text-Source_20_Text"><span class="text-T4">sudo</span></span><span class="text-Source_20_Text"><span class="text-T5"> dnf </span></span><span class="text-Source_20_Text"><span class="text-T4">install</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">bash</span></span><span class="text-Source_20_Text"><span class="text-T5"> python3 </span></span><span class="text-Source_20_Text"><span class="text-T4">zenity</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">curl</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip</span></span></p>
<h2 class="paragraph-P2"><a id="a__Quick_Install_Summary__Arch_Manjaro_"><span/></a>Quick Install Summary (Arch/Manjaro)</h2>

<p class="paragraph-P9"><span class="text-Source_20_Text"><span class="text-T4">sudo</span></span><span class="text-Source_20_Text"><span class="text-T5"> pacman </span></span><span class="text-Source_20_Text"><span class="text-T4">-S</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">bash</span></span><span class="text-Source_20_Text"><span class="text-T5"> python3 </span></span><span class="text-Source_20_Text"><span class="text-T4">zenity</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">curl</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip</span></span></p>
<h2 class="paragraph-P2"><a id="a__Quick_Install_Summary__OpenSUSE_"><span/></a>Quick Install Summary (OpenSUSE)</h2>

<p class="paragraph-P9"><span class="text-Source_20_Text"><span class="text-T4">sudo</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">zypper</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">install</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">bash</span></span><span class="text-Source_20_Text"><span class="text-T5"> python3 </span></span><span class="text-Source_20_Text"><span class="text-T4">zenity</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">curl</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip</span></span></p>
<p class="paragraph-Horizontal_20_Line"> </p><h2 class="paragraph-P2"><a id="a__Verify_Your_Setup"><span/></a>Verify Your Setup</h2>

<p class="paragraph-P10"><span class="text-Source_20_Text"><span class="text-T6"># Check everything is available</span></span></p>

<p class="paragraph-P8"><span class="text-Source_20_Text"><span class="text-T4">which</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">bash</span></span><span class="text-Source_20_Text"><span class="text-T5"> python3 </span></span><span class="text-Source_20_Text"><span class="text-T4">zenity</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">curl</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip </span></span><span class="text-Source_20_Text"><span class="text-T4">sed</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">grep</span></span></p>
<p class="paragraph-P11"> </p>
<p class="paragraph-P10"><span class="text-Source_20_Text"><span class="text-T6"># Test clipboard</span></span></p>

<p class="paragraph-P8"><span class="text-Source_20_Text"><span class="text-T7">echo</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T8">"test"</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">|</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip </span></span><span class="text-Source_20_Text"><span class="text-T4">-selection</span></span><span class="text-Source_20_Text"><span class="text-T5"> clipboard </span></span><span class="text-Source_20_Text"><span class="text-T4">&amp;&amp;</span></span><span class="text-Source_20_Text"><span class="text-T5"> xclip </span></span><span class="text-Source_20_Text"><span class="text-T4">-o</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">-selection</span></span><span class="text-Source_20_Text"><span class="text-T5"> clipboard</span></span></p>
<p class="paragraph-P11"> </p>
<p class="paragraph-P10"><span class="text-Source_20_Text"><span class="text-T6"># Test Zenity works</span></span></p>

<p class="paragraph-P9"><span class="text-Source_20_Text"><span class="text-T4">zenity</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">--info</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T4">--text=</span></span><span class="text-Source_20_Text"><span class="text-T8">"If you see this, Zenity is OK"</span></span></p>
<p class="paragraph-Horizontal_20_Line"> </p><h2 class="paragraph-P2"><a id="a__Minimum_Viable_Configuration"><span/></a>Minimum Viable Configuration</h2>

<p class="paragraph-P7">If you want to run this on a minimal system (headless server without desktop):</p>


<table border="0" cellspacing="0" cellpadding="0" class="table-Table4"><colgroup><col width="167"/><col width="454"/></colgroup><tr class="row-Table4_1"><td style="text-align:left;width:1.5014in; " class="cell-Table4_A1">
<p class="paragraph-P3">Component</p>
</td><td style="text-align:left;width:4.0924in; " class="cell-Table4_A1">
<p class="paragraph-P3">Workaround</p>
</td></tr><tr class="row-Table4_1"><td style="text-align:left;width:1.5014in; " class="cell-Table4_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">zenity</span></span></p>
</td><td style="text-align:left;width:4.0924in; " class="cell-Table4_A1">
<p class="paragraph-P4"><span class="text-T2">Remove GUI prompts; replace with </span><span class="text-Source_20_Text"><span class="text-T3">read -p "Paste URL:"</span></span></p>
</td></tr><tr class="row-Table4_1"><td style="text-align:left;width:1.5014in; " class="cell-Table4_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">clipboard</span></span></p>
</td><td style="text-align:left;width:4.0924in; " class="cell-Table4_A1">
<p class="paragraph-P4"><span class="text-T2">Remove </span><span class="text-Source_20_Text"><span class="text-T3">copy_clip()</span></span><span class="text-T2"> function; just print the URL</span></p>
</td></tr><tr class="row-Table4_1"><td style="text-align:left;width:1.5014in; " class="cell-Table4_A1">
<p class="paragraph-P4"><span class="text-Strong_20_Emphasis"><span class="text-T1">browser auto-detect</span></span></p>
</td><td style="text-align:left;width:4.0924in; " class="cell-Table4_A1">
<p class="paragraph-P4"><span class="text-T2">Set </span><span class="text-Source_20_Text"><span class="text-T3">BRAVE_BIN</span></span><span class="text-T2"> explicitly before running</span></p>
</td></tr></table>


<p class="paragraph-P7">Modified CLI-only mode would look like:</p>

<p class="paragraph-P9"><span class="text-Source_20_Text"><span class="text-T4">BRAVE_BIN=</span></span><span class="text-Source_20_Text"><span class="text-T8">"/usr/bin/brave-browser"</span></span><span class="text-Source_20_Text"><span class="text-T5"> ./gmaps2brave.sh </span></span><span class="text-Source_20_Text"><span class="text-T4">&lt;&lt;&lt;</span></span><span class="text-Source_20_Text"><span class="text-T5"> </span></span><span class="text-Source_20_Text"><span class="text-T8">"https://www.google.com/maps/@54.201186,20.0812534,11z"</span></span></p>

<p class="paragraph-P7">(Though the current script expects interactive Zenity dialogs, so you'd need minor edits for headless operation.)</p>
<p class="paragraph-Horizontal_20_Line"> </p><p class="paragraph-P7"> </p><p class="paragraph-Standard"> </p></body>

---

## How To Use

#### Installation
Open terminal (Ctrl+Alt+T)\
chmod +x /path/to/Bravemaps.sh\
./Bravemaps.sh

[Back To The Top](#read-me-template)

---

## References
[Back To The Top](#read-me-template)

---

## License

                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

                            Preamble

  The GNU General Public License is a free, copyleft license for
software and other kinds of works.

  The licenses for most software and other practical works are designed
to take away your freedom to share and change the works.  By contrast,
the GNU General Public License is intended to guarantee your freedom to
share and change all versions of a program--to make sure it remains free
software for all its users.  We, the Free Software Foundation, use the
GNU General Public License for most of our software; it applies also to
any other work released this way by its authors.  You can apply it to
your programs, too.

[Back To The Top](#read-me-template)

-

[Back To The Top](#read-me-template)
