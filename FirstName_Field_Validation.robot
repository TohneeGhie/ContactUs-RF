*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${browser}                                                  Chrome
${url}                                                      https://www.adrenalinmedia.com.au/
${firstname_alphabet}                                       Jennifer
${firstname_numeric}                                        1234567890
${firstname_specialcharacters}                              !@#$%^&*()_+-=`~[]\{}|;':",./<>?
${lastname_alphabet}                                        Blue
${lastname_numeric}                                         1234567
${lastname_specialcharacters}                               !@#$%^&*()_+-=`~[]\{}|;':",./<>?
${correct_phonenumber_count7}                               1234567
${correct_phonenumber_count20}                              12345678917894561230
${incorrect_phonenumber_count5}                             12345
${incorrect_phonenumber_count21}                            123456789178945612301
${correct_email}                                            jenniferblue@gmail.com
${incorrect_email}                                          jenniferblue
${jobtitle_alphabet}                                        QA Engineer
${jobtitle_numeric}                                         1234567890
${jobtitle_specialcharacters}                               !@#$%^&*()_+-=`~[]\{}|;':",./<>?
${companyname_alphabet}                                     ABC Company
${companyname_numeric}                                      1234567890
${companyname_specialcharacters}                            !@#$%^&*()_+-=`~[]\{}|;':",./<>?
${messagebox_alphanumericspecialcharacters_count500}        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, ~!@#$%^&*()_+`-={}|[]\;':",./<>?

*** Test Cases ***
AdrenalinContact Page
    Open Browser                        ${url}  ${browser}
    Maximize Browser Window
    Set Selenium Implicit Wait          30
    Click Element                       xpath://span[normalize-space()='Contact']
    Set Selenium Implicit Wait          30
    Wait Until Page Contains Element    xpath://h3[normalize-space()='Project Enquiry']
    Capture Page Screenshot

FirstName Field Validation
    Set Selenium Implicit Wait          3
    Scroll Element Into View            xpath://span[text()='Last name']/../..
    Capture Page Screenshot
    Scroll Element Into View            name:firstname
    Input Text                          name:firstname    ${firstname_alphabet}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:firstname    ${EMPTY}
    Input Text                          name:firstname    ${firstname_numeric}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:firstname    ${EMPTY}
    Input Text                          name:firstname    ${firstname_specialcharacters}
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Set Selenium Implicit Wait          3
    Capture Page Screenshot
    Input Text                          name:firstname    ${EMPTY}
    Scroll Element Into View            xpath://input[@value='Submit']
    Submit Button
    Scroll Element Into View            xpath://span[text()='Last name']/../..
    Page Should Contain Element         xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Capture Page Screenshot
    Reload Page
    Page Should Not Contain Element     xpath://div[@class='hs_firstname hs-firstname hs-fieldtype-text field hs-form-field']//label[@class='hs-error-msg hs-main-font-element'][normalize-space()='Please complete this required field.']
    Capture Page Screenshot
    Close Browser

*** Keywords ***
Submit Button
    Click Element    xpath://input[@value='Submit']