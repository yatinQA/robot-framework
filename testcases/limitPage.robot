
*** Settings ***
Documentation     A test suite with a single test for checking  Limit Page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***

*** Keywords ***

Navigate to limit page

    Navigate to setting&security
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a/img
    click element                   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a


Verify the page is loaded successfuly

    sleep  5
    page should contain                     Trading and Withdrawal Limits
    ${USER_ID}      get text                xpath=//*[@id="main-account"]/li/a/div[1]/div[2]
    element text should be                  xpath=//*[@id="trading-limits"]              ${USER_ID} - Trading Limits
    wait until element is visible           xpath=//*[@id="client-limits"]
    wait until element is visible           xpath=//*[@id="withdrawal-title"]
    element text should be                  xpath=//*[@id="withdrawal-title"]           ${USER_ID} - Withdrawal Limits

Verify limit values are correct

    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         300,000.00
    element text should be                  payout                                                  50,000.00
    element text should be                  payout-per-symbol-and-contract-type                     20,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[6]/td[2]        10,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration up to 7 days")]/td[2]        3,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration above 7 days")]/td[2]       10,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[13]/td[2]       50,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]                     50,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]                  50,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]                  100,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]       100,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]                   1,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]           500,000.00

Verify BTC Limit Page

    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         50.00000000
    element text should be                  payout                                                  1.00000000
    element text should be                  payout-per-symbol-and-contract-type                     2.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[6]/td[2]        2.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration up to 7 days")]/td[2]       1.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration above 7 days")]/td[2]       2.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[13]/td[2]       5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]                     5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]                  5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]                 15.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]       15.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]                   0.20000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]           30.00000000



    page should contain                     Your withdrawal limit is BTC 10,000.00.
    page should contain                     You have already withdrawn BTC 0.00000000.
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is BTC 10,000.00.


Verify BCH Limit Page


    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         100.00000000
    element text should be                  payout                                                  10.00000000
    element text should be                  payout-per-symbol-and-contract-type                     5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[6]/td[2]        5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration up to 7 days")]/td[2]       5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration above 7 days")]/td[2]       5.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[13]/td[2]       10.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]                    10.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]                 10.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]                 10.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]       10.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]                   1.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]           20.00000000



    page should contain                     Your withdrawal limit is BCH 10,000.00.
    page should contain                     You have already withdrawn BCH 0.00000000.
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is BCH 10,000.00.

Verify LTC limit Page

    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         500.00000000
    element text should be                  payout                                                  50.00000000
    element text should be                  payout-per-symbol-and-contract-type                     50.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[6]/td[2]        50.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration up to 7 days")]/td[2]       50.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration above 7 days")]/td[2]       50.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[13]/td[2]       250.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]                    250.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]                 250.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]                 250.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]       250.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]                   10.00000000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]           500.00000000



    page should contain                     Your withdrawal limit is LTC 10,000.00.
    page should contain                     You have already withdrawn LTC 0.00000000.
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is LTC 10,000.00.

Verify MF limit Page

    page should not contain                 Volatility Indices


    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         300,000.00
    element text should be                  payout                                                  50,000.00
    element text should be                  payout-per-symbol-and-contract-type                     20,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[6]/td[2]        10,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration up to 7 days")]/td[2]        3,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Duration above 7 days")]/td[2]       10,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[13]/td[2]       50,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]                     50,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]                  50,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]                  100,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]       100,000.00
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]                   1,000.00
    element should not be visible           xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]



    page should contain                     Your account is fully authenticated and your withdrawal limits have been lifted.

Verify MLT limit Page

    page should not contain                 Forex  Commodities  Indices
    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         300,000.00
    element text should be                  payout                                                  50,000.00
    element text should be                  payout-per-symbol-and-contract-type                     20,000.00

   element should not be visible                   xpath=//*[@id="client-limits"]/tbody/tr[13]/td[2]
   element should not be visible                    xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]



    page should contain                     Your account is fully authenticated and your withdrawal limits have been lifted.

*** Test Cases ***
Check Limit Page for CR Account
    Open Login page in xvfb browser
    login using crypto account
    sleep   5
    Navigate to limit page
    verify the page is loaded successfuly
    verify limit values are correct
    switch to BTC Account
    verify the page is loaded successfuly
    verify BTC limit page
    switch to bch account
    verify the page is loaded successfuly
    verify BCH limit page
    switch to ltc account
    verify the page is loaded successfuly
    verify LTC limit page
    [Teardown]    Close Browser



Check Limit Page for MLT/MF Account

    open login page in xvfb browser
    login using mlt/mf account
    navigate to limit page
    verify the page is loaded successfuly
    verify mf limit page
    switch to mlt account
    verify the page is loaded successfuly
    verify mlt limit page
    [Teardown]    Close Browser