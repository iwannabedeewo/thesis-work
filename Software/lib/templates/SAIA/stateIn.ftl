<#assign prior><@getVal pou.@priority/></#assign>
            COB    ${prior}
                   ${prior}
                   
            STH     <@getSAIAAddr pou.INPUT.@address/>         
            SET     <@getSAIAAddr pou.OUTPUT.@address/>

            ECOB

;===========================================
;===========================================
;===========================================

