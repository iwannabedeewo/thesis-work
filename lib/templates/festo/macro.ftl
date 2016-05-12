<#macro getVal attr>
	<#if attr?has_content>
		<#compress>
			${attr?split("\"")[1]}
		</#compress>
	</#if>
</#macro>
<#macro getAlAddr arg>
		<#assign val><@getVal arg/></#assign>
		<#compress>
			${val?replace("X","")?replace("I", "E")?replace("Q", "A")}
		</#compress>
</#macro>
<#macro getAddress ip>
	<#if ip?has_content>
		<#assign value><@getVal ip/></#assign>
		<#compress>
			${value}
		</#compress>
	<#else>
		<#compress>
			0.0.0.0
		</#compress>
	</#if>
</#macro>