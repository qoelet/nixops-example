{-# LANGUAGE OverloadedStrings #-}

import           Network.HTTP.Types
import           Network.Wai
import           Network.Wai.Handler.Warp (run)

app :: Application
app _ res = do
  putStrLn "Greeting..."
  res $ responseLBS
    status200
    [("Content-Type", "text/plain")]
    "hello, world!"

main :: IO ()
main = putStrLn "Running app on port 8080" >> run 8080 app
