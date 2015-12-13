import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks


main = do
    h <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ defaultConfig
        { terminal = "urxvt"
        , borderWidth = 3
        , logHook = dynamicLogWithPP $ sjanssenPP { ppOutput = hPutStrLn h }
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , manageHook = manageHook defaultConfig <+> manageDocks
        }
