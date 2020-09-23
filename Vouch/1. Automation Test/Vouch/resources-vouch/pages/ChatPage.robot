*** Settings ***
Resource                    ../Variables.robot
Resource                    ../Settings.robot
Resource                    ../PageImporter.robot

*** Variable ***
${INPUT_TEXT}               vc-input
${BUTTON_SEND}              vc-btn-send
${BUTTON_CLOSE_CHAT}        .vouch-close
${BUTTON_ATTACH_IMAGE}      vc-input-file
${BOT_MESSAGE_BUBBLE}       .vcw-message-bubble.reset-font-size.bot-text-bubble
${BOT_MESSAGE_MENU}         .vcw-gallery
${BOT_MESSAGE_MENU_CARD}    .vcw-card-button
${MESSAGE_PANEL}            vcw-messages
${USER_MESSAGE_BUBBLE}      .vcw-message-bubble.my-bubble



*** Keywords ***

Input Text in Chat Box
    [Arguments]                          ${words}
    Wait Until Element Is Visible        id=${INPUT_TEXT}
    Input Text                           id=${INPUT_TEXT}                                                         ${words}
    Click Element                        id=${BUTTON_SEND}
    sleep                                3

Click One Random Menu
    Get Card Button Length
    ${index}=                            Evaluate                                                                 random.randint(32,${bot_card_button_length-25})                          modules=random, sys
    Scroll Element Into View             ${BOT_MESSAGE_MENU_CARD}:nth(${index})
    Wait Until Element Is Visible        sizzle=${BOT_MESSAGE_MENU_CARD}:nth(${index})                            
    Click Element                        sizzle=${BOT_MESSAGE_MENU_CARD}:nth(${index})

Click Button Close Chat
    Click Element                        sizzle=${BUTTON_CLOSE_CHAT}
    Wait Until Element Is Not Visible    id=${MESSAGE_PANEL}

User Send Image
    Choose File                          id=${BUTTON_ATTACH_IMAGE}                                                /home/kly/Pictures/arrow.png
    Sleep                                5
    Wait Until Element Is Visible        sizzle=${USER_MESSAGE_BUBBLE} a img

Scroll Element Into View
    [Arguments]                          ${locator}
    Execute Javascript                   $('${locator}')[0].scrollIntoView({behavior: "smooth"})
    Sleep                                0.5


################### GET #####################

Get Bot Message Length
    ${bot_message_length}                Execute Javascript                                                       return $('${BOT_MESSAGE_BUBBLE}').length
    Set Suite Variable                   ${bot_message_length}

Get Card Button Length
    ${bot_card_button_length}            Execute Javascript                                                       return $('${BOT_MESSAGE_MENU_CARD}').length
    Set Suite Variable                   ${bot_card_button_length}

Get Bot Response
    Get Bot Last Message
    ${response}=                         Get Text                                                                 sizzle=${BOT_MESSAGE_BUBBLE}:nth(${index})
    Set Suite Variable                   ${response}

Get Bot Last Message
    Get Bot Message Length
    ${index}=                            Evaluate                                                                 "${bot_message_length-1}"
    Set Suite Variable                   ${index}

################### VERIFY #####################

Verify Bot Common Response
    Get Bot Last Message
    Wait Until Element Is Visible        sizzle=${BOT_MESSAGE_BUBBLE}:nth(${index})                               timeout=3

Verify Bot Response While Unknown Text
    Get Bot Response
    Should Be Equal As Strings           ${response}                                                              Sorry, I didn't get that. Could you try saying it in a different way?

Verify Bot Response While Bad Words
    Get Bot Response
    Should Be True                       "I’m sorry that I am unable to assist you here." in """${response}"""

Verify Chat Page
    Wait Until Element Is Visible        id=vc-chat-panel
    Wait Until Element Is Visible        id=vc-censor-alert
    Wait Until Element Is Visible        sizzle=.vouch-close
    Wait Until Element Is Visible        sizzle=.vcw-input
    Wait Until Element Is Visible        sizzle=.vc-btn.vc-btn-image
    Wait Until Element Is Visible        sizzle=.vc-btn.vc-btn-send

Verify Bot Response While User Texting Menu
    Wait Until Element Is Visible        sizzle=${BOT_MESSAGE_MENU}
    Sleep                                5
