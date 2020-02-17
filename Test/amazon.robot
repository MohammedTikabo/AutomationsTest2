*** Settings ***
Documentation       This is some basic info about the whole test suite
Library             SeleniumLibrary

Test Setup          Begin Web Test
Test Teardown       End Web Test

*** Variables ***

${BROWSER} =   chrome
${URL} =  http://www.amazon.com

*** Keywords ***
Begin Web Test
    Open Browser                     about:blank    ${BROWSER}
    Set Selenium Speed              1
    Maximize Browser Window
Go To Web Page
    Load Page
    Verify Page Loaded

Load Page
     Go To                           ${URL}

Verify Page Loaded
        ${link_text} =               Get Text  id:nav-your-amazon
        Should be Equal               ${link_text}  Your Amazon.com

Search for Product
    [Arguments]                     ${search_term}  ${search_results}
    Enter Search Term               ${search_term}
    Submit Search
    Verify Search Completed         ${search_term}  ${search_results}

Enter Search Term
      [Arguments]                     ${search_term}
       Input Text                       id:twotabsearchtextbox  ${search_term}

Submit Search
     Click Button                     xpath://*[@id="nav-search"]/form/div[2]/div/input

Verify Search Completed
        [Arguments]                     ${search_term}  ${search_results}
        ${results_text} =               Set Variable    results for "${search_term}"
        Should Be Equal                 ${results_text}     ${search_results}

End Web Test
        Close Browser

*** Test Cases ***

User can choose an item for shopping cart
        [Documentation]             This is same basic info about the test1
        [Tags]                      Test 1
        Go To Web Page
        Search for Product          huawei p30 lite    results for "huawei p30 lite"
        ${Item} =                   Get Text  xpath://*[@id="search"]/div[1]/div[2]/div/span[4]/div[1]/div[1]/div/span/div/div/div/div/div[2]/div[2]/div/div[1]/div/div/div[1]/h2/a/span
        #klicka på huawei p30 lite
        Click Element                xpath://*[@id="search"]/div[1]/div[2]/div/span[4]/div[1]/div[1]/div/span/div/div/div/div/div[2]/div[2]/div/div[1]/div/div/div[1]/h2/a/span
        #lägg till huawei p30 i varukorg
        Click Element               Xpath://*[@id="add-to-cart-button"]
        #klicka på varukorg
        Click Element               Xpath://*[@id="hlb-view-cart"]
        ${SelectedItem} =         Get Text  class:sc-product-title
        Should Be Equal             ${Item}     ${SelectedItem}




