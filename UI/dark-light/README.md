# Installation

1. Install [pywal](https://github.com/dylanaraps/pywal)
1. Make a folder in the Pictures folder called **background**
1. In that folder, make two new ones
  * **light**
  * **dark**
1. Create a folder called **scripts** in `/usr/local/bin`
1. Copy everything except this readme into `/usr/local/bin/scripts`
1. Open a terminal window and type the following commands in one by one
  1. `cd /usr/local/bin`
  1. `ln -s scripts/uiLight.sh uiLight`
  1. `ln -s scripts/uiDark.sh uiDark`


Those three commands

1. navigate to the bin directory
1. create a link in the bin directory to the uiLight script so you can access it from anywhere
1. do the same for the uiDark script