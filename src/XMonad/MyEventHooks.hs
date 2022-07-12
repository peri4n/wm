module XMonad.MyEventHooks where

import           XMonad
import           XMonad.Hooks.Minimize

myEventHooks = handleEventHook def <+> minimizeEventHook
