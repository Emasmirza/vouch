*** Settings ***
Resource          ../Variables.robot
Resource          ../Settings.robot
Resource          ../PageImporter.robot

*** Variable ***
${BUTTON_CHAT}    vc-greeting

*** Keywords ***

Go To Chat Page
    Wait Until Element Is Visible    id=${BUTTON_CHAT}
    Click Element                    id=${BUTTON_CHAT}
    sleep                            3
