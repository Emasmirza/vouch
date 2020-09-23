*** Settings ***
Documentation    Running With Timeout 10 minutes
Suite Setup      ${DISPLAY}
Test Timeout     60 minutes
Resource         ../resources-vouch/Keywords.robot
Resource         ../resources-vouch/Variables.robot
Resource         ../resources-vouch/Settings.robot
