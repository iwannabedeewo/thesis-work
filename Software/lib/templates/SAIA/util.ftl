<#include "macro.ftl">
<#assign project = document.plcProject>
<#assign info = project.projectInfo>
<#assign app = project.application>
<#assign task = app.task>
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