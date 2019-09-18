# Window Manager
## Demo
![](hammerspoon-demo.gif)

## Installation
1. Install [hammerspoon](https://github.com/Hammerspoon/hammerspoon/releases/tag/0.9.66)
1. Open hammerspoon
1. Click on the hammerspoon icon on the menu bar
1. Click **Open Config** and paste the contents of **init.lua** into the opened file  
1. Save the file and close it

## Changing the margin
At the top of the **init.lua** file, there is a variable called `MARGIN`. It sets how many pixels of empty space should be around the windows. I like mine around at around 5 or 10, but feel free to change it to whatever you like best.

## Actions

 Key          | Move the window to
--------------|-------------
`Command + 1` | left half
`Command + 2` | right half
`Command + 3` | full screen
`Command + 0` | next screen
`Command + 9` | previous screen
`Command + alt + s` | bottom right quadrant
`Command + alt + a` | bottom left quadrant
`Command + alt + w` | top right quadrant
`Command + alt + q` | top left quadrant
`Command + alt + t` | top half
`Command + alt + b` | bottom half
