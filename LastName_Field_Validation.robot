*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}                                                  Chrome
${url}                                                      https://www.adrenalinmedia.com.au/
${firstname_alphabet}                                       Jennifer
${lastname_alphabet}                                        Blue
${lastname_numeric}                                         1234567
${lastname_specialcharacters}                               !@#$%^&*()_+-=`~[]\{}|;':",./<>?

*** Test Cases ***
AdrenalinContact Page
    Open Browser                        ${url}  ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait          30
    Click Element                       xpath://span[normalize-space()='Contact']
    Set Selenium Implicit Wait          30
    Wait Until Page Contains Element    xpath://h3[normalize-space()='Project Enquiry']
    Capture Page Screenshot

LastName Field Validation
    Set Selenium Implicit Wait          1
    Scroll Element Into View            name:firstname
    Input Text                          name:firstname    ${firstname_alphabet}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Scroll Element Into View            xpath://span[text()='Phone number']/../..
    Scroll Element Into View            name:lastname
    Input Text                          name:lastname    ${lastname_alphabet}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:lastname    ${EMPTY}
    Input Text                          name:lastname    ${lastname_numeric}
    Page Should Not Contain Element     xpath://div[@class='hs_lastname hs-lastname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:lastname    ${EMPTY}
    Input Text                          name:lastname    ${lastname_specialcharacters}
    Page Should Not Contain Element     xpath://div[@class='hs_lastname hs-lastname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:lastname    ${EMPTY}
    Scroll Element Into View            xpath://input[@value='Submit']
    Submit Button
    Scroll Element Into View            xpath://span[text()='Phone number']/..
    Page Should Contain Element         xpath://div[@class='hs_lastname hs-lastname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Reload Page
    Page Should Not Contain Element     xpath://div[@class='hs_lastname hs-lastname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Capture Page Screenshot
    Close Browser

*** Keywords ***
Submit Button
    Click Element    xpath://input[@value='Submit']