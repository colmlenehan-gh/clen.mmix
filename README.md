# clen.mmix

A harmless terminal "hacker typer" for macOS. Open Terminal, launch it, mash the
keyboard, and realistic command-line sessions appear in your normal Terminal
window. It uses your default Terminal colours and fonts, with no menus, no bar
and no links.

```
clen.mmix/start
```

## What it is, and what it is not

Every command and every line of output is **pre-written text** stored in
`scenes/*.scn`. The program only prints it. It never executes a command, never
opens a network connection, never reads or changes your files, and never passes
anything you type to a shell.

The sessions use ordinary sysadmin and developer commands (`ssh`, `rsync`,
`tcpdump`, `cmake`, `kubectl`, `brew`, and similar) run against fictional hosts.
Every address is from the reserved documentation ranges (`192.0.2.0/24`,
`198.51.100.0/24`, `203.0.113.0/24`) or the fictional domain `corp.example`.
There are no exploits, no password cracking and no step-by-step attack
material, so it cannot teach anyone to break into anything. It is a prop.

## Install (macOS)

Requirements: macOS with Terminal. bash is already included. Git comes with the
Xcode command line tools (`xcode-select --install`).

Option 1, from a clone of this repository:

```
git clone https://github.com/OWNER/clen.mmix.git
cd clen.mmix
./install.sh
```

Option 2, one line:

```
curl -fsSL https://raw.githubusercontent.com/OWNER/clen.mmix/main/install.sh | bash
```

Replace `OWNER` with the GitHub account that hosts the repository.

The installer places the project at `~/clen.mmix`. Terminal opens in your home
folder, so from a new window the launch command works exactly as written:

```
clen.mmix/start
```

If you are in another folder, use `~/clen.mmix/start`.

## Controls

| Key | Effect |
| --- | --- |
| Any key | Reveals the next few characters or lines |
| Tab | Flashes an `ACCESS GRANTED` banner |
| Backtick (`` ` ``) | Flashes an `ACCESS DENIED` banner |
| Ctrl-C or Ctrl-D | Quit |

Options:

```
clen.mmix/start --speed 6     # characters per keypress, 1-12 (default 3)
clen.mmix/start --help
```

The prompt uses your real username and Mac hostname in the default zsh style
(`name@host ~ %`). Override them with `CLEN_USER` and `CLEN_HOST` if you prefer.

## Adding your own scenes

Drop a `.scn` file into `scenes/`. The format is line based:

| Line | Meaning |
| --- | --- |
| `# text` | Comment |
| `$ command` | A command, typed out as you press keys. `cd` updates the prompt. |
| `\| text` | A line of output (a bare `\|` is a blank line) |
| `@bar Label` | An animated progress bar advanced by keypresses |
| `@prompt deploy@host:~$` | Switch to a "remote" prompt. A bare `@prompt` resets it. |

`{{USER}}` and `{{HOST}}` are replaced with the local user and host names. Start
every scene with a `$` line and use fictional hosts only.

## Uninstall

```
~/clen.mmix/install.sh --uninstall
```

## Licence

MIT. See `LICENSE`.
