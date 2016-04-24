<#assign project = document.plcProject>
<#assign info = project.projectInfo>
<#assign task = project.application.task>
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
<#assign cdt>
	<#compress>
		<@getVal info.@creationDate/>T<@getVal info.@creationTime/>
	</#compress>
</#assign>
<#if task.@intervalUnit?contains("us")>
	<#assign t_interval = (1 / 1000000 * task.@interval?split("\"")[1]?number)?replace(",", ".")> 
<#else>
	<#assign t_interval = (1 / 1000 * task.@interval?split("\"")[1]?number)?replace(",", ".")>
</#if>
<#if info.modificationDateTime?has_content>
	<#assign mdt>
		<#compress>
			<@getVal info.modificationDateTime.@date/>T<@getVal info.modificationDateTime.@time/>
		</#compress>	
	</#assign>
<#else>
	<#assign mdt = cdt>
</#if>