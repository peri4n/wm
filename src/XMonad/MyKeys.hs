module XMonad.MyKeys where

import           Data.Map                      as M

import qualified XMonad.StackSet               as W
import qualified XMonad.Layout.BoringWindows   as B

import           Graphics.X11.ExtraTypes.XF86

import           System.Exit

import           XMonad
import           XMonad.Actions.Minimize
import           XMonad.Actions.WindowGo
import           XMonad.Prompt
import           XMonad.Prompt.FuzzyMatch
import           XMonad.Prompt.Pass
import           XMonad.Util.Run
import           XMonad.Util.Spotify

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig { XMonad.modMask = modMask } =
    mediaKeys $ M.fromList
        $
    -- launching and killing programs
          [ ((modMask, xK_Return) , spawn $ XMonad.terminal conf)
          , ((modMask, xK_n), spawn "dmenu_run_history.sh")
          , ((modMask, xK_a), spawn "select_window.sh")
          , ((modMask .|. shiftMask, xK_f), spawn "screen-layout.sh")
          , ((modMask .|. shiftMask, xK_Escape), spawn "slock")
          , ((modMask .|. shiftMask, xK_c), kill)

    -- switch layouts
          , ((modMask, xK_space), sendMessage NextLayout)
          , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

    -- move focus up or down the window stack
          , ((modMask, xK_Tab), B.focusDown)
          , ((modMask .|. shiftMask, xK_Tab), B.focusUp)
          , ((modMask, xK_m), withFocused minimizeWindow)
          , ((modMask .|. shiftMask, xK_m), withLastMinimized maximizeWindowAndFocus)

    -- modifying the window order
          , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
          , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
          , ((modMask .|. shiftMask, xK_k), windows W.swapUp)

    -- resizing the master/slave ratio
          , ((modMask, xK_h), sendMessage Shrink)
          , ((modMask, xK_l), sendMessage Expand)
          , ((modMask .|. shiftMask, xK_p), raiseMaybe (runInTerm "-t htop" "htop") (title =? "htop"))
          , ((modMask .|. shiftMask, xK_y), raiseMaybe (runInTerm "-t nnn" "nnn") (title =? "nnn"))
          , ((modMask .|. shiftMask, xK_t), raiseMaybe (runInTerm "-t task" "tasksh") (title =? "task"))
          , ((modMask .|. shiftMask, xK_o), raiseMaybe (runInTerm "-t mail" "alot") (title =? "mail"))
          , ((modMask .|. shiftMask, xK_u), raiseMaybe (runInTerm "-t music" "ncmpcpp") (title =? "music"))
          , ((modMask .|. shiftMask, xK_s), spawn "maim -s ~/screenshot.png") 
          , ((modMask, xK_c) , spawn "clipmenu")

    -- multi media keys
          , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
          , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
          , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")

    -- floating layer support
          , ((modMask, xK_t), withFocused $ windows . W.sink)

    -- quit, or restart
          , ((modMask .|. shiftMask, xK_q), io exitSuccess)
          , ((modMask, xK_q), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    -- pass integration
          , ((modMask, xK_y), passPrompt (def { searchPredicate = fuzzyMatch }))
          ]
        ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
           [ ((m .|. modMask, k), windows $ f i)
           | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
           , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
           ]
        ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
           [ ( (m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
           , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
           ]
