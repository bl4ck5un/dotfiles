# Fonts and fnt

[fnt](https://github.com/alexmyczko/fnt) installs fonts from Debian and Google
Fonts into your user font directory.

## Ask an agent to set up another machine

Copy this prompt, adjusting the checkout path:

> Read `fonts/README.md` in my dotfiles checkout and set up fnt for my user.
> Check the OS, current upstream installation instructions, and dependencies.
> Follow the setup instructions below for a user-local installation.
> Ensure `~/.local/bin` is on my persistent shell PATH. Initialize and validate
> the catalog, then verify `fnt info` and `fnt search agave`. If I also ask for
> my Fedora font selection, install the 11 Google font families in the table below
> and refresh the font cache. Report anything that could not be installed.

## Setup instructions for agents

1. Inspect the OS, existing `fnt` installation, shell PATH, and dependencies.
   Read the current upstream README, Makefile, and `fnt` source before installing.
2. On Linux, install missing dependencies as described below. Download the
   upstream `fnt` and `fnt.1` from the same revision into a temporary directory.
   Record the revision used and check the script with `bash -n`.
3. As the normal user, create `~/.local/bin`, `~/.local/share/man/man1`, and
   `${XDG_DATA_HOME:-$HOME/.local/share}/fonts`. Install `fnt` with mode 755
   into `~/.local/bin` and `fnt.1` with mode 644 into the manual directory.
4. Ensure `~/.local/bin` is on both the current and persistent shell PATH.
   Run `fnt help` and `fnt update`. Validate `Packages.xz`, `APACHE.xz`, and
   `OFL.xz` under `${XDG_DATA_HOME:-$HOME/.local/share}/fnt` with `xz -t`.
5. Verify `fnt info` and `fnt search agave`. Report the installed version,
   locations, and catalog counts. Install font families only when requested.

Required commands: Bash, curl, ar, awk, sed, file, tar, xz/unxz/xzcat, md5sum,
install, and otfinfo. Fontconfig supplies `fc-cache` for refreshing fonts.

- **Fedora:** install `otfinfo` with `sudo dnf install lcdf-typetools`.
  If sudo is unavailable, download the official Fedora `lcdf-typetools`
  provider using `dnf download` (on this machine, `texlive-lcdftypetools`).
  Verify the RPM with `rpm -K`, extract `./usr/bin/otfinfo` with `rpm2cpio`
  and `cpio` into a temporary directory, check its libraries with `ldd`, and
  verify `otfinfo --version` before installing it into `~/.local/bin`.
  This fallback needs no sudo, but the extracted binary is not managed by DNF.
- **Debian/Ubuntu:** install missing dependencies with
  `sudo apt install curl binutils gawk sed file tar xz-utils coreutils lcdf-typetools fontconfig`.
- **Other Linux distributions:** install the commands above using the native
  package manager before installing fnt.
- **macOS:** follow the upstream installation
  instructions, using Homebrew for dependencies. Have the agent inspect the
  current upstream requirements and verify the result on that machine.

Add this line to your shell startup file if needed (`~/.zshrc` for Zsh or
`~/.bashrc` for Bash), then open a new shell:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

Linux fonts go into `${XDG_DATA_HOME:-$HOME/.local/share}/fonts`; the catalog
and installation records live in the adjacent `fnt` directory. Existing fonts
are not imported into fnt's installation records. Set up shell completion or
optional terminal preview tools if requested.

```sh
fnt search agave
fnt install agave
fc-cache -f
fnt list
fnt update
```

## Fedora font matches

This table preserves the font selection from the former Fedora package list.
All names below were found in the local fnt catalog
on 2026-09-14 (fnt 1.9.1). These are family matches, not guarantees of identical
versions, file formats, or Fedora package contents.

| Fedora package (without `.noarch`) | fnt match / meaning |
| --- | --- |
| `ibm-plex-fonts-all` | Aggregate package; use the eight IBM Plex entries below. `fonts-ibm-plex` is also available as a Debian bundle, whose contents/version may differ. |
| `ibm-plex-mono-fonts` | `google-ibmplexmono` |
| `ibm-plex-sans-arabic-fonts` | `google-ibmplexsansarabic` |
| `ibm-plex-sans-devanagari-fonts` | `google-ibmplexsansdevanagari` |
| `ibm-plex-sans-fonts` | `google-ibmplexsans` |
| `ibm-plex-sans-hebrew-fonts` | `google-ibmplexsanshebrew` |
| `ibm-plex-sans-thai-fonts` | `google-ibmplexsansthai` |
| `ibm-plex-sans-thai-looped-fonts` | `google-ibmplexsansthailooped` |
| `ibm-plex-serif-fonts` | `google-ibmplexserif` |
| `mozilla-fira-fonts-common` | Shared packaging files; no separate font family to install. |
| `mozilla-fira-mono-fonts` | `google-firamono` |
| `mozilla-fira-sans-fonts` | `google-firasans` |
| `google-roboto-fonts` | `google-roboto`; Debian's `fonts-roboto` is also available. |

When asked to install this selection, recheck each of the 11 `google-` names
in the table against the current catalog, run `fnt install NAME` for each,
then run `fc-cache -f`. Report missing matches or installation failures.

Use `fnt list index` to see families managed by fnt. Installing these families
alongside Fedora's RPM fonts can create duplicate families; choose which
installation you want to maintain. The mapping itself does not install or
remove any fonts.
