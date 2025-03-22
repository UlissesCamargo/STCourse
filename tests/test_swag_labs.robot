*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Swag Labs Purchase
    [Documentation]    Demonstrate a login, adding items, removing one, and completing checkout.

    Open Browser    https://ulissescamargo.github.io/STCourse/swag_labs.html    Chrome
    ...    options=--headless
    ...    options=--no-sandbox

    # The rest of your test steps:
    Maximize Browser Window
    Wait Until Element Is Visible    id:username
    Sleep    1s
    Input Text    id:username    standard_user
    Input Text    id:password    secret_sauce
    Sleep    1s
    Click Button   id:login-button
    Sleep    2s

    Wait Until Element Is Visible    id:product-page
    Sleep    1s

    # 2) Add three items to cart
    Wait Until Element Is Visible    xpath=//div[@id='products-grid']/div[1]//button
    Click Button    xpath=//div[@id='products-grid']/div[1]//button
    Sleep    1s
    Click Button    xpath=//div[@id='products-grid']/div[2]//button
    Sleep    1s
    Click Button    xpath=//div[@id='products-grid']/div[3]//button
    Sleep    2s

    # 3) Go to checkout
    Click Element   css:.cart-icon
    Sleep    2s

    # 4) Remove one item from the cart
    Wait Until Element Is Visible    id:checkout-page
    Wait Until Element Is Visible    xpath=//div[@id='cart-items']/div[1]//button[contains(text(),'Remove')]
    Sleep    1s
    Click Button    xpath=//div[@id='cart-items']/div[1]//button[contains(text(),'Remove')]
    Sleep    2s

    # 5) Fill out payment data
    Input Text      id:first-name    John
    Input Text      id:last-name     Doe
    Input Text      id:postal-code   12345
    Sleep    2s

    # 6) Finish purchase
    Scroll Element Into View    xpath=//button[contains(text(),'Complete Purchase')]
    Sleep    1s
    Click Button    xpath=//button[contains(text(),'Complete Purchase')]
    Sleep    2s

    # 7) Verify
    Wait Until Element Is Visible    id:confirmation-page
    Sleep    3s

    [Teardown]    Close Browser
