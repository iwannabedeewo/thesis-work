<#include "./util.ftl">
<#list task.pous.* as pou> 
	<#if pou?node_name?matches("statein", 'i')><#include "/modules/festo_stateIn.ftl" >
	</#if>
</#list>