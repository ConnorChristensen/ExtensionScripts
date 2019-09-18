-- This variable sets how many pixels of empty space should be around the windows
MARGIN = 10

function getContext()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    return win, f, screen, max
end

function nextScreen()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen():next()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y

    win:setFrame(f)
end

function previousScreen()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen():previous()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y

    win:setFrame(f)
end

function max_x(max)
    return max.x + MARGIN
end

function max_y(max)
    return max.y + MARGIN
end

function max_h(max)
    return max.h - (MARGIN * 2)
end

function max_w(max)
    return max.w - (MARGIN * 2)
end

function half_w(max)
    return (max_w(max) / 2) - MARGIN
end

function half_h(max)
    return (max_h(max) / 2) - MARGIN
end

--left half
hs.hotkey.bind({"cmd"}, "1", function()
    local win, f, screen, max = getContext()

    if f.x == max_x(max) and f.y == max_y(max) and f.h == max_h(max) and f.w == half_w(max) then
        nextScreen()
        win, f, screen, max = getContext()
    end

    f.x = max_x(max)
    f.y = max_y(max)
    f.h = max_h(max)
    f.w = half_w(max)

    win:setFrame(f)
end)

--right half
hs.hotkey.bind({"cmd"}, "2", function()
    local win, f, screen, max = getContext()

    if f.x == max.x + (max.w / 2) and f.y == max_y(max) and f.h == max_h(max) and f.w == half_w(max) then
        nextScreen()
        win, f, screen, max = getContext()
    end

    f.x = max_x(max) + (max.w / 2)
    f.y = max_y(max)
    f.h = max_h(max)
    f.w = half_w(max)

    win:setFrame(f)
end)


--full screen
hs.hotkey.bind({"cmd"}, "3", function()
    local win, f, screen, max = getContext()

    if f.x == max_x(max) and f.y == max_y(max) and f.h == max_h(max) and f.w == max.w then
        nextScreen()
        win, f, screen, max = getContext()
    end

    f.x = max_x(max)
    f.y = max_y(max)
    f.h = max_h(max)
    f.w = max_w(max)
    win:setFrame(f)

end)

--left third
hs.hotkey.bind({"cmd", "alt"}, "1", function()
    local win, f, screen, max = getContext()
    f.x = max_x(max)
    f.y = max_y(max)
    f.h = max_h(max)
    f.w = max.w / 3

    win:setFrame(f)
end)

--middle third
hs.hotkey.bind({"cmd", "alt"}, "2", function()
    local win, f, screen, max = getContext()
    f.x = max_x(max) + (max.w / 3)
    f.y = max_y(max)
    f.h = max_h(max)
    f.w = max.w / 3

    win:setFrame(f)
end)

--right third
hs.hotkey.bind({"cmd", "alt"}, "3", function()
    local win, f, screen, max = getContext()
    f.x = max.x + ((max.w / 3) * 2)
    f.y = max_y(max)
    f.h = max_h(max)
    f.w = max.w / 3

    win:setFrame(f)
end)


--top left
hs.hotkey.bind({"cmd", "alt"}, "Q", function()
    local win, f, screen, max = getContext()

    f.x = max_x(max)
    f.y = max_y(max)
    f.h = half_h(max)
    f.w = half_w(max)

    win:setFrame(f)
end)


--bottom left
hs.hotkey.bind({"cmd", "alt"}, "A", function()
    local win, f, screen, max = getContext()

    f.x = max_x(max)
    f.y = max_y(max) + (max.h / 2)
    f.h = half_h(max)
    f.w = half_w(max)

    win:setFrame(f)
end)

--top right
hs.hotkey.bind({"cmd", "alt"}, "W", function()
    local win, f, screen, max = getContext()

    f.x = max_x(max) + (max.w / 2)
    f.y = max_y(max)
    f.h = half_h(max)
    f.w = half_w(max)

    win:setFrame(f)
end)


--bottom right
hs.hotkey.bind({"cmd", "alt"}, "S", function()
    local win, f, screen, max = getContext()

    f.x = max_x(max) + (max.w / 2)
    f.y = max_y(max) + (max.h / 2)
    f.h = half_h(max)
    f.w = half_w(max)

    win:setFrame(f)
end)

--bottom
hs.hotkey.bind({"cmd", "alt"}, "B", function()
    local win, f, screen, max = getContext()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.h = max.h / 2
    f.w = max_w(max)

    win:setFrame(f)
end)

--top
hs.hotkey.bind({"cmd", "alt"}, "T", function()
    local win, f, screen, max = getContext()

    f.x = max_x(max)
    f.y = max_y(max)
    f.h = max.h / 2
    f.w = max_w(max)

    win:setFrame(f)
end)

--next screen
hs.hotkey.bind({"cmd"}, "0", function()
    nextScreen()
end)

--previous screen
hs.hotkey.bind({"cmd"}, "9", function()
    previousScreen()
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
