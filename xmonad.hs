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
--	hyper: term
--	gnome-terminal: term
--	google-chrome-stable: web
--	firefox: web
--	rofi: launcher
--	gmrun: launcher
--	nitrogen: wallpaper
--	picom: window manager
--	xmobar: statusbar
--

-- IMPORTS ------------------------------------------------------------- {{{1

import Data.List (intercalate)
import qualified Data.Map as M
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import XMonad
import XMonad.Actions.CopyWindow
  ( copyToAll,
    kill1,
    killAllOtherCopies,
  )
import XMonad.Actions.CycleWS
  ( nextWS,
    prevWS,
    shiftToNext,
    shiftToPrev,
  )
-- https://hackage.haskell.org/package/xmonad-extras-0.17.0
import XMonad.Actions.Volume
  ( lowerVolume,
    raiseVolume,
    toggleMute,
  )
-- import XMonad.Hooks.ManageDocks (ToggleStruts, avoidStruts, docks)
import XMonad.Hooks.ManageDocks
import qualified XMonad.StackSet as W
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)


-- RUN XMONAD ---------------------------------------------------------- {{{1

main = do
  xmproc <- spawnPipe myXmobarCommandLineString
  xmonad $ docks defaults
  where
    defaults =
      def
        { terminal = myTerminal,
          focusFollowsMouse = myFocusFollowsMouse,
          clickJustFocuses = myClickJustFocuses,
          borderWidth = myBorderWidth,
          modMask = myModMask,
          workspaces = myWorkspaces,
          normalBorderColor = myNormalBorderColor,
          focusedBorderColor = myFocusedBorderColor,
          keys = myKeys,
          mouseBindings = myMouseBindings,
          layoutHook = myLayout,
          manageHook = myManageHook,
          handleEventHook = myEventHook,
          logHook = myLogHook,
          startupHook = myStartupHook
        }

-- CUSTOMIZATIONS ------------------------------------------------------ {{{1

myTerminal = "alacritty"

myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses = False

myBorderWidth = 1 --px

myModMask = superKey where superKey = mod4Mask

myAltMask = mod1Mask -- NOTE: On my machine, mod1Mask acts on both left and right alt keys

myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#9F0DFF"

-- myWorkspaces = ["web", "code", "media" ] ++ map show [4..9]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]


-- MOUSE BINDINGS ------------------------------------------------------ {{{1

myMouseBindings (XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- left click (mod-button1)
    -- set the window to floating mode and move by dragging
    [ ( (modm, button1),
        (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
      ),
      -- mod-button2
      -- raise the window to the top of the stack
      ((modm, button2), (\w -> focus w >> windows W.shiftMaster)),
      -- right click (mod-button3)
      -- set the window to floating mode and resize by dragging
      ( (modm, button3),
        (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
      )
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
    tiled = Tall nmaster delta ratio

    -- default number of windows in the master pane
    nmaster = 1

    -- default proportion of screen occupied by master pane
    ratio = 52 / 100

    -- percent of screen to increment by when resizing panes
    delta = 3 / 100


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
myManageHook =
  composeAll
    [ className =? "MPlayer" --> doFloat,
      className =? "Gimp" --> doFloat,
      resource =? "desktop_window" --> doIgnore,
      resource =? "kdesktop" --> doIgnore
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
-- myStartupHook = return ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"

-- spawnOnce "picom &"


-- XMOBAR -------------------------------------------------------------- {{{1
myXmobarCommandLineString :: String
myXmobarCommandLineString =
  intercalate
    " "
    [ "xmobar",
      -- BEHAVIOR {{{2
      "--bottom",
      -- APPEARANCE {{{2
      "--font='xft:Bitstream Vera Sans Mono:size=15:bold:antialias=true'",
      "--fgcolor=#646464",
      "--bgcolor=black",
      -- TEMPLATES {{{2
      "--alignsep=}{",
      "--sepchar=%",
      "--template='%date% }{ %coretemp% | %multicpu% | %dynnetwork%  | %alsa:default:Master% | %battery%'",
      -- COMMANDS {{{2
      -- %dynnetwork*
      "--add-command='[Run DynNetwork [\"--template\", \"NW R<rxvbar> T<txvbar>\"] 10]'",
      -- Volume(using Alsa) %alsa:default:Master%
      "--add-command='[Run Alsa \"default\" \"Master\" []]'",
      -- %date%
      "--add-command='[Run Date \"<fc=#9F0DFF>%I:%M</fc> %p | %A %B %d\" \"date\" 10]'",
      -- %cpu%
      "--add-command='[Run MultiCpu [\"--template\", \"CPU <total0>%|<total1>%\", \"--Low\", \"50\", \"--High\", \"85\", \"--normal\", \"darkorange\", \"--high\", \"darkred\" ] 10]'",
      -- %coretemp%
      "--add-command='[Run CoreTemp [\"--template\", \"TEMP <core0>C|<core1>C\", \"--Low\", \"70\", \"--High\", \"80\", \"--normal\", \"darkorange\", \"--high\", \"darkred\" ] 50]'",
      -- %battery%
      "--add-command='[Run Battery [\"--template\", \"BATT <acstatus>\", \"--Low\", \"12\", \"--low\", \"darkred\", \"-a\", \"xmessage LOWBATTERY\", \"--\", \"-o\", \"(<timeleft> remaining) <fc=#DFDFDF><left>%</fc>\", \"-O\", \"<fc=#dAA520>Charging</fc> <fc=#DFDFDF><left>%</fc>\", \"-i\", \"<fc=#006000>Charged</fc>\"] 50]'"
    ]


-- KEY BINDINGS -------------------------------------------------------- {{{1
myKeys conf@(XConfig {XMonad.modMask = modm}) =
  M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
      -- launch browser (google chrome)
      ((modm .|. myAltMask, xK_Return), spawn "google-chrome-stable"),
      -- launch rofi
      ((modm, xK_o), spawn "rofi -show run"),
      -- launch gmrun
      ((modm .|. shiftMask, xK_o), spawn "gmrun"),
      -- close focused window
      ((modm .|. shiftMask, xK_c), kill),
      -- show window in all workspaces
      ((modm, xK_a), windows copyToAll),
      -- close other copies of focussed window (in other workspaces)
      ((modm .|. shiftMask, xK_a), killAllOtherCopies),
      -- close focussed window only in current workspace, leaving alone copies in other workspaces
      ((modm .|. shiftMask .|. myAltMask, xK_a), kill1),
      -- rotate through the available layout algorithms
      ((modm, xK_space), sendMessage NextLayout),
      -- reset the layouts on the current workspace to default
      ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- resize viewed windows to the correct size
      ((modm, xK_n), refresh),
      -- move focus to the next window
      ((modm, xK_Tab), windows W.focusDown),
      -- move focus to the previous window
      ((modm .|. shiftMask, xK_Tab), windows W.focusUp),
      -- move focus to the master window
      ((modm, xK_m), windows W.focusMaster),
      -- swap the focused window and the master window
      ((modm, xK_Return), windows W.swapMaster),
      -- swap the focused window with the next window
      ((modm .|. myAltMask, xK_Tab), windows W.swapDown),
      -- swap the focused window with the previous window
      ((modm .|. shiftMask .|. myAltMask, xK_Tab), windows W.swapUp),
      -- shrink the master area
      ((modm, xK_h), sendMessage Shrink),
      -- expand the master area
      ((modm, xK_l), sendMessage Expand),
      -- push window back into tiling
      ((modm, xK_t), withFocused $ windows . W.sink),
      -- increment the number of windows in the master area
      ((modm, xK_comma), sendMessage (IncMasterN 1)),
      -- deincrement the number of windows in the master area
      ((modm, xK_period), sendMessage (IncMasterN (-1))),
      -- toggle the status bar gap
      -- use this binding with avoidstruts from hooks.managedocks.
      -- see also the statusbar function from hooks.dynamiclog.
      ((modm, xK_b), sendMessage ToggleStruts),
      -- quit xmonad
      ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
      -- restart xmonad
      ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart"),
      -- raise  monitor brightness
      ((0, xF86XK_MonBrightnessUp), spawn "light -A 10"),
      -- lower monitor brightness
      ((0, xF86XK_MonBrightnessDown), spawn "light -U 10"),
      -- raise keyboard keys backlight brightness
      -- NOTE: hardwired to device: `sysfs/leds/smc::kbd_backlight`
      ( (0, xF86XK_KbdBrightnessUp),
        spawn "light -A 20 -s sysfs/leds/smc::kbd_backlight"
      ),
      -- lower keyboard keys backlight brightness
      -- NOTE: hardwired to device: `sysfs/leds/smc::kbd_backlight`
      ( (0, xF86XK_KbdBrightnessDown),
        spawn "light -U 20 -s sysfs/leds/smc::kbd_backlight"
      ),
      -- raise volume
      ((0, xF86XK_AudioRaiseVolume), raiseVolume 3 >> return ()),
      -- lower volume
      ((0, xF86XK_AudioLowerVolume), lowerVolume 3 >> return ()),
      -- mute volume
      ((0, xF86XK_AudioMute), toggleMute >> return ()),
      -- switch to next workpace
      ((modm, xK_Right), nextWS),
      -- switch to previous workpace
      ((modm, xK_Left), prevWS),
      -- move focussed window to next workspace
      ((modm .|. shiftMask, xK_Right), shiftToNext),
      -- move focussed window to previous workspace
      ((modm .|. shiftMask, xK_Left), shiftToPrev),
      -- move focussed window to next workspace and switch to that workspace
      ((modm .|. shiftMask .|. myAltMask, xK_Right), shiftToNext >> nextWS),
      -- move focussed window to previous workspace and switch to that workspace
      ((modm .|. shiftMask .|. myAltMask, xK_Left), shiftToPrev >> prevWS)
      -- run xmessage with keybindings summary
      -- ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ helpMsg ++ "\" | xmessage -file -")),
    ]
      ++
      --
      -- 1. switch to workspace N (mod-[1..9])
      -- 2. move window to workspace N (mod-shift-[1..9])
      -- 3. move and switch window to workspace N (mod-alt-shift-[1..9])
      --
      [ ((m .|. modm, key), f i)
        | (i, key) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
          (f, m) <-
            [ ((windows . W.greedyView), 0),
              ((windows . W.shift), shiftMask),
              ( ( \i -> do
                    windows . W.shift $ i
                    windows . W.greedyView $ i
                ),
                shiftMask .|. myAltMask
              )
            ]
      ]

