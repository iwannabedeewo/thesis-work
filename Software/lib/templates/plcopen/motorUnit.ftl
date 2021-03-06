<#include "./util.ftl">
<#list task.pous.* as pou> 
	<#if pou?node_name?matches("motor", 'i')>
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
      <configuration name="<@getVal pou.@name/>_Motor">
        <addData>
          <data name="Device" handleUnknown="discard">
            <Device xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="">
              <DeviceType>
                <DeviceIdentification>
                  <Type>1024</Type>
                  <Id>FFFF 0001</Id>
                  <Version>3.5.5.0</Version>
                </DeviceIdentification>
                <Connector moduleType="1024" role="child" interface="Common.SoftMotion.General" connectorId="0">
                  <HostParameterSet>
                    <ParameterSection>
                      <Name>AXIS_REF: Standard</Name>
                      <Description />
                      <Parameter ParameterId="1021" type="std:WORD">
                        <Attributes />
                        <Value>0</Value>
                        <Name>wDriveID</Name>
                        <Description>ID of drive</Description>
                      </Parameter>
                      <Parameter ParameterId="1040" type="std:BOOL">
                        <Attributes offlineaccess="read" onlineaccess="read" />
                        <Value>TRUE</Value>
                        <Name>bVirtual</Name>
                        <Description>drive is simulated</Description>
                      </Parameter>
                      <Parameter ParameterId="1051" type="std:DWORD">
                        <Attributes />
                        <Value>1</Value>
                        <Name>dwRatioTechUnitsDenom</Name>
                        <Description>conversion inc./tech.units denominator</Description>
                      </Parameter>
                      <Parameter ParameterId="1052" type="std:DINT">
                        <Attributes />
                        <Value>1</Value>
                        <Name>iRatioTechUnitsNum</Name>
                        <Description>conversion inc./tech.units numerator</Description>
                      </Parameter>
                      <Parameter ParameterId="1060" type="std:INT">
                        <Attributes />
                        <Value>1</Value>
                        <Name>iMovementType</Name>
                        <Description>movement type: 0: rotary/modulo, 1: linear</Description>
                      </Parameter>
                      <Parameter ParameterId="1061" type="std:LREAL">
                        <Attributes />
                        <Value>360.0</Value>
                        <Name>fPositionPeriod</Name>
                        <Description>modulo value for rotary drives</Description>
                      </Parameter>
                      <Parameter ParameterId="1062" type="std:INT">
                        <Attributes />
                        <Value>0</Value>
                        <Name>eRampType</Name>
                        <Description>selects the velocity ramp type used by the FBs</Description>
                      </Parameter>
                      <Parameter ParameterId="1113" type="std:LREAL">
                        <Attributes />
                        <Value>1e3</Value>
                        <Name>fSWMaxVelocity</Name>
                        <Description>maximum velocity value used for limit check at SMC_ControlAxisByPos</Description>
                      </Parameter>
                      <Parameter ParameterId="1123" type="std:LREAL">
                        <Attributes />
                        <Value>1e5</Value>
                        <Name>fSWMaxAcceleration</Name>
                        <Description>maximum acceleration value used for limit check at SMC_ControlAxisByPos</Description>
                      </Parameter>
                      <Parameter ParameterId="1133" type="std:LREAL">
                        <Attributes />
                        <Value>1e5</Value>
                        <Name>fSWMaxDeceleration</Name>
                        <Description>maximum deceleration value used for limit check at SMC_ControlAxisByPos</Description>
                      </Parameter>
                      <Parameter ParameterId="1144" type="std:LREAL">
                        <Attributes />
                        <Value>0</Value>
                        <Name>fRampJerk</Name>
                        <Description>jerk used for bringing acceleration to 0 when sin² ramp is interrupted</Description>
                      </Parameter>
                      <Parameter ParameterId="1200" type="std:LREAL">
                        <Attributes />
                        <Value>1000.0</Value>
                        <Name>fSWLimitPositive</Name>
                        <Description>software limit position in positive direction</Description>
                      </Parameter>
                      <Parameter ParameterId="1201" type="std:LREAL">
                        <Attributes />
                        <Value>0.0</Value>
                        <Name>fSWLimitNegative</Name>
                        <Description>software limit position in negative direction</Description>
                      </Parameter>
                      <Parameter ParameterId="1203" type="std:LREAL">
                        <Attributes />
                        <Value>0</Value>
                        <Name>fSWLimitDeceleration</Name>
                        <Description>deceleration value used to stop when a software error has been detected</Description>
                      </Parameter>
                      <Parameter ParameterId="1205" type="std:BOOL">
                        <Attributes />
                        <Value>FALSE</Value>
                        <Name>bSWLimitEnable</Name>
                        <Description>activate/deactivate software limit</Description>
                      </Parameter>
                      <Parameter ParameterId="1250" type="std:LREAL">
                        <Attributes />
                        <Value>0</Value>
                        <Name>fSWErrorMaxDistance</Name>
                        <Description>maximum distance that may be travelled for ramping down after a software error has been detected</Description>
                      </Parameter>
                    </ParameterSection>
                  </HostParameterSet>
                </Connector>
                <Connector moduleType="1248" interface="Common.SoftMotion.Logical" connectorId="1" hostpath="0">
                  <HostParameterSet />
                </Connector>
                <DeviceParameterSet />
              </DeviceType>
            </Device>
          </data>
          <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
            <ObjectId>33636be4-c0c0-4a83-bbe0-4b4dfbd6c3f4</ObjectId>
          </data>
        </addData>
      </configuration>
    </configurations>
  </instances>
  <addData>
    <data name="http://www.3s-software.com/plcopenxml/projectstructure" handleUnknown="discard">
      <ProjectStructure>
        <Object Name="MyMotor" ObjectId="33636be4-c0c0-4a83-bbe0-4b4dfbd6c3f4" />
      </ProjectStructure>
    </data>
  </addData>
</project>
	</#if>
</#list>