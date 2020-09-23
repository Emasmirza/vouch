*** Settings ***
############# MANDATORY INCLUDES #############
Resource         ../resources-vouch/PageImporter.robot
Test Setup       Open Browser With Timeout
Test Teardown    Close Browser


*** Test Case ***

Click Button On Chat Page
    HomePage.Go To Chat Page
    ChatPage.User Send Image
    ChatPage.Click Button Close Chat

Bot Common Responds
    HomePage.Go To Chat Page
    ChatPage.Input Text in Chat Box                         how to make reservation?
    ChatPage.Verify Bot Common Response

Bot Responds Unknown Text
    HomePage.Go To Chat Page
    ChatPage.Input Text in Chat Box                         hasdasvjvnsdvnsvovjvomvsvmposdv dvpidsvvv'?
    ChatPage.Verify Bot Response While Unknown Text

Bot Responds Bad Words
    HomePage.Go To Chat Page
    ChatPage.Input Text in Chat Box                         damn you                                       #sorry :)
    ChatPage.Verify Bot Response While Bad Words

Bot Responds Menu
    HomePage.Go To Chat Page
    ChatPage.Input Text in Chat Box                         menu
    ChatPage.Verify Bot Response While User Texting Menu
    ChatPage.Click One Random Menu
    ChatPage.Verify Bot Common Response


