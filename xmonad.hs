-- xmonad configuration file {{{1
-- vim: foldmethod=marker:foldlevel=0:nofoldenable:
--
-- PATH:
-- ~/.xmonad/xmonad.hs
--
-- AUTHOR:
-- 	Sri Kadimisetty
-- 	https://github.com/kadimisetty
--
-- BINARIES USED IN THIS FILE: (TODO: Review occasionally)
--	light: brightness control
--	xmessage: display messages like help etc.
--	gxmessage: display messages like help etc. with gtk
--	google-chrome-stable: web
--	gmrun: app runner with name completion
--	nitrogen: wallpaper setter
--	xmobar: statusbar
--	dmenu: runner for apps etc.
--

-- IMPORTS ------------------------------------------------------------- {{{1

import           Data.List                      ( intercalate )
import qualified Data.Map                      as M
import           Data.Monoid
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           XMonad
import           XMonad.Actions.CopyWindow      ( copyToAll
                                                , kill1
                                                , killAllOtherCopies
                                                )
import           XMonad.Actions.CycleWS         ( Direction1D(Next, Prev)
                                                , WSType(Not)
                                                , emptyWS
                                                , moveTo
                                                , nextWS
                                                , prevWS
                                                , shiftToNext
                                                , shiftToPrev
                                                )
-- https://hackage.haskell.org/package/xmonad-extras-0.17.0
import           XMonad.Actions.Volume          ( lowerVolume
                                                , raiseVolume
                                                , toggleMute
                                                )
-- import XMonad.Hooks.ManageDocks (ToggleStruts, avoidStruts, docks)
import           XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet               as W
import           XMonad.Util.Run                ( spawnPipe )
import           XMonad.Util.SpawnOnce          ( spawnOnce )


import           XMonad.Actions.GroupNavigation ( Direction(Backward, Forward)
                                                , nextMatchWithThis
                                                )


-- RUN XMONAD ---------------------------------------------------------- {{{1

main = do
  xmproc <- spawnPipe myXmobarCommand
  xmonad $ docks defaults
 where
  defaults = def { terminal           = myTerminal
                 , focusFollowsMouse  = myFocusFollowsMouse
                 , clickJustFocuses   = myClickJustFocuses
                 , borderWidth        = myBorderWidth
                 , modMask            = myModMask
                 , workspaces         = myWorkspaces
                 , normalBorderColor  = myNormalBorderColor
                 , focusedBorderColor = myFocusedBorderColor
                 , keys               = myKeys
                 , mouseBindings      = myMouseBindings
                 , layoutHook         = myLayout
                 , manageHook         = myManageHook
                 , handleEventHook    = myEventHook
                 , logHook            = myLogHook
                 , startupHook        = myStartupHook
                 }

-- CUSTOMIZATIONS ------------------------------------------------------ {{{1

myTerminal = "alacritty"

myBrowser = "google-chrome-stable"

myFileBrowser = "nautilus"

myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses = False

myBorderWidth = 2 --px

myModMask = superKey where superKey = mod4Mask

myAltMask = mod1Mask -- NOTE: On my machine, mod1Mask acts on both left and right alt keys

myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#9F0DFF"

-- myWorkspaces = ["web", "code", "media" ] ++ map show [4..9]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- MOUSE BINDINGS ------------------------------------------------------ {{{1
myMouseBindings (XConfig { XMonad.modMask = modm }) =
  M.fromList
    $ [
    -- set the window to floating mode and move by dragging
    -- (mod-button1 i.e. mod-left-click)
        ( (modm, button1)
        , (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
        )
      -- set the window to floating mode and resize by dragging
      -- (mod-button1 i.e. mod-right-click)
      , ( (modm, button3)
        , (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
        )
      -- raise the window to the top of the stack
      -- (mod-button2 i.e. mod-middle/scroll-wheel-click)
      , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
      -- switch to next workpace
      -- (mod-button4 i.e. mod-scroll-up)
      , ((modm, button4)              , (\_ -> nextWS))
      -- switch to prev workpace
      -- (mod-button5 i.e. mod-scroll-down)
      , ((modm, button5)              , (\_ -> prevWS))
      -- switch to next non-empty workpace
      -- (mod-alt-button4 i.e. mod-scroll-up)
      , ((modm .|. myAltMask, button4), (\_ -> moveTo Next (Not emptyWS)))
      -- switch to prev non-empty workpace
      -- (mod-alt-button5 i.e. mod-scroll-down)
      , ((modm .|. myAltMask, button5), (\_ -> moveTo Prev (Not emptyWS)))
      ]



-- LAYOUTS ------------------------------------------------------------- {{{1

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full
 where
    -- default tiling algorithm partitions the screen into two panes
  tiled   = Tall nmaster delta ratio

  -- default number of windows in the master pane
  nmaster = 1

  -- default proportion of screen occupied by master pane
  ratio   = 52 / 100

  -- percent of screen to increment by when resizing panes
  delta   = 3 / 100

-- WINDOW RULES -------------------------------------------------------- {{{1

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
  [ className =? "MPlayer" --> doFloat
  , className =? "Gimp" --> doFloat
  , resource =? "desktop_window" --> doIgnore
  , resource =? "kdesktop" --> doIgnore
  ]

-- EVENT HANDLING ------------------------------------------------------ {{{1

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook

--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

-- STATUS BARS AND LOGGING --------------------------------------------- {{{1

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

-- STARTUP HOOK -------------------------------------------------------- {{{1

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "nitrogen --restore &"

-- XMOBAR -------------------------------------------------------------- {{{1
myXmobarCommand :: String
myXmobarCommand = intercalate
  " "
  [ "xmobar"
  ,
      -- BEHAVIOR {{{2
    "--bottom"
  ,
      -- APPEARANCE {{{2
    "--font='xft:Bitstream Vera Sans Mono:size=15:bold:antialias=true'"
  , "--fgcolor=#646464"
  , "--bgcolor=black"
  ,
      -- TEMPLATES {{{2
    "--alignsep=}{"
  , "--sepchar=%"
  , "--template='%date% }{ %coretemp% | %multicpu% | %dynnetwork%  | %alsa:default:Master% | %battery%'"
  ,
      -- COMMANDS {{{2
      -- %dynnetwork*
    "--add-command='[Run DynNetwork [\"--template\", \"NW R<rxvbar> T<txvbar>\"] 10]'"
  ,
      -- Volume(using Alsa) %alsa:default:Master%
    "--add-command='[Run Alsa \"default\" \"Master\" []]'"
  ,
      -- %date%
      -- "--add-command='[Run Date \"<fc=#9F0DFF>%I:%M</fc> %p | %A %B %d\" \"date\" 10]'",
    "--add-command='[Run Date \"<fc=#fff,#9F0DFF> %I:%M %p </fc> %A %b %d\" \"date\" 10]'"
  ,
      -- %cpu%
    "--add-command='[Run MultiCpu [\"--template\", \"CPU <total0>%|<total1>%\", \"--Low\", \"50\", \"--High\", \"85\", \"--normal\", \"darkorange\", \"--high\", \"darkred\" ] 10]'"
  ,
      -- %coretemp%
    "--add-command='[Run CoreTemp [\"--template\", \"TEMP <core0>C|<core1>C\", \"--Low\", \"70\", \"--High\", \"80\", \"--normal\", \"darkorange\", \"--high\", \"darkred\" ] 50]'"
  ,
      -- %battery%
    "--add-command='[Run Battery [\"--template\", \"BATT <acstatus>\", \"--Low\", \"12\", \"--low\", \"darkred\", \"-a\", \"xmessage LOWBATTERY\", \"--\", \"-o\", \"(<timeleft> remaining) <fc=#DFDFDF><left>%</fc>\", \"-O\", \"<fc=#dAA520>Charging</fc> <fc=#DFDFDF><left>%</fc>\", \"-i\", \"<fc=#006000>Charged</fc>\"] 50]'"
  ]

-- KEY BINDINGS -------------------------------------------------------- {{{1
myKeys conf@(XConfig { XMonad.modMask = modm }) =
  M.fromList
    $  [ -- launch a terminal
         ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
       ,
      -- launch web browser
         ((modm .|. myAltMask, xK_Return)           , spawn myBrowser)
       ,
      -- launch file browser
         ((myAltMask .|. shiftMask, xK_Return)      , spawn myFileBrowser)
       ,
      -- launch primary app runner
         ((modm, xK_o)                              , spawn "rofi -show run")
       ,
      -- launch secondary app runner
         ((modm .|. shiftMask, xK_o)                , spawn "gmrun")
       ,
      -- close focused window
         ((modm .|. shiftMask, xK_c)                , kill)
       ,
      -- show window in all workspaces
         ((modm, xK_a)                              , windows copyToAll)
       ,
      -- close other copies of focussed window (in other workspaces)
         ((modm .|. shiftMask, xK_a)                , killAllOtherCopies)
       ,
      -- close focussed window only in current workspace, leaving alone copies in other workspaces
         ((modm .|. shiftMask .|. myAltMask, xK_a)  , kill1)
       ,
      -- rotate through the available layout algorithms
         ((modm, xK_space)                          , sendMessage NextLayout)
       ,
      -- reset the layouts on the current workspace to default
         ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
       ,
      -- resize viewed windows to the correct size
         ((modm, xK_n)                              , refresh)
       ,
      -- move focus to the next window
         ((modm, xK_Tab)                            , windows W.focusDown)
       ,
      -- move focus to the previous window
         ((modm .|. shiftMask, xK_Tab)              , windows W.focusUp)
       ,
      -- move focus to the master window
         ((modm, xK_m)                              , windows W.focusMaster)
       ,
      -- swap the focused window and the master window
         ((modm, xK_Return)                         , windows W.swapMaster)
       ,
      -- swap the focused window with the next window
         ((modm .|. myAltMask, xK_Tab)              , windows W.swapDown)
       ,
      -- swap the focused window with the previous window
         ((modm .|. shiftMask .|. myAltMask, xK_Tab), windows W.swapUp)
       ,
      -- shrink the master area
         ((modm, xK_h)                              , sendMessage Shrink)
       ,
      -- expand the master area
         ((modm, xK_l)                              , sendMessage Expand)
       ,
      -- push window back into tiling
         ((modm, xK_t), withFocused $ windows . W.sink)
       ,
      -- increment the number of windows in the master area
         ((modm, xK_comma), sendMessage (IncMasterN 1))
       ,
      -- deincrement the number of windows in the master area
         ((modm, xK_period), sendMessage (IncMasterN (-1)))
       ,
      -- toggle the status bar gap
      -- use this binding with avoidstruts from hooks.managedocks.
      -- see also the statusbar function from hooks.dynamiclog.
         ((modm .|. myAltMask, xK_d)                , sendMessage ToggleStruts)
       ,
      -- quit xmonad
         ((modm .|. shiftMask, xK_q)                , io (exitWith ExitSuccess))
       ,
      -- restart xmonad
         ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")
       ,
      -- raise  monitor brightness
         ((0, xF86XK_MonBrightnessUp)               , spawn "light -A 10")
       ,
      -- lower monitor brightness
         ((0, xF86XK_MonBrightnessDown)             , spawn "light -U 10")
       ,
      -- raise keyboard keys backlight brightness
      -- NOTE: hardwired to device: `sysfs/leds/smc::kbd_backlight`
         ( (0, xF86XK_KbdBrightnessUp)
         , spawn "light -A 20 -s sysfs/leds/smc::kbd_backlight"
         )
       ,
      -- lower keyboard keys backlight brightness
      -- NOTE: hardwired to device: `sysfs/leds/smc::kbd_backlight`
         ( (0, xF86XK_KbdBrightnessDown)
         , spawn "light -U 20 -s sysfs/leds/smc::kbd_backlight"
         )
       ,
      -- raise volume
         ((0, xF86XK_AudioRaiseVolume), raiseVolume 3 >> return ())
       ,
      -- lower volume
         ((0, xF86XK_AudioLowerVolume), lowerVolume 3 >> return ())
       ,
      -- mute volume
         ((0, xF86XK_AudioMute)                       , toggleMute >> return ())
       ,
      -- switch to next workpace
         ((modm, xK_Right)                            , nextWS)
       ,
      -- switch to previous workpace
         ((modm, xK_Left)                             , prevWS)
       ,
      -- move focussed window to next workspace
         ((modm .|. shiftMask, xK_Right)              , shiftToNext)
       ,
      -- move focussed window to previous workspace
         ((modm .|. shiftMask, xK_Left)               , shiftToPrev)
       ,
      -- move focussed window to next workspace and switch to that workspace
         ((modm .|. shiftMask .|. myAltMask, xK_Right), shiftToNext >> nextWS)
       ,
      -- move focussed window to previous workspace and switch to that workspace
         ((modm .|. shiftMask .|. myAltMask, xK_Left) , shiftToPrev >> prevWS)
      -- run xmessage with keybindings summary
      -- ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ helpMsg ++ "\" | xmessage -file -")),
       ]
    ++ [ ((m .|. modm, key), f i)
       | (i, key) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
       , (f, m  ) <-
-- 1. switch to workspace N (mod-[1..9])
         [ ((windows . W.greedyView), 0)
-- 2. move window to workspace N (mod-shift-[1..9])
         , ((windows . W.shift)     , shiftMask)
-- 3. move window and switch to workspace N (mod-shift-alt-[1..9])
         , ( (\i -> do
               windows . W.shift $ i
               windows . W.greedyView $ i
             )
           , shiftMask .|. myAltMask
           )
         ]
       ]
    ++ [
-- 1. switch to next non-empty workspace
         ((modm .|. myAltMask, xK_Right), moveTo Next (Not emptyWS))
-- 2. switch to previous non-empty workspace
       , ((modm .|. myAltMask, xK_Left) , moveTo Prev (Not emptyWS))
       ]

      --
      -- make mod-0 represent the last workspace
      --
    ++ [
      -- 1. switch to last workspace (mod-0)
         ( (modm, xK_0)
         , (windows . W.greedyView . last $ XMonad.workspaces conf)
         )
      -- 2. move window to last workspace (mod-shift-0)
       , ( (modm .|. shiftMask, xK_0)
         , (windows . W.shift . last $ XMonad.workspaces conf)
         )
      -- 3. move window and switch to last workspace (mod-shift-alt-0)
       , ( (modm .|. shiftMask .|. myAltMask, xK_0)
         , ( (\i -> do
               windows . W.shift $ i
               windows . W.greedyView $ i
             )
           $ last
           $ XMonad.workspaces conf
           )
         )
       ]
      --
      -- Focus next/prev window of same application kind, ala macOS using the mod-backtick.
      -- NOTE: xK_grave(96) is backtick
      --
    ++ [
      -- TODO: 1. Across current workspaces
      -- 2. Across all workspaces
         ((modm .|. myAltMask, xK_grave), nextMatchWithThis Forward className)
       , ( (modm .|. myAltMask .|. shiftMask, xK_grave)
         , nextMatchWithThis Backward className
         )
       ]

