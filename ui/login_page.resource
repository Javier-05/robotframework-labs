*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${INPUT_USER}       id:user-name
${INPUT_PASS}       id:password
${BTN_LOGIN}        id:login-button
${MSG_ERROR}        css:h3[data-test='error']
${BTN_BACKPACK}     id:add-to-cart-sauce-labs-backpack
${BADGE_CARRITO}    css:.shopping_cart_badge

*** Keywords ***
Ingresar Credenciales
    [Arguments]    ${usuario}    ${clave}
    Wait Until Element Is Visible    ${INPUT_USER}    timeout=10s
    Clear Element Text    ${INPUT_USER}
    Clear Element Text    ${INPUT_PASS}
    Input Text    ${INPUT_USER}    ${usuario}
    Input Password    ${INPUT_PASS}    ${clave}
    Click Button    ${BTN_LOGIN}

Login Exitoso
    Ingresar Credenciales    standard_user    secret_sauce
    Wait Until Page Contains    Products    timeout=10s

Agregar Backpack Al Carrito
    Wait Until Element Is Visible    ${BTN_BACKPACK}    timeout=10s
    Scroll Element Into View         ${BTN_BACKPACK}
    Wait Until Keyword Succeeds      10s    1s    Click Element    ${BTN_BACKPACK}
    ${clicked}=    Run Keyword And Return Status    Element Text Should Be    ${BTN_BACKPACK}    Remove
    Run Keyword If    not ${clicked}    Execute JavaScript    document.querySelector('#add-to-cart-sauce-labs-backpack').click()

Verificar Carrito Con Un Producto
    Wait Until Keyword Succeeds    10s    1s    Element Should Contain    id:remove-sauce-labs-backpack    Remove
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    ${BADGE_CARRITO}
    Element Text Should Be         ${BADGE_CARRITO}    1