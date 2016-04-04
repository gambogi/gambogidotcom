{-# LANGUAGE OverloadedStrings #-}
module Main
(main)
where
import Site

main :: IO ()
main = hakyll $ do
    htmlRules
    latexRules
