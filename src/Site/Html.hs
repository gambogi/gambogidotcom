{-# LANGUAGE OverloadedStrings #-}
module Site.Html
( htmlRules
) where

import Site.Prelude

styles :: Context a
styles = mkListField "style"
       [ "source_code_pro"
       , "d4"
       , "main"
       ]

loadAllArticles = loadAll ("content/articles/*" .&&. hasNoVersion)

htmlRules :: Rules ()
htmlRules = do
    -- Populate template files
    match "templates/web/*" (compile templateCompiler)

    -- include static files
    match "images/*"  idRule
    match "scripts/*" idRule

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    -- Match for root page
    match "content/toplevel/index.md" $ do
        route (constRoute "index.html")
        compile $ do
            articles <- recentFirst =<< loadAllArticles
            let indexCtx = listField "articles" articleCtx (return articles)
                        <> siteCtx
                        <> defaultContext
            pandocCompiler
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/web/index.html" indexCtx
                >>= loadAndApplyTemplate "templates/web/default.html" indexCtx

    match "content/articles/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/web/article.html" (siteCtx <> articleCtx)
            >>= loadAndApplyTemplate "templates/web/default.html" (siteCtx <> articleCtx)

    create ["articles.html"] $ do
        route idRoute
        compile $ do
            articles <- recentFirst =<< loadAllArticles
            let articlesCtx = listField "articles" articleCtx (return articles)
                           <> constField "title" "Articles"
                           <> siteCtx
                           <> styles
                           <> defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/web/articles.html" articlesCtx
                >>= loadAndApplyTemplate "templates/web/default.html" articlesCtx

siteCtx :: Context String
siteCtx = styles
       <> mkListField "header" []
       <> mkListField "footer" []
