---
title: XMonad Configuration
author: Matt Gambogi
---

[XMonad][1] is a no-frills window management system. There are a good number of
people who use XMonad, but don't actually know Haskell. It was the first program
I encountered that I knew was written in Haskell. As a high school kid messing
with Linux, I encountered XMonad "configuration". I place configuration in scare
quotes because you don't write a config file for XMonad so much as you rewrite
the XMonad main function to change its behavior.
This means many people, including high school me, need to write (or at least
copy paste) a small Haskell program to make their desktop look the way they
like. This post attempts to explain what is going on in an XMonad configuration
file to someone who already has XMonad installed.

The actual XMonad program installed at the system level will look for a Haskell
program in `~/.xmonad/xmonad.hs`, compile and then run whatever it finds there.
If no source file is found at that location, it will run with a default
configuration. The new program doesn't even have to be related to XMonad, it
could be the code to fire the nukes and play you in a game of tetris while it
does. As a user you probably would prefer to get XMonad when your run `xmonad`,
so we'll just focus on that use case.

This config produces the same behavior as having no configuration:

``` Haskell
import XMonad

main = xmonad defaultConfig
```
Let's break this down. The first line, `import XMonad` brings a whole bunch of
functions from the XMonad library into scope, including `xmonad`. The
library documentation may be found on the [XMonad haddock][2].

The next line, `main = xmonad defaultConfig` defines a function called `main`.
Haskell, just like many languages, picks an essentially magic function name that
it uses as the entry point of exectution. The entirity of the main defined in
this program just calls the `xmonad` function with `defaultConfig` as an
argument. Again, both are in scope because the `XMonad` module was imported.

This should look something like [this](/images/xmonad-default.png).


Great, but personally, I hate the red border around the active window. Let's get
rid of it:
``` Haskell
import XMonad

main = xmonad (defaultConfig {borderWidth = 0})
```

Now [the border is gone](/images/xmonad-noborder.png), but why is defaultConfig
in parens?  Because we need to overload a field in the default configuration,
we use what's known as [record syntax][3] to set a specific attribute in the
XConfig provided by defaultConfig.

Java Swing programs have a whitelist of valid windowing evironments
(spoiler, XMonad is not on the list). Fortunately we can
solve this pretty easily:

``` Haskell
import XMonad
import XMonad.Hooks.SetWMName

main = xmonad (defaultConfig { borderWidth = 0
                             , startupHook = setWMName "LG3D"
                             }
              )
```

We import a module which supplies the `setWMName` function, which takes care of
setting the name XMonad gives to X programs running inside its scope. This
is good enough to trick Swing programs.

Finally, we'd like to take screenshots of our new environment. I use `scrot`, 
because it was the first thing I found that did what I want. To make XMonad fire
scrot when a certain key combination is press we'll again modify the
configuration object.The [`EZConfig`][4] module has a grab bag of functions for
making config manipulation a bit easier. We can use it like so:

``` Haskell
import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig

main = xmonad (defaultConfig
    { borderWidth = 0
    , startupHook = setWMName "LG3D"
    } `additionalKeysP`
    [("M-s", spawn "scrot '%Y-%m-%d-%k%M%S_$wx$h_screenshot.png' -e 'mv $f ~screenshots'")]
    )
```

`additionalKeysP` function takes an XConfig (in this case our modified
`defaultConfig`) and a list of tuples specifying the key combination and the IO
action to take. It simply unions the keybindings already present in the config
and the additional ones specified by the tuple. Any prefix function in Haskell
may be written as infix by enclosing it in backticks. This can sometimes make
things easier to read.
Now when we press `Mod + s` `scrot` will take a screenshot and move it to the
screenshots folder in the user homedir. All the screenshots for this post were
taken using a similar `xmonad.hs` to the final version detailed here.

[1]: http://xmonad.org "XMonad Home Page"
[2]: http://xmonad.org/xmonad-docs/xmonad/frames.html "XMonad Documentation"
[3]: http://book.realworldhaskell.org/read/defining-types-streamlining-functions.html#deftypes.record "Record Syntax"
[4]: http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Util-EZConfig.html "XMonad Documentation"

