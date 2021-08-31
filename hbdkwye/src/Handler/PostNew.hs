{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Handler.PostNew where

import Import
import Yesod.Form.Bootstrap3
-- import Yesod.Text.Markdown   (markdownField)

restaurantPostForm :: AForm Handler RestaurantPost
restaurantPostForm = RestaurantPost
            <$> areq textField (bfs ("RestaurantName" :: Text)) Nothing
            <*> areq textField (bfs ("Tel" :: Text)) Nothing
            <*> areq textField (bfs ("Link" :: Text)) Nothing

getPostNewR :: Handler Html
getPostNewR = do 
    (widget, enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm restaurantPostForm
    defaultLayout $ do 
        $(widgetFile "post/new")

postPostNewR :: Handler Html
postPostNewR = do
    ((res, widget), enctype) <- 
        runFormPost $ renderBootstrap3 BootstrapBasicForm restaurantPostForm
    case res of 
        FormSuccess restaurantPost -> do 
                restaurantPostId <- runDB $ insert restaurantPost
                redirect $ PostDetailsR restaurantPostId
        _ -> defaultLayout $(widgetFile "post/new")