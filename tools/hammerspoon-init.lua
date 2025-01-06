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
-- NOTE: Currently disabling for Key conflict with Robofont layer navigation
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
-- NOTE: Currently disabling for Key conflict with Robofont layer navigation
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

-- SPACES {{{1
-- Helper to switch to given space id in current screen {{{2
-- TODO: show "human readable name" ofg screen in alert?
-- TODO: make switching to 1..9 spaces use the same code
local switchToSpaceIdInCurrentScreen = function(spaceIdInCurrentScreen)
  hs.spaces.gotoSpace(spaceIdInCurrentScreen)
  -- NOTE:
  --  1. `escape` to leave activated mission control.
  --  2. Increasing default delay(200ms) to give more time
  --      to leave mission control.
  hs.eventtap.keyStroke({}, "escape", 600000)
end

-- Switch to space by index (1-9) {{{2
for idx, val in ipairs(hs.spaces.spacesForScreen(hs.screen.mainScreen())) do
  hs.hotkey.bind({ "ctrl", "alt" }, tostring(idx), function() -- first
    switchToSpaceIdInCurrentScreen(val)
  end)
end

-- Switch to last space (0) {{{2
hs.hotkey.bind({ "ctrl", "alt" }, "0", function()
  local allSpacesInCurrentScreen =
    hs.spaces.spacesForScreen(hs.screen.mainScreen())
  local lastSpaceInCurrentScreen =
    allSpacesInCurrentScreen[#allSpacesInCurrentScreen]
  switchToSpaceIdInCurrentScreen(lastSpaceInCurrentScreen)
end)

-- Carry focussed winow to rightwards space {{{2
-- FIXME:
hs.hotkey.bind({ "ctrl", "alt" }, "right", function()
  local allSpacesInCurrentScreen =
    hs.spaces.spacesForScreen(hs.screen.mainScreen())
  local currentSpaceId = hs.spaces.focusedSpace()
  for idx, val in ipairs(allSpacesInCurrentScreen) do
    if val == currentSpaceId then
      -- TODO: check if there is another space to the right
      -- TODO: check if this is a regular space and not
      if idx < #allSpacesInCurrentScreen then
        -- switch to the next screen id in allSpacesInCurrentScreen
        -- switchToSpaceIdInCurrentScreen(allSpacesInCurrentScreen[idx + 1])
        hs.alert.show("RIGHT SPACE ID: ")
        hs.alert.show(allSpacesInCurrentScreen[idx + 1])
        -- TODO: Move window
        -- hs.spaces.moveWindowToSpace(window, spaceID[, force]) -> true | nil, error
      end
    end
  end
end)

-- Carry focussed winow to leftwards space {{{2
-- TODO:

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

-- Launch new kitty window {{{2
hs.hotkey.bind({ "shift", "cmd" }, "return", function()
  hs.osascript.applescript([[
    if application "kitty" is not running then
      tell application "kitty" to activate
    else
      tell application "System Events" to tell process "kitty"
        click menu item "New OS Window" of menu 1 of menu bar item "Shell" of menu bar 1
      end tell
    end if
  ]])
end)

-- TODO: launch iTerm window with custom workspace setup {{{2
-- e.g. (EDITOR(1 split) + SHELL(2 splits))
