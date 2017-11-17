
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
    reload page
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a/img
    click element                   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a

Navigate to JP limit page

    Navigate to JP setting&security
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a/img     10
    reload page
    wait until element is visible   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a/img     10
    click element                   xpath=//*[@id="settings_container"]/div/div[4]/div[1]/a



Verify the page is loaded successfuly

    sleep  5
    page should contain                     Trading and Withdrawal Limits
    ${USER_ID}      get text                xpath=//*[@id="main-account"]/li/a/div[1]/div[2]
    element text should be                  xpath=//*[@id="trading-limits"]              ${USER_ID} - Trading Limits
    wait until element is visible           xpath=//*[@id="client-limits"]      10
    wait until element is visible           xpath=//*[@id="withdrawal-title"]   10
    element text should be                  xpath=//*[@id="withdrawal-title"]           ${USER_ID} - Withdrawal Limits

Verify the page in JP is loaded successfuly

    sleep  5
    page should contain                     取引上限及び出金限度額の設定
    ${USER_ID}      get text                xpath=//*[@id="main-account"]/li/a/div[1]/div[2]
    element text should be                  xpath=//*[@id="trading-limits"]              ${USER_ID} - 取引上限について
    wait until element is visible           xpath=//*[@id="client-limits"]
    element should not be visible           xpath=//*[@id="withdrawal-title"]

Verify limit values are correct

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



    page should contain                     Your withdrawal limit is BTC
    page should contain                     You have already withdrawn BTC
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is BTC



# Verify BCH Limit Page


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



    page should contain                     Your withdrawal limit is BCH
    page should contain                     You have already withdrawn BCH
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is BCH

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



    page should contain                     Your withdrawal limit is LTC
    page should contain                     You have already withdrawn LTC
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is LTC

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

    page should not contain                 Forex
    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         300,000.00
    element text should be                  payout                                                  50,000.00
    element text should be                  payout-per-symbol-and-contract-type                     20,000.00


   element should not be visible                    xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Smart FX")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Minor Pairs")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Major Pairs")]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]
   element should not be visible                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]
   element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]          500,000.00



    page should contain                     Your withdrawal limit is USD 2,000.00 (or equivalent in other currency).
    page should contain                     You have already withdrawn the equivalent of USD 0.00.
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is USD 2,000.00 (or equivalent in other currency).

Verify MX limit Page


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

    page should contain                     Your 30 day withdrawal limit is currently GBP 3,000.00 (or equivalent in other currency).
    page should contain                     You have already withdrawn the equivalent of GBP 0.00 in aggregate over the last 30 days.
    page should contain                     Therefore your current immediate maximum withdrawal (subject to your account having sufficient funds) is GBP 3,000.00 (or equivalent in other currency).

verify JP limit Page

    element text should be                  open-positions                                          60
    element text should be                  account-balance                                         30,000,000
    element text should be                  payout                                                  500,000
    element text should be                  payout-per-symbol-and-contract-type                     400,000

    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"1週間以下（1通貨ペア毎）")]/td[2]       200,000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"1ヶ月以上（1通貨ペア毎）")]/td[2]       200,000
    element text should be                  xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"1日あたりに購入できる限度額")]/td[2]     500,000
    element should not be visible                    xpath=//*[@id="client-limits"]/tbody/tr[19]/td[2]
    element should not be visible                    xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"OTC Stocks")]/td[2]
    element should not be visible                   xpath=//*[@id="client-limits"]/tbody/tr[contains(.,"Volatility Indices")]/td[2]



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
    #switch to bch account
    #verify the page is loaded successfuly
    #verify BCH limit page
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

Check Limit Page for MXAccount

    open login page in xvfb browser
    login using MX account
    navigate to limit page
    verify the page is loaded successfuly
    verify MX limit page
    [Teardown]    Close Browser

Check Limit Page for JP Account

    open xvfb browser then login using jp account
    Navigate to JP limit page
    verify the page in jp is loaded successfuly
    verify JP limit Page
    [Teardown]    close browser