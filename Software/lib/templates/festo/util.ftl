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
