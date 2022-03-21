# Installation

1. Install [pywal](https://github.com/dylanaraps/pywal)
1. Make a folder in the Pictures folder called **background**
1. In that folder, make two new ones
  * **light**
  * **dark**
1. Add this line to your bash environment file `(cat ~/.cache/wal/sequences | tr -d "\n" &)`
	* (You can find that line in the **bash_profile** on the main directory of this repo)
1. Open a terminal window and type the following commands in one by one
  1. `mkdir /usr/local/bin/scripts`
  1. `cp ui.sh /usr/local/bin/scripts/`
  1. `cd /usr/local/bin`
  1. `ln -s scripts/ui.sh ui`

Those commands:

1. makes a folder called scripts in /usr/local/bin
1. copies the ui script into the scripts folder
1. navigates to the bin directory
1. creates a link in the bin directory to the ui script so you can access it from the terminal regardless of which directory you are in

## Troubleshooting

If your background goes black and the dock no longer works, run the following:

```bash
rm  ~/Library/Application\ Support/Dock/desktoppicture.db
```
