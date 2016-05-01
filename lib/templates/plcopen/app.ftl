<#include "./util.ftl">
<?xml version="1.0" encoding="utf-8"?>
<project xmlns="http://www.plcopen.org/xml/tc6_0200">
	<fileHeader 
		companyName="<@getVal info.@companyName/>" 
		productName="<@getVal info.@productName/>" 
		productVersion="<@getVal info.@version/>"
		creationDateTime="${cdt}" />
  	<contentHeader 
  		name="<@getVal info.@projectName/>"
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
		<configurations>
			<configuration name="<@getVal info.@projectName/>">
				<resource name="Application">
	    			<task 
	    				name="<@getVal task.@name/>"
	    				interval="PT${t_interval}S" 
	    				priority="${task.@priority?split("\"")[1]}">
	    				<pouInstance name="<@getHighestPriority task.pous/>" typeName="">
							<documentation>
								<xhtml xmlns="http://www.w3.org/1999/xhtml" />
							</documentation>	
				       	</pouInstance>
				     	<addData>
				        	<data name="http://www.3s-software.com/plcopenxml/tasksettings" handleUnknown="implementation">
				            	<TaskSettings KindOfTask="<@getVal task.@type/>" Interval="t#<@getVal task.@interval/><@getVal task.@intervalUnit/>" IntervalUnit="<@getVal task.@intervalUnit/>" WithinSPSTimeSlicing="true"/>
				        	</data>
				     	</addData>
	    			</task>
	    			<addData>
					<#list task.pous.* as pou> 
						<#if pou?node_name?matches("motor", 'i')><#include "/pous/motor.ftl">
						<#elseif pou?node_name?matches("statein", 'i')><#include "/pous/stateIn.ftl">
						<#elseif pou?node_name?matches("fuzzy", 'i')><#include "/pous/fuzzy.ftl">
						</#if>
		    		</#list>
					<data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
              			<ObjectId>127ded09-2300-4688-b7eb-68e6c61e9a48</ObjectId>
            		</data>
					</addData>
	      		</resource>
	      		<addData>
					<#include "./devices/plc.ftl">
					<#include "./devices/ethernet.ftl">
				</addData>
			</configuration>
		</configurations>
	</instances>
	<addData/>
</project>