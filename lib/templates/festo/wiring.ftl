<#include "macro.ftl"/>
<#assign wiring = document.wiring>
<#list wiring.Condition as cond>
	<#assign from><@getVal cond.@if/></#assign>
	<#assign to><@getVal cond.@start/></#assign>             
l:${from?replace("X", "")};
q:${to?replace("X", "")};

</#list>
