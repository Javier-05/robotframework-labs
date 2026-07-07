*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}        https://www.saucedemo.com
${BROWSER}    chrome

*** Test Cases ***
Login Exitoso Con Usuario Valido
    Abrir Sitio Swag Labs
    Iniciar Sesion    standard_user    secret_sauce
    Verificar Login Exitoso

Login Fallido Con Usuario Bloqueado
    Abrir Sitio Swag Labs
    Iniciar Sesion    locked_out_user    secret_sauce
    Verificar Mensaje De Error

*** Keywords ***
Abrir Sitio Swag Labs
    Open Browser    ${URL}    ${BROWSER}    options=add_experimental_option("detach", True)
    Maximize Browser Window

Iniciar Sesion
    [Arguments]    ${usuario}    ${clave}
    Input Text    id:user-name    ${usuario}
    Input Password    id:password    ${clave}
    Click Button    id:login-button

Verificar Login Exitoso
    Wait Until Page Contains    Products    timeout=5s

Verificar Mensaje De Error
    Wait Until Element Is Visible    css:h3[data-test='error']    timeout=5s