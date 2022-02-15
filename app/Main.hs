{-# LANGUAGE TupleSections #-}

import XMonad
import XMonad.Hooks.DynamicLog (statusBar)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.WallpaperSetter
-- Custom modules
import XMonad.MyDocks
import XMonad.MyEventHooks
import XMonad.MyKeys
import XMonad.MyLayouts
import XMonad.MyManageHooks

main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myConfig =
  ewmh
    ( withUrgencyHook NoUrgencyHook $
        def
          { modMask = mod4Mask,
            startupHook = setWMName "LG3D",
            borderWidth = 1,
            terminal = "kitty",
            normalBorderColor = "darkgrey",
            focusedBorderColor = "white",
            keys = myKeys,
            focusFollowsMouse = myFocusFollowsMouse,
            clickJustFocuses = myClickJustFocuses,
            workspaces = myWorkspaces,
            handleEventHook = myEventHooks,
            manageHook = myManageHook <+> manageHook def,
            layoutHook = avoidStruts myLayout,
            logHook =
              wallpaperSetter
                WallpaperConf
                  { wallpaperBaseDir = "", -- defaults to "~/.wallpapers"
                    wallpapers = WallpaperList $ map (,WallpaperFix "haskell-lambda.jpg") myWorkspaces
                  }
          }
    )

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Click is passed through when clicked on an inactive window
myClickJustFocuses = False

-- It should only be possible to switch focus via keyboard
myFocusFollowsMouse = False

myWorkspaces :: [String]
myWorkspaces = ["Web", "Dev", "Chat", "Mail"]
