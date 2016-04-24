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
	    				name="${task.@name?split("\"")[1]}"
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
						</#if>
		    		</#list>
					</addData>
	      		</resource>
				<addData>
		          <data name="Device" handleUnknown="discard">
		            <Device xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="">
		              <DeviceType>
		                <DeviceIdentification>
		                  <Type>4102</Type>
		                  <Id>0000 0001</Id>
		                  <Version>3.5.8.20</Version>
		                </DeviceIdentification>
		                <Connector moduleType="256" interface="Common.PCI" connectorId="0">
		                  <HostParameterSet />
		                </Connector>
		                <Connector moduleType="769" interface="SafetyInterface" connectorId="1">
		                  <HostParameterSet />
		                </Connector>
		                <Connector moduleType="1279" interface="Common.SoftMotion.General" connectorId="2">
		                  <HostParameterSet />
		                </Connector>
		                <DeviceParameterSet />
		              </DeviceType>
		            </Device>
		          </data>
		          <data name="configurations" handleUnknown="discard">
		            <configurations />
		          </data>
		          <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
		            <ObjectId>88631836-5620-4d43-a6e6-729cd17dbea9</ObjectId>
		          </data>
	        	</addData>
			</configuration>
		</configurations>
	</instances>
	<addData/>
</project>