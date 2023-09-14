-- HAMMERSPOON CONFIGURATION: {{{1
-- vim: foldmethod=marker:foldlevel=0:nofoldenable:
-- Sri Kadimisetty
--
-- NOTE:
--  - Should be present in `~/.hammerspoon/init.lua`
--  - Key code names: https://www.hammerspoon.org/docs/hs.keycodes.html#map
--  - Preferred hyperkey combo choices:
--      1. 'alt', 'cmd'
--      2. 'ctrl', 'alt', 'cmd'

-- UTILITIES {{{1

-- Reload hammerspoon config {{{2
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "r", function()
  hs.reload()
end)
hs.alert.show("hammerspoon config loaded")

-- WINDOW MANAGEMENT {{{1
-- Maximize focussed window in current screen (not macos's full screen)  {{{2
hs.hotkey.bind({ "cmd", "alt" }, "f", function()
  hs.window.focusedWindow():maximize()
end)

-- Center focussed window in screen (no resizing) {{{2
hs.hotkey.bind({ "cmd", "alt" }, "c", function()
  toScreen = nil
  inBounds = true
  -- SEE: http://www.hammerspoon.org/docs/hs.window.html#centerOnScreen
  hs.window.focusedWindow():centerOnScreen(toScreen, inBounds)
end)

-- Make focussed window left half of screen {{{2
hs.hotkey.bind({ "cmd", "alt" }, "left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Make focussed window right half of screen {{{2
hs.hotkey.bind({ "cmd", "alt" }, "right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Make focussed window top half of screen {{{2
hs.hotkey.bind({ "cmd", "alt" }, "up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Make focussed window bottom half of screen {{{2
hs.hotkey.bind({ "cmd", "alt" }, "down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- LAUNCHERS {{{1

-- Launch new Finder window {{{2
-- TODO: Make Finder open in an expected location like `~/Downloads`
hs.hotkey.bind({ "shift", "alt" }, "return", function()
  hs.osascript.applescript([[
    tell application "Finder"
      make new Finder window
      activate
    end tell
  ]])
end)

-- Launch new Safari window {{{2
hs.hotkey.bind({ "alt", "cmd" }, "return", function()
  hs.osascript.applescript([[
    tell application "Safari"
      make new document
      activate
    end tell 
  ]])
end)

-- Launch new iTerm window {{{2
hs.hotkey.bind({ "shift", "cmd" }, "return", function()
  hs.osascript.applescript([[
    if application "iTerm" is running then
        tell application "iTerm"
          create window with default profile
        end tell
    else
        tell application "iTerm"
          activate
        end tell
    end if
  ]])
end)

-- TODO: launch iTerm window with custom workspace setup {{{2
-- e.g. (EDITOR(1 split) + SHELL(2 splits))
