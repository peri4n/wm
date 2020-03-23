module XMonad.MyEventHooks where

import           XMonad
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.Minimize

myEventHooks = handleEventHook def <+> docksEventHook <+> minimizeEventHook
