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


--left half
hs.hotkey.bind({"cmd"}, "1", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.x == max.x and f.y == max.y and f.h == (max.h - 5) and f.w == (max.w / 2) then
        screen = win:screen():next()
    end
    f.x = max.x
    f.y = max.y
    f.h = max.h
    f.w = max.w / 2

    win:setFrame(f)
end)

--right half
hs.hotkey.bind({"cmd"}, "2", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.h = max.h
    f.w = max.w / 2

    win:setFrame(f)
end)


--full screen
hs.hotkey.bind({"cmd"}, "3", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.h = max.h
    f.w = max.w

    win:setFrame(f)
end)


--top left
hs.hotkey.bind({"cmd", "alt"}, "Q", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.h = max.h / 2
    f.w = max.w / 2

    win:setFrame(f)
end)


--bottom left
hs.hotkey.bind({"cmd", "alt"}, "A", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.h = max.h / 2
    f.w = max.w / 2

    win:setFrame(f)
end)

--top right
hs.hotkey.bind({"cmd", "alt"}, "W", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.h = max.h / 2
    f.w = max.w / 2

    win:setFrame(f)
end)


--bottom right
hs.hotkey.bind({"cmd", "alt"}, "S", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y + (max.h / 2)
    f.h = max.h / 2
    f.w = max.w / 2

    win:setFrame(f)
end)

--bottom
hs.hotkey.bind({"cmd", "alt"}, "B", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.h = max.h / 2
    f.w = max.w

    win:setFrame(f)
end)

--top
hs.hotkey.bind({"cmd", "alt"}, "T", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.h = max.h / 2
    f.w = max.w

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
