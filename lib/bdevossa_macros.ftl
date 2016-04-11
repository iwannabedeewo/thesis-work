<#macro getHighestPriority list>
	<#assign prio = "1000">
	<#list list.* as pou>
		<#if pou.@priority?has_content && pou.@priority?split("\"")[1]?number < prio?number>		
			<#assign prio = pou.@priority?split("\"")[1]>
			<#assign return = pou.@name?split("\"")[1]>
		</#if>
	</#list>
	<#compress>
		${return}
	</#compress>
</#macro>

<#macro getVal attr>
	<#if attr?has_content>
		<#compress>
			${attr?split("\"")[1]}
		</#compress>
	</#if>
</#macro>
