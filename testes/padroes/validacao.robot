*** Settings ***

***Keywords***
Conferir Igual
    [Arguments]      ${valor_1}      ${valor_2}
    Should Be Equal As Strings    ${valor_1}    ${valor_2}
    