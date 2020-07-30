module XMonad.MyManageHooks where

import           Data.List       (isPrefixOf)
import           XMonad
import qualified XMonad.StackSet as W

myManageHook =
  composeAll
    [ isPrefixOf "jetbrains" <$> className --> doShift "Dev"
    , isPrefixOf "Vivaldi"   <$> className --> doShift "Web"
    , (className =? "Slack")               --> doShift "Chat"
    ] <+>
  manageHook def
