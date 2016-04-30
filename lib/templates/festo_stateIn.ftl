<#include "./util.ftl">
<#list task.pous.* as pou> 
	<#if pou?node_name?matches("statein", 'i')>
<#assign input><@getVal pou.INPUT.@address/></#assign>
<#assign output><@getVal pou.OUTPUT.@address/></#assign>
l:${input?replace("X" , "")};
u
l:${input?replace("X" , "")};
q:${output?replace("X", "")};
	</#if>
</#list>
