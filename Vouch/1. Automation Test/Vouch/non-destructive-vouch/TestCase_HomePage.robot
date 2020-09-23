*** Settings ***
############# MANDATORY INCLUDES #############
Resource         ../resources-vouch/PageImporter.robot
Test Setup       Open Browser With Timeout
Test Teardown    Close Browser


*** Test Case ***
Open Chat Page
    #[Documentation]                              As user, I want to read article with adult content. That article needs verify age using facebook account
    HomePage.Go To Chat Page
    Chatpage.Verify Chat Page