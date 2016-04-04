{-# LANGUAGE OverloadedStrings #-}
module Site.Prelude
( module Hakyll
, (<>)
, articleCtx
, idRule
, mkListField
)
where

import Data.Monoid ((<>))
import Hakyll


idRule :: Rules ()
idRule = do
  route   idRoute
  compile copyFileCompiler

-- | lists 
articleCtx :: Context String
articleCtx = listField "articles" articleCtx articles
          <> dateField "date" "%B %e, %Y"
          <> defaultContext
    where
        articles = loadAll "content/articles/*" >>= recentFirst



mkListField key xs = listField (key ++ "s")
                               (field key (pure . itemBody))
                               (mapM makeItem xs)
