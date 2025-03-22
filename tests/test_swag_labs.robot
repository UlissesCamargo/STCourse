*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Swag Labs Purchase
    [Documentation]    Demonstrate a login, adding items, removing one, and completing checkout on the new Swag Labs page.

    # 1) Open the page and log in
    Open Browser    https://ulissescamargo.github.io/STCourse/swag_labs.html    Chrome
    ...    options=add_argument("--headless"),add_argument("--no-sandbox"),add_argument("--disable-dev-shm-usage"),add_argument("--disable-gpu")

    Maximize Browser Window
    Wait Until Element Is Visible    id:username
    Sleep    1s
    Input Text    id:username    standard_user
    Input Text    id:password    secret_sauce
    Sleep    1s
    Click Button   id:login-button
    Sleep    2s

    # Wait for product page to become visible
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

    # 3) Go to checkout by clicking the cart icon
    Click Element   css:.cart-icon
    Sleep    2s

    # 4) Remove one item from the cart
    Wait Until Element Is Visible    id:checkout-page
    Wait Until Element Is Visible    xpath=//div[@id='cart-items']/div[1]//button[contains(text(),'Remove')]
    Sleep    1s
    Click Button    xpath=//div[@id='cart-items']/div[1]//button[contains(text(),'Remove')]
    Sleep    2s

    # 5) Fill out the payment data
    Input Text      id:first-name    John
    Input Text      id:last-name     Doe
    Input Text      id:postal-code   12345
    Sleep    2s

    # 6) Scroll to and click "Complete Purchase"
    Scroll Element Into View    xpath=//button[contains(text(),'Complete Purchase')]
    Sleep    1s
    Click Button    xpath=//button[contains(text(),'Complete Purchase')]
    Sleep    2s

    # 7) Verify the confirmation page
    Wait Until Element Is Visible    id:confirmation-page
    Sleep    3s

    [Teardown]    Close Browser
