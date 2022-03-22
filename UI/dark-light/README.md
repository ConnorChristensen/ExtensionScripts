# Installation

1. Install [pywal](https://github.com/dylanaraps/pywal)
1. `mkdir ~/Pictures/dark ~/Pictures/light` - Make a light and dark folder
1. Put some pictures in those folders
1. Add `(cat ~/.cache/wal/sequences | tr -d "\n" &)` to `~/.zshrc`
1. `ln -si ui.sh /usr/local/bin/ui`

## Usage

Run `ui --help` to see usage information

## Troubleshooting

If your background goes black and the dock no longer works, run the following
command

```bash
rm  ~/Library/Application\ Support/Dock/desktoppicture.db
```
