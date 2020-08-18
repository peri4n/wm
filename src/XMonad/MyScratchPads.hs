module XMonad.MyScratchPads where

import           XMonad
import           XMonad.StackSet               as W
import           XMonad.Util.NamedScratchpad

myScratchPads :: [NamedScratchpad]
myScratchPads =
    [ NS "mail" spawnMail findMail manageMail
    , NS "task" spawnTask findTask manageTask
    ]
  where
    spawnMail  = "st -e alot"
    findMail   = title =? "alot"
    manageMail = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

    spawnTask = "st -e tasksh"
    findTask  = title =? "tasksh"
    manageTask = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w
