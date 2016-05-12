<#include "util.ftl">
<#list task.pous.* as pou> 
	<#if pou?node_name?matches("statein", 'i')><#include "statein.ftl"></#if>
	<#if pou?node_name?matches("blinker", 'i')><#include "blinker.ftl"></#if>
</#list>