*** Settings ***
Documentation     A Navigaton file with reusable keywords and variables for navigation.
...

Library		     String
Library           Selenium2Library 


*** Keywords ***

Navigate to setting&security
    Sleep  5
    Click Element	css=div.account-id
    Click Element	css=li.topMenuSecurity
    Wait Until Page Contains	Security   5

Navigate to cashier page

    click element                       xpath=//*[@id="topMenuCashier"]/a


