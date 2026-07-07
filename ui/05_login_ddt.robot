*** Settings ***
Library    SeleniumLibrary
Library    Dialogs
Resource   login_page.resource
Suite Setup    Abrir Navegador
Suite Teardown    Close Browser
Test Template    Validar Intento De Login

*** Test Cases ***                      USUARIO             CLAVE             RESULTADO_ESPERADO
Usuario estandar                        standard_user       secret_sauce      exito
Usuario bloqueado                       locked_out_user     secret_sauce      error
Clave incorrecta                        standard_user       clave_invalida    error
Usuario vacio                           ${EMPTY}            secret_sauce      error

Agregar Producto Al Carrito
    [Template]    NONE
    Go To    https://www.saucedemo.com
    Login Exitoso
    Agregar Backpack Al Carrito
    Verificar Carrito Con Un Producto
    Pause Execution    Toma la captura del carrito con 1 producto y luego presiona OK.

*** Keywords ***
Validar Intento De Login
    [Arguments]    ${usuario}    ${clave}    ${resultado}
    Go To    https://www.saucedemo.com
    Ingresar Credenciales    ${usuario}    ${clave}
    Run Keyword If    '${resultado}' == 'exito'
    ...    Wait Until Page Contains    Products    timeout=15s
    ...    ELSE
    ...    Wait Until Element Is Visible    css:h3[data-test='error']    timeout=15s

Abrir Navegador
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_experimental_option    detach    ${True}
    Open Browser    https://www.saucedemo.com    chrome    options=${options}
    Maximize Browser Window