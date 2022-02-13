module XMonad.MyScratchPads where

import           XMonad
import           XMonad.StackSet               as W
import           XMonad.Util.NamedScratchpad

myScratchPads :: [NamedScratchpad]
myScratchPads =
    [ NS "finder" spawnFinder findFinder manageFinder
    , NS "task" spawnTask findTask manageTask
    ]
  where
    spawnFinder  = "kitty -T broot broot"
    findFinder   = appName =? "broot" <||> title =? "broot"
    manageFinder = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w

    spawnTask = "kitty -T tasksh tasksh"
    findTask  = title =? "tasksh"
    manageTask = customFloating $ W.RationalRect l t w h
      where
        h = 0.9
        w = 0.9
        t = 0.95 - h
        l = 0.95 - w
