{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Handler.PostDetails where

import Import

getPostDetailsR :: RestaurantPostId -> Handler Html
getPostDetailsR restaurantPostId = do 
    restaurantPost <- runDB $ get404 restaurantPostId
    defaultLayout $ do
        $(widgetFile "postDetails/post")
