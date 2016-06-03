<#include "macro.ftl"/>
<#assign wiring = document.wiring>
	 COB    0
            0
<#list wiring.Condition as cond>
                   
     STH     <@getSAIAAddr cond.@if/>         
     SET     <@getSAIAAddr cond.@start/>

</#list>

     ECOB
