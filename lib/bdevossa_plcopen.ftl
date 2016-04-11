<#import "./bdevossa_macros.ftl" as util>
<#assign project = document.plcProject>
<#assign info = project.projectInfo>
<#assign task = project.application.task>
<#assign cdt>
	<#compress>
		<@util.getVal info.@creationDate/>T<@util.getVal info.@creationTime/>
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
			<@util.getVal info.modificationDateTime.@date/>T<@util.getVal info.modificationDateTime.@time/>
		</#compress>	
	</#assign>
<#else>
	<#assign mdt = cdt>
</#if>
<?xml version="1.0" encoding="utf-8"?>
<project xmlns="http://www.plcopen.org/xml/tc6_0200">
	<fileHeader 
		companyName="<@util.getVal info.@companyName/>" 
		productName="<@util.getVal info.@productName/>" 
		productVersion="<@util.getVal info.@version/>"
		creationDateTime="${cdt}" />
  	<contentHeader 
  		name="<@util.getVal info.@projectName/>"
  		modificationDateTime="${mdt}" >
		<coordinateInfo>
	    	<fbd>
	        	<scaling x="1" y="1" />
	      	</fbd>
	      	<ld>
	        	<scaling x="1" y="1" />
	      	</ld>
	      	<sfc>
	        	<scaling x="1" y="1" />
	      	</sfc>
	    </coordinateInfo>
	</contentHeader>
	<types>
		<dataTypes />
		<pous />
	</types>
	<instances>
		<configurations />
	</instances>
	<addData>
    	<data name="http://www.3s-software.com/plcopenxml/application" handleUnknown="implementation">
      		<resource name="Application">
    			<task 
    				name="${task.@name?split("\"")[1]}"
    				interval="PT${t_interval}S" 
    				priority="${task.@priority?split("\"")[1]}">
    				<pouInstance name="<@util.getHighestPriority task.pous/>" typeName="">
						<documentation/>
			       	</pouInstance>
			     	<addData>
			        	<data name="http://www.3s-software.com/plcopenxml/tasksettings" handleUnknown="implementation">
			            	<TaskSettings KindOfTask="<@util.getVal task.@type/>" Interval="t#<@util.getVal task.@interval/><@util.getVal task.@intervalUnit/>" IntervalUnit="<@util.getVal task.@intervalUnit/>" WithinSPSTimeSlicing="true"/>
			        	</data>
			     	</addData>
    			</task>
    			<addData>
				<#list task.pous.* as pou> 
					<#if pou?node_name?matches("motor", 'i')><#include "/templates/motor.ftl">
					<#elseif pou?node_name?matches("statein", 'i')><#include "/templates/stateIn.ftl">
					</#if>
	    		</#list>
				</addData>
      		</resource>
    	</data>
  	</addData>
</project>