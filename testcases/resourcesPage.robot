*** Settings ***
Documentation     A test suite with a single test for checking resources page
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../common/resource.robot
Resource          ../common/navigation.robot
Library            String
Library            Collections


*** Variables ***

*** Keywords ***
Navigate to trading times

    Navigate to resources page
    wait until element is visible   xpath= //*[@id="content"]/div[3]/div/div[2]/div[1]/a     10
    click element                   xpath= //*[@id="content"]/div[3]/div/div[2]/div[1]/a

Navigate to Asset Index Page

    Navigate to resources page
    wait until element is visible   xpath=//*[@id="content"]/div[3]/div/div[1]/div[1]/a
    click element                   xpath=//*[@id="content"]/div[3]/div/div[1]/div[1]/a

Verify asset index page is loaded successfuly

    wait until page contains            Asset Index       8

Verify trading time page is loaded successfuly

    wait until page contains            Trading Times       8
Navigate to indices tab

    click element                       xpath=//a[@href="#market_2"]

Navigate to OTC stock tab

    click element                       xpath=//a[@href="#market_3"]

Navigate to Commodities tab

    click element                       xpath=//a[@href="#market_4"]

Navigate to Volatility tab

    click element                       xpath=//a[@href="#market_5"]


verify CR/Mx markets is correct

    wait until element is visible               xpath=//*[@id="trading-times"]/ul/li
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="trading-times"]/ul/li
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="trading-times"]/ul/li[${i}]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Forex
                                                ...     Indices
                                                ...     OTC Stocks
                                                ...     Commodities
                                                ...     Volatility Indices
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

Verifiy asset index - CR/MX Market is correct

    wait until element is visible               xpath=//*[@id="asset-index"]/ul/li
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="asset-index"]/ul/li
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="asset-index"]/ul/li[${i}]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Forex
                                                ...     Indices
                                                ...     OTC Stocks
                                                ...     Commodities
                                                ...     Volatility Indices
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}



verify MF markets is correct

    wait until element is visible               xpath=//*[@id="trading-times"]/ul/li
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="trading-times"]/ul/li
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="trading-times"]/ul/li[${i}]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Forex
                                                ...     Indices
                                                ...     OTC Stocks
                                                ...     Commodities
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}


Verifiy asset index - MF Market is correct

    wait until element is visible               xpath=//*[@id="asset-index"]/ul/li
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="asset-index"]/ul/li
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="asset-index"]/ul/li[${i}]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Forex
                                                ...     Indices
                                                ...     OTC Stocks
                                                ...     Commodities
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}


verify MLT markets is correct

    wait until element is visible               xpath=//*[@id="trading-times"]/ul/li
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="trading-times"]/ul/li
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="trading-times"]/ul/li[${i}]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Volatility Indices
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

Verifiy asset index - MLT Market is correct

    wait until element is visible               xpath=//*[@id="asset-index"]/ul/li
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="asset-index"]/ul/li
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="asset-index"]/ul/li[${i}]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Volatility Indices
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}


verify Major Pairs assets is correct
    wait until element is visible               xpath=//*[@id="Forex-0"]/tbody/tr[*]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Forex-0"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Forex-0"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         AUD/JPY
                                                ...     AUD/USD
                                                ...     EUR/AUD
                                                ...     EUR/CAD
                                                ...     EUR/CHF
                                                ...     EUR/GBP
                                                ...     EUR/JPY
                                                ...     EUR/USD
                                                ...     GBP/AUD
                                                ...     GBP/JPY
                                                ...     GBP/USD
                                                ...     USD/CAD
                                                ...     USD/CHF
                                                ...     USD/JPY
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Minor Pairs assets is correct
    wait until element is visible               xpath=//*[@id="Forex-1"]/tbody/tr[*]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Forex-1"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Forex-1"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         AUD/CAD
                                                ...     AUD/CHF
                                                ...     AUD/NZD
                                                ...     AUD/PLN
                                                ...     EUR/NZD
                                                ...     GBP/CAD
                                                ...     GBP/CHF
                                                ...     GBP/NOK
                                                ...     GBP/NZD
                                                ...     GBP/PLN
                                                ...     NZD/JPY
                                                ...     NZD/USD
                                                ...     USD/MXN
                                                ...     USD/NOK
                                                ...     USD/PLN
                                                ...     USD/SEK
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Smart FX assets is correct

    wait until element is visible               xpath=//*[@id="Forex-2"]/tbody/tr[*]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Forex-2"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Forex-2"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         AUD Index
                                                ...     EUR Index
                                                ...     GBP Index
                                                ...     USD Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Indices-Asia/Oceania assets is correct

    wait until element is visible               xpath=//*[@id="Indices-0"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Indices-0"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Indices-0"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Australian Index
                                                ...     Bombay Index
                                                ...     Hong Kong Index
                                                ...     Jakarta Index
                                                ...     Japanese Index
                                                ...     Singapore Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Indices-Europe/Africa assets is correct

    wait until element is visible               xpath=//*[@id="Indices-1"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Indices-1"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Indices-1"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Belgian Index
                                                ...     Dutch Index
                                                ...     French Index
                                                ...     German Index
                                                ...     Irish Index
                                                ...     Norwegian Index
                                                ...     South African Index
                                                ...     Swiss Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Indices-Americas assets is correct

    wait until element is visible               xpath=//*[@id="Indices-2"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Indices-2"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Indices-2"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         US Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Indices-Middle East assets is correct

    wait until element is visible               xpath=//*[@id="Indices-3"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Indices-3"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Indices-3"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Dubai Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Indices-OTC assets is correct

    wait until element is visible               xpath=//*[@id="Indices-4"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="Indices-4"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Indices-4"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Australian OTC Index
                                                ...     Belgian OTC Index
                                                ...     Bombay OTC Index
                                                ...     Dutch OTC Index
                                                ...     French OTC Index
                                                ...     German OTC Index
                                                ...     Hong Kong OTC Index
                                                ...     Istanbul OTC Index
                                                ...     Japanese OTC Index
                                                ...     US OTC Index
                                                ...     US Tech OTC Index
                                                ...     Wall Street OTC Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify OTC Stock-Germany assets is correct

    wait until element is visible               xpath=//*[@id="OTC Stocks-0"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="OTC Stocks-0"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="OTC Stocks-0"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Airbus
                                                ...     Allianz
                                                ...     BMW
                                                ...     Daimler
                                                ...     Deutsche Bank
                                                ...     Novartis
                                                ...     SAP
                                                ...     Siemens
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify OTC Stock-India assets is correct

    wait until element is visible               xpath=//*[@id="OTC Stocks-1"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="OTC Stocks-1"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="OTC Stocks-1"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Bharti Airtel
                                                ...     Maruti Suzuki
                                                ...     Reliance Industries
                                                ...     Tata Steel
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify OTC Stock-UK assets is correct

    wait until element is visible               xpath=//*[@id="OTC Stocks-2"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="OTC Stocks-2"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="OTC Stocks-2"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         BP
                                                ...     Barclays
                                                ...     British American Tobacco
                                                ...     HSBC
                                                ...     Lloyds Bank
                                                ...     Rio Tinto
                                                ...     Standard Chartered
                                                ...     Tesco
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}


verify OTC Stock-US assets is correct

    wait until element is visible               xpath=//*[@id="OTC Stocks-3"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count   xpath=//*[@id="OTC Stocks-3"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="OTC Stocks-3"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Alibaba
                                                ...     Alphabet
                                                ...     Amazon.com
                                                ...     American Express
                                                ...     Apple
                                                ...     Berkshire Hathaway
                                                ...     Boeing
                                                ...     Caterpillar
                                                ...     Citigroup
                                                ...     Electronic Arts
                                                ...     Exxon Mobil
                                                ...     Facebook
                                                ...     Goldman Sachs
                                                ...     IBM
                                                ...     Johnson & Johnson
                                                ...     MasterCard
                                                ...     McDonald's
                                                ...     Microsoft
                                                ...     PepsiCo
                                                ...     Procter & Gamble
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Commodities - Metal assets is correct

    wait until element is visible               xpath=//*[@id="Commodities-0"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count       xpath=//*[@id="Commodities-0"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Commodities-0"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Gold/USD
                                                ...     Palladium/USD
                                                ...     Platinum/USD
                                                ...     Silver/USD
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Commodities - Energy assets is correct

    wait until element is visible               xpath=//*[@id="Commodities-1"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count       xpath=//*[@id="Commodities-1"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Commodities-1"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Oil/USD
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Volatility Indices-Continuous Indices assets is correct

    wait until element is visible               xpath=//*[@id="Volatility Indices-0"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count       xpath=//*[@id="Volatility Indices-0"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Volatility Indices-0"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Volatility 10 Index
                                                ...     Volatility 100 Index
                                                ...     Volatility 25 Index
                                                ...     Volatility 50 Index
                                                ...     Volatility 75 Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}

verify Volatility Indices-Daily Reset Indices assets is correct

    wait until element is visible               xpath=//*[@id="Volatility Indices-1"]/tbody/tr[1]/td[1]
    ${count}=    Get Matching Xpath Count       xpath=//*[@id="Volatility Indices-1"]/tbody/tr[*]/td[1]
    ${ACTUAL_MARKKETS}=    Create List
    :FOR    ${i}    IN RANGE    1    ${count}+1
    \   ${ACTUAL_MARKKET}=    Get Text        xpath=//*[@id="Volatility Indices-1"]/tbody/tr[${i}]/td[1]
    \    Append To List   ${ACTUAL_MARKKETS}    ${ACTUAL_MARKKET}
    ${EXPECTED_MARKET}      create list         Bear Market Index
                                                ...     Bull Market Index
    log      ${ACTUAL_MARKKETS}
    lists should be equal  ${ACTUAL_MARKKETS}    ${EXPECTED_MARKET}


*** Test Cases ***
Check CR trading Times Page
    open browser to login page
    login using crypto account
    Navigate to trading times
    verify trading time page is loaded successfuly
    verify CR/MX markets is correct
    verify Major Pairs assets is correct
    verify Minor Pairs assets is correct
    verify Smart FX assets is correct
    navigate to indices tab
    verify Indices-Asia/Oceania assets is correct
    verify Indices-Americas assets is correct
    verify Indices-Middle East assets is correct
    verify Indices-Europe/Africa assets is correct
    verify Indices-OTC assets is correct
    Navigate to OTC stock tab
    verify OTC Stock-Germany assets is correct
    verify OTC Stock-India assets is correct
    verify OTC Stock-UK assets is correct
    verify OTC Stock-US assets is correct
    navigate to commodities tab
    verify Commodities - Metal assets is correct
    verify Commodities - Energy assets is correct
    Navigate to Volatility tab
    verify Volatility Indices-Continuous Indices assets is correct
    verify Volatility Indices-Daily Reset Indices assets is correct
    capture page screenshot

check Asset Index CR

    Navigate to Asset Index Page
    verify asset index page is loaded successfuly
    verifiy asset index - cr/mx market is correct

    [Teardown]    Close Browser

Check MLT/MF trading Times Page
    open browser to login page
    login using mlt/mf account
    Navigate to trading times
    verify trading time page is loaded successfuly
    verify MF markets is correct
    verify Major Pairs assets is correct
    verify Minor Pairs assets is correct
    verify Smart FX assets is correct
    navigate to indices tab
    verify Indices-Asia/Oceania assets is correct
    verify Indices-Americas assets is correct
    verify Indices-Middle East assets is correct
    verify Indices-Europe/Africa assets is correct
    verify Indices-OTC assets is correct
    Navigate to OTC stock tab
    verify OTC Stock-Germany assets is correct
    verify OTC Stock-India assets is correct
    verify OTC Stock-UK assets is correct
    verify OTC Stock-US assets is correct
    navigate to commodities tab
    verify Commodities - Metal assets is correct
    verify Commodities - Energy assets is correct
    switch to mlt account
    verify trading time page is loaded successfuly
    verify MLT markets is correct
    verify Volatility Indices-Continuous Indices assets is correct
    verify Volatility Indices-Daily Reset Indices assets is correct
    capture page screenshot

Check Asset Index MLT/MF


    navigate to asset index page
    verify asset index page is loaded successfuly
    verifiy asset index - mlt market is correct
    switch to mf account
    verify asset index page is loaded successfuly
    verifiy asset index - mf market is correct

    [Teardown]    Close Browser

Check MX trading Times Page
    open browser to login page
    login using mx account
    Navigate to trading times
    verify trading time page is loaded successfuly
    verify CR/Mx markets is correct
    verify Major Pairs assets is correct
    verify Minor Pairs assets is correct
    verify Smart FX assets is correct
    navigate to indices tab
    verify Indices-Asia/Oceania assets is correct
    verify Indices-Americas assets is correct
    verify Indices-Middle East assets is correct
    verify Indices-Europe/Africa assets is correct
    verify Indices-OTC assets is correct
    Navigate to OTC stock tab
    verify OTC Stock-Germany assets is correct
    verify OTC Stock-India assets is correct
    verify OTC Stock-UK assets is correct
    verify OTC Stock-US assets is correct
    navigate to commodities tab
    verify Commodities - Metal assets is correct
    verify Commodities - Energy assets is correct
    navigate to volatility tab
    verify Volatility Indices-Continuous Indices assets is correct
    verify Volatility Indices-Daily Reset Indices assets is correct
    capture page screenshot

Check Asset Index MX

    navigate to asset index page
    verify asset index page is loaded successfuly
    verifiy asset index - cr/mx market is correct
    [Teardown]    Close Browser