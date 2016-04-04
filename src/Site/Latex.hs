{-# LANGUAGE OverloadedStrings #-}
module Site.Latex
( latexRules
) where

import Site.Prelude

latexRules = do
  -- ensure tex templates are properly created
  match "templates/tex/*" (compile templateCompiler)

  match "content/articles/*" $ version "tex" $ do
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/tex/article.tex" articleCtx

