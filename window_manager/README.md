# Window Manager
## Demo
![](hammerspoon-demo.gif)

## Installation
1. Install [hammerspoon](https://www.hammerspoon.org/) with `brew cask install hammerspoon`
1. `rm ~/.hammerspoon/init.lua` - Remove the existing blank config
1. `ln -s $(pwd)/init.lua ~/.hammerspoon/init.lua`

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
`Command + alt + \` | open grid
`Command + alt + 1` | left most column
`Command + alt + 2` | center left column
`Command + alt + 3` | center right column
`Command + alt + 4` | right most quadrant
`Command + alt + j` | move window a column left
`Command + alt + k` | move window a column down
`Command + alt + l` | move window a column up
`Command + alt + ;` | move window a column right
`Command + alt + m` | make window a column thinner
`Command + alt + ,` | make window a column taller
`Command + alt + .` | make window a column shorter
`Command + alt + /` | make window a column wider
