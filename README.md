# iTerm Color Schemes

- [Intro](#intro)
- [Installation Instructions](#installation-instructions)
- [Contribute](#contribute)
- [Credits](#credits)
- [Extra](#extra)
  - [Previewing color schemes](#previewing-color-schemes)

## Intro

This is a set of color schemes for iTerm (aka iTerm2). It also includes ports to Terminal, Konsole, PuTTY, Xresources, XRDB, Remmina, Termite, XFCE, Tilda, FreeBSD VT, Terminator, Kitty, Ghostty, Otty, MobaXterm, LXTerminal, Microsoft's Windows Terminal, Visual Studio, Alacritty, Vim

## Installation Instructions

There are 3 ways to install an iTerm theme:

- Direct way via keyboard shortcut:



  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Type CMD+i (⌘+i)
  - Navigate to **Colors** tab
  - Click on **Color Presets**
  - Click on **Import**
  - Click on the **schemes** folder
  - Select the **.itermcolors** profiles you would like to import
  - Click on **Color Presets** and choose a color scheme

- Via iTerm preferences (go to the same configuration location as above):

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Click on **iTerm2** menu title
  - Select **Preferences...** option
  - Select **Profiles**
  - Navigate to **Colors** tab
  - Click on **Color Presets**
  - Click on **Import**
  - Select the .itermcolors file(s) of the [schemes](schemes/) you'd like to use \* Click on **Color Presets** and choose a color scheme

- Via Bash script

  - Launch iTerm 2. Get the latest version at <a href="http://www.iterm2.com">iterm2.com</a>
  - Run the following command:

  ```sh
  # Import all color schemes
  tools/import-scheme.sh schemes/*

  # Import all color schemes (verbose mode)
  tools/import-scheme.sh -v schemes/*

  # Import specific color schemes (quotations are needed for schemes with spaces in name)
  tools/import-scheme.sh 'schemes/SpaceGray Eighties.itermcolors' # by file path
  tools/import-scheme.sh 'SpaceGray Eighties'       # by scheme name
  tools/import-scheme.sh Molokai 'SpaceGray Eighties'     # import multiple
  ```

  - Restart iTerm 2. (Need to quit iTerm 2 to reload the configuration file.)

## Contribute

### Using Docker

If docker is installed, the script `generate-all.sh` will do most of the
steps described in [Prerequisites](#prerequisites), except for the instructions
related to `pyenv` as this is not required in a docker container dedicated to
generating the required files.

With docker, there is no need to install python and its dependencies on your
computer.

The remaining manual tasks are to update `README.md` to include your theme and
screenshot, and to update `CREDITS.md` to credit yourself for your contribution.

#### Debugging using Docker

In cases where new tools have to be tested, `./generate-all.sh debug` will start
an interactive terminal session inside the container.

### Prerequisites

1. For convenient work with generation scripts, it is recommended to install [pyenv](https://github.com/pyenv/pyenv).
2. Run `pyenv install` inside project folder to install python version from `.python-version` file.
3. Run `pip install -r requirements.txt` to install the project dependencies.

### How to add new theme

Have a great theme? Send it to me via a Pull Request!

#### Theme naming

Name source files exactly as the theme should be displayed. Use the human-readable
name — no slugification, no replacing spaces with underscores.

- iTerm2: `schemes/Your Theme Name.itermcolors`
- YAML: `yaml/Your Theme Name.yml` (see [yaml/README.md](/yaml/README.md))

Quote names with spaces in shell commands: `python3 tools/gen.py -s "Your Theme Name"`.

#### Have an iTerm theme?

1. Get your theme's`.itermcolors` file.
   - Launch iTerm 2
   - Type CMD+i (⌘+i)
   - Navigate to **Colors** tab
   - Click on **Color Presets**
   - Click on **Export**
   - Save the .itermcolors file
2. Put your theme file into `/schemes/`, named as you want it displayed.
   - `mv <your-itermcolors-file> schemes/"Your Theme Name.itermcolors"`

#### Have a theme in another format?

1. Convert it to the YAML format specified in [yaml/README.md](/yaml/README.md).
   This is an extension of the format supported by the [Gogh](https://github.com/Gogh-Co/Gogh/) project.
   - If it helps, you can use `tools/kitty_to_yaml.py` and `tools/ghostty_to_yaml.py`.
     These tools accept configuration file streamed into stdin, and output a YAML fragment to stdout.
2. Put the YAML file in `yaml/` as `Your Theme Name.yml`.

#### Test your theme

1. Generate other formats for your theme using the `gen.py` script.
   - `python3 tools/gen.py -s "Your Theme Name"`
2. Optionally check WCAG contrast (`.itermcolors` only; YAML themes must be generated first).
   - `python3 tools/wcag_check.py -s "Your Theme Name"`
   - Failing checks are OK — `gen.py` may adjust colors during generation to meet the minimum contrast threshold (1.75:1).

#### Add a licence entry

1. Add an entry for your theme to `licenses.yml`, under its display name:

   ```yaml
   Your Theme Name:
     license: MIT
     source: https://github.com/you/your-theme
   ```

   - `license` is an [SPDX identifier](https://spdx.org/licenses/) or an SPDX expression of them, such as `MIT OR Apache-2.0`. Use `unknown` if there is no licence and `nonfree` if the licence does not allow redistribution.
   - `source` links to where the theme or its licence comes from (use `''` if there is none). An optional `note` can explain anything unusual.
2. Check the file with `python3 tools/check_licenses.py`. A pull request that adds a theme without an entry fails this check.

Scripts that add, rename or remove themes (such as the daily sync) can keep `licenses.yml` in step with `tools/set_license.py`, which leaves every other entry untouched and keeps the alphabetical order:

- `python3 tools/set_license.py set "Your Theme Name" --license MIT --source https://github.com/you/your-theme`
- `python3 tools/set_license.py rename "Old Name" "New Name"`
- `python3 tools/set_license.py remove "Old Name"`

#### Update `CREDITS.md` (optional)

1. Update `CREDITS.md` to credit yourself for your contribution.

### Packaging only redistributable themes

`licenses.yml` records the licence of every theme. Packagers who can only ship themes with a known open licence can generate that subset into a directory of their choice, leaving out every theme marked `unknown` or `nonfree`:

- `cd tools/ && python3 gen.py --redistributable -o /path/to/output`

Without `--redistributable` and `-o`, `gen.py` behaves as before and writes every theme into the repository.

### How to add new template

Do you want to convert existing iTerm themes to themes for your favorite terminal/editor/etc?

1. Get config file from your terminal/editor/etc.
2. Change actual colors in config to template placeholders from the list below.

```
  {{ Background_Color }}
  {{ Bold_Color }}
  {{ Cursor_Color }}
  {{ Cursor_Text_Color }}
  {{ Foreground_Color }}
  {{ Selected_Text_Color }}
  {{ Selection_Color }}
  {{ Ansi_0_Color }} // black
  {{ Ansi_1_Color }} // red
  {{ Ansi_2_Color }} // green
  {{ Ansi_3_Color }} // yellow
  {{ Ansi_4_Color }} // blue
  {{ Ansi_5_Color }} // magenta
  {{ Ansi_6_Color }} // cyan
  {{ Ansi_7_Color }} // white
  {{ Ansi_8_Color }} // bright black
  {{ Ansi_9_Color }} // bright red
  {{ Ansi_10_Color }} // bright green
  {{ Ansi_11_Color }} // bright yellow
  {{ Ansi_12_Color }} // bright blue
  {{ Ansi_13_Color }} // bright magenta
  {{ Ansi_14_Color }} // bright cyan
  {{ Ansi_15_Color }} // bright white

  Each color has these fields:
 - {{ Background_Color.hex }} for hex representation
 - {{ Background_Color.rgb }} for rgb representation as a "(r, g, b)" string
 - {{ Backgroun_Color.guint16 }} for guint16 representation

  Also you have access to this metadata fields:
 - {{ Guint16_Palette }} with a string containing all ansi colors as guint16 values
 - {{ Dark_Theme }} which contains a sign that the theme is dark
```

3. If you need a new value type for color, add it too `tools/converter.py`
4. Put your template file into `tool/templates`. A folder with schemas will be created based on the filename. And the file extension will remain with all generated ones. Example: `editor.ext` file will generate schemas as `editor/scheme_name.ext`
5. Generate all existing themes for all templates `cd tools/ && ./gen.py`. Or, if you only want to generate schemas for your template, you can use the `-t` flag.

- `./gen.py -t kitty`

6. If in the process you had to add new dependencies or update the version of python, do not forget to indicate this in `requirements.txt` or `.python-version`.

## Credits

- The schemes [_Novel_](#novel), [_Espresso_](#espresso), [_Grass_](#grass), [_Homebrew_](#homebrew), [_Ocean_](#ocean), [_Pro_](#pro), [_Man Page_](#man-page), [_Red Sands_](#red-sands), and [_Terminal Basic_](#terminal-basic) are ports of the schemes of the same name included with the Mac Terminal application. All of Terminal's schemes have now been ported, with the exception of _Solid Colors_ (random backgrounds, which iTerm doesn't support) and _Aerogel_ (which is hideous).
- The schemes [_iTerm2 Default_](#iterm2-default), [_iTerm2 Dark Background_](#iterm2-dark-background), [_iTerm2 Light Background_](#iterm2-light-background), [_iTerm2 Pastel (Dark Background)_](#iterm2-pastel-dark-background), [_iTerm2 Smoooooth_](#iterm2-smoooooth), [_iTerm2 Solarized Dark_](#iterm2-solarized-dark), [_iTerm2 Solarized Light_](#iterm2-solarized-light), [_iTerm2 Tango Dark_](#iterm2-tango-dark), and [_iTerm2 Tango Light_](#iterm2-tango-light) are ports from the built-in color schemes of iTerm2 (current source is iTerm2 v3.4.19).
- Credits for all other themes are listed in [CREDITS.md](./CREDITS.md)

If there are other color schemes you'd like to see included, drop me a line!

## Extra

### Previewing color schemes

[preview_theme.py](tools/preview_theme.py) renders a full visual preview in the
terminal using inline truecolor escape codes. It does **not** modify your
terminal palette — safe to run in any truecolor-capable terminal (iTerm2, Kitty,
WezTerm, Ghostty, Cursor, etc.).

```sh
# Preview by scheme name
python3 tools/preview_theme.py -s "Your Theme Name"

# Preview from source files
python3 tools/preview_theme.py schemes/Molokai.itermcolors
python3 tools/preview_theme.py yaml/Clear Dark.yml

# Browse multiple themes: ← → navigate, q quit
python3 tools/preview_theme.py -s "Molokai" "Dracula"
```

The preview shows the ANSI palette, surface colors (foreground, background,
selection, cursor), and semantic samples (errors, git status, directory listing).

#### Live palette preview (mutates terminal colors)

[preview-generic.sh](tools/preview-generic.sh) applies OSC 4 palette changes by
sourcing shell scripts from `generic/`. Use this only when you want the current
session recolored.

```sh
bash generic/Molokai.sh
./tools/preview-generic.sh generic/Molokai.sh generic/Dracula.sh
```

[preview.rb](tools/preview.rb) is deprecated (broken on current `.itermcolors`
files). Prefer `preview_theme.py`.

---

iTerm Color Schemes | iTerm2 Color Schemes | iTerm 2 Color Schemes | iTerm Themes | iTerm2 Themes | iTerm 2 Themes
