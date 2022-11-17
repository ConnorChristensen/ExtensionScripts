-- This variable sets how many pixels of empty space should be around the windows
MARGIN = 9
-- The number of pixels between the top of the screen and the top of the grid
TOPGAP = 50

function getActiveWindow()
    return hs.window.focusedWindow()
end

function getGrid()
    local win = getActiveWindow()
    local screen = win:screen()
    local max = screen:frame()

    -- when using multiple monitors, some screens may start at non-zero x and y coordinates
    -- in that case, the starting x and y values on the geometry to define the window need
    -- to take into account the absolute x and y values of the top left corner of the screen.
    -- max.x and max.y will be the distance in pixels from the top left corner of the primary
    -- monitor.
    local geo = hs.geometry.new(max.x, max.y + TOPGAP, max.w, max.h - TOPGAP)
    local margin = hs.geometry(nil, nil, MARGIN, MARGIN)
    return hs.grid.setGrid('4x4', screen, geo).setMargins(margin)
end

function getContext()
    local win = getActiveWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    return win, f, screen, max, getGrid()
end

function moveWindowOneScreenRight()
    getActiveWindow():moveOneScreenEast(false, false, 0.4)
end

function moveWindowOneScreenLeft()
    getActiveWindow():moveOneScreenWest(false, false, 0.4)
end

hs.hotkey.bind({"cmd", "alt"}, "j", function() getGrid().pushWindowLeft() end)
hs.hotkey.bind({"cmd", "alt"}, "k", function() getGrid().pushWindowDown() end)
hs.hotkey.bind({"cmd", "alt"}, "l", function() getGrid().pushWindowUp() end)
hs.hotkey.bind({"cmd", "alt"}, ";", function() getGrid().pushWindowRight() end)

hs.hotkey.bind({"cmd", "alt"}, "m", function() getGrid().resizeWindowThinner() end)
hs.hotkey.bind({"cmd", "alt"}, ",", function() getGrid().resizeWindowTaller() end)
hs.hotkey.bind({"cmd", "alt"}, ".", function() getGrid().resizeWindowShorter() end)
hs.hotkey.bind({"cmd", "alt"}, "/", function() getGrid().resizeWindowWider() end)

--left half
hs.hotkey.bind({"cmd"}, "1", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(0, 0, 2, 4))
end)

--right half
hs.hotkey.bind({"cmd"}, "2", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(2, 0, 2, 4))
end)


--full screen
hs.hotkey.bind({"cmd"}, "3", function()
  -- defaults to the focused window
  getGrid().maximizeWindow()
end)

--left-quarter
hs.hotkey.bind({"cmd", "alt"}, "1", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(0, 0, 1, 4))
end)

--middle-left-quarter
hs.hotkey.bind({"cmd", "alt"}, "2", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(1, 0, 1, 4))
end)

--middle-right-quarter
hs.hotkey.bind({"cmd", "alt"}, "3", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(2, 0, 1, 4))
end)

--right-quarter
hs.hotkey.bind({"cmd", "alt"}, "4", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(3, 0, 1, 4))
end)

--top left
hs.hotkey.bind({"cmd", "alt"}, "Q", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(0, 0, 2, 2))
end)


--bottom left
hs.hotkey.bind({"cmd", "alt"}, "A", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(0, 2, 2, 2))
end)

--top right
hs.hotkey.bind({"cmd", "alt"}, "W", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(2, 0, 2, 2))
end)


--bottom right
hs.hotkey.bind({"cmd", "alt"}, "S", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(2, 2, 2, 2))
end)

--bottom
hs.hotkey.bind({"cmd", "alt"}, "B", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(0, 2, 4, 2))
end)

--top
hs.hotkey.bind({"cmd", "alt"}, "T", function()
    local win, f, screen, max, grid = getContext()
    grid.set(win, hs.geometry.new(0, 0, 4, 2))
end)

-- move window to the screen on the right
hs.hotkey.bind({"cmd"}, "0", function()
    moveWindowOneScreenRight()
end)

-- move window to the screen on the left
hs.hotkey.bind({"cmd"}, "9", function()
    moveWindowOneScreenLeft()
end)

-- grid
-- bound to the hotkeys: cmd + alt + \
hs.hotkey.bind({"cmd", "alt"}, "\\", function()
    local grid = getGrid()
    grid.ui.highlightColor = {0.552, 0.643, 0.776, 0.4}
    grid.ui.highlightStrokeColor = {0.552, 0.643, 0.776, 0.8}
    grid.ui.textSize = 80
    grid.show()
end)


--auto reload the configuration file on save
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
