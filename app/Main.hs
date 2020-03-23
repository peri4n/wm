import           XMonad
import           XMonad.Hooks.DynamicLog   (statusBar)
import           XMonad.Hooks.EwmhDesktops (ewmh)
import           XMonad.Hooks.ManageDocks  (avoidStruts)
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook

-- Custom modules
import           XMonad.MyDocks
import           XMonad.MyEventHooks
import           XMonad.MyKeys
import           XMonad.MyLayouts
import           XMonad.MyManageHooks

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Config augmented with Ewmh (used by rofi) and urgency hooks
myConfig =
  ewmh
    (withUrgencyHook NoUrgencyHook $
     def
       { modMask = mod4Mask
       , startupHook = setWMName "LG3D"
       , borderWidth = 1
       , terminal = "st"
       , normalBorderColor = "darkgrey"
       , focusedBorderColor = "white"
       , keys = myKeys
       , focusFollowsMouse = myFocusFollowsMouse
       , clickJustFocuses = myClickJustFocuses
       , workspaces = myWorkspaces
       , handleEventHook = myEventHooks
       , manageHook = myManageHook <+> manageHook def
       , layoutHook = avoidStruts myLayout
       })

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Click is passed through when clicked on an inactive window
myClickJustFocuses = False

-- It should only be possible to switch focus via keyboard
myFocusFollowsMouse = False

myWorkspaces :: [String]
myWorkspaces = ["Web", "Dev", "Chat", "Mail"]
