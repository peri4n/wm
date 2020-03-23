module XMonad.MyLayouts where

import           XMonad
import           XMonad.Hooks.ManageDocks       ( avoidStruts )
import           XMonad.Layout.Minimize         ( minimize )
import           XMonad.Layout.BoringWindows    ( boringWindows )
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Renamed          ( Rename(..)
                                                , renamed
                                                )

myLayout = avoidStruts $ smartBorders $ boringWindows (full ||| tall)
  where
    full    = renamed [Replace "FS"] (minimize Full)
    tall    = renamed [Replace "TL"] (minimize (Tall nmaster delta ratio))
    nmaster = 1
    ratio   = 1 / 2
    delta   = 3 / 100
