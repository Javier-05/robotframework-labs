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
    Click Button    ${BTN_BACKPACK}

Verificar Carrito Con Un Producto
    Wait Until Element Is Visible    ${BADGE_CARRITO}    timeout=10s
    Element Text Should Be    ${BADGE_CARRITO}    1