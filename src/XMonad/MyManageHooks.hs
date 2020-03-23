module XMonad.MyManageHooks where

import           Data.List       (isPrefixOf)
import           XMonad
import qualified XMonad.StackSet as W

myManageHook =
  composeAll
    [ isPrefixOf "jetbrains" <$> className --> doShift "Dev"
    , isPrefixOf "firefox" <$> className --> doShift "Web"
    , (className =? "Slack") --> doF (W.shift "Chat")
    ] <+>
  manageHook def
