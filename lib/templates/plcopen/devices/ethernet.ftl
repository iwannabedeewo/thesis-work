<#list app.* as ap> 	
<#if ap?node_name?matches("ethernet", 'i')>
<#macro getAddress ip>
	<#assign addr = ip?split(".")>
	<#compress>
		[${addr[0]},${addr[1]},${addr[2]},${addr[3]}]
	</#compress>
</#macro>
<#assign address><@getVal ap.address.@value/></#assign>
<#assign mask><@getVal ap.mask.@value/></#assign>
<#assign gateway><@getVal ap.mask.@value/></#assign>
		<data name="configurations" handleUnknown="discard">
            <configurations>
              <configuration name="<@getVal ap.@name/>">
                <addData>
                  <data name="Device" handleUnknown="discard">
                    <Device xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="">
                      <DeviceType>
                        <DeviceIdentification>
                          <Type>110</Type>
                          <Id>0000 0002</Id>
                          <Version>3.5.8.20</Version>
                        </DeviceIdentification>
                        <Connector moduleType="110" role="child" interface="Common.PCI" connectorId="1">
                          <HostParameterSet />
                        </Connector>
                        <Connector moduleType="111" interface="Common.Ethernet" connectorId="2" hostpath="1">
                          <HostParameterSet>
                            <Parameter ParameterId="0" type="std:ARRAY[0..3] OF BYTE">
                              <Attributes />
                              <Value><@getAddress address/></Value>
                              <Name>IPAddress</Name>
                              <Description>Configure IP Address of the Controller on the EtherNet bus (IP).</Description>
                            </Parameter>
                            <Parameter ParameterId="1" type="std:ARRAY[0..3] OF BYTE">
                              <Attributes />
                              <Value><@getAddress mask/></Value>
                              <Name>SubnetMask</Name>
                              <Description>Configure IP Address of the Controller on the EtherNet bus (Mask).</Description>
                            </Parameter>
                            <Parameter ParameterId="2" type="std:ARRAY[0..3] OF BYTE">
                              <Attributes />
                              <Value><@getAddress gateway/></Value>
                              <Name>GatewayAddress</Name>
                              <Description>Configure IP Address of the Controller on the EtherNet bus (Gateway).</Description>
                            </Parameter>
                            <Parameter ParameterId="3" type="localTypes:TransferRateType">
                              <Attributes />
                              <Value>0</Value>
                              <Name>TransferRate</Name>
                              <Description>Configure Bus speed of the EtherNet.</Description>
                            </Parameter>
                            <Parameter ParameterId="4" type="localTypes:IPConfigModeType">
                              <Attributes />
                              <Value>1</Value>
                              <Name>IPConfigMode</Name>
                              <Description>Configure the method this device uses for obtaining an IP address.</Description>
                            </Parameter>
                            <Parameter ParameterId="5" type="std:STRING">
                              <Attributes />
                              <Value>'myDevice'</Value>
                              <Name>DeviceName</Name>
                              <Description>Configure the Network-/Device- Name, e.g. for DHCP addressing Use case.</Description>
                            </Parameter>
                            <Parameter ParameterId="6" type="std:BOOL">
                              <Attributes />
                              <Value>true</Value>
                              <Name>WebServer</Name>
                              <Description>Configure activation of WEB server</Description>
                            </Parameter>
                            <Parameter ParameterId="9" type="std:ARRAY[0..5] OF BYTE">
                              <Attributes offlineaccess="read" />
                              <Value>[16#00,16#00,16#00,16#00,16#00,16#00]</Value>
                              <Name>MACAddress</Name>
                              <Description>MAC Address</Description>
                            </Parameter>
                            <Parameter ParameterId="10" type="std:STRING">
                              <Attributes />
                              <Value>''</Value>
                              <Name>NetworkInterfaceName</Name>
                              <Description>Configure Name of Network Interface</Description>
                            </Parameter>
                            <Parameter ParameterId="11" type="localTypes:ProtocolEnumType">
                              <Attributes />
                              <Value>0</Value>
                              <Name>EtherNetProtocol</Name>
                              <Description>Configure EtherNet Protocol (Ethernet2 or 802.3 frames)</Description>
                            </Parameter>
                            <Parameter ParameterId="12" type="std:WSTRING">
                              <Attributes />
                              <Value>""</Value>
                              <Name>NetworkInterfaceName</Name>
                              <Description>Configure Name of Network Interface - Unicode</Description>
                            </Parameter>
                            <Parameter ParameterId="13" type="std:BOOL">
                              <Attributes />
                              <Value>FALSE</Value>
                              <Name>SaveCommunicationSettings</Name>
                              <Description>TRUE: IP, SubnetMask and GatewayAddress will be set to the configured values at the PLC's OS!</Description>
                            </Parameter>
                            <Parameter ParameterId="100" type="std:ARRAY[0..3] OF BYTE">
                              <Attributes offlineaccess="read" />
                              <Value>[192, 168, 0, 1]</Value>
                              <Name>IPAddress</Name>
                              <Description>Actual IP Address of the Controller on the EtherNet bus (IP).</Description>
                            </Parameter>
                            <Parameter ParameterId="101" type="std:ARRAY[0..3] OF BYTE">
                              <Attributes offlineaccess="read" />
                              <Value>[255, 255, 255, 0]</Value>
                              <Name>SubnetMask</Name>
                              <Description>Actual IP Address of the Controller on the EtherNet bus (Mask).</Description>
                            </Parameter>
                            <Parameter ParameterId="102" type="std:ARRAY[0..3] OF BYTE">
                              <Attributes offlineaccess="read" />
                              <Value>[0, 0, 0, 0]</Value>
                              <Name>GatewayAddress</Name>
                              <Description>Actual IP Address of the Controller on the EtherNet bus (Gateway).</Description>
                            </Parameter>
                            <Parameter ParameterId="103" type="localTypes:TransferRateType">
                              <Attributes offlineaccess="read" />
                              <Value>0</Value>
                              <Name>TransferRate</Name>
                              <Description>Actual Bus speed of the EtherNet.</Description>
                            </Parameter>
                            <Parameter ParameterId="104" type="localTypes:IPConfigModeType">
                              <Attributes offlineaccess="read" />
                              <Value>1</Value>
                              <Name>IPConfigMode</Name>
                              <Description>Actual method this device uses for obtaining an IP address.</Description>
                            </Parameter>
                            <Parameter ParameterId="105" type="std:STRING">
                              <Attributes offlineaccess="read" />
                              <Value>'my Device'</Value>
                              <Name>DeviceName</Name>
                              <Description>Actual Network-/Device- Name, e.g. for DHCP addressing Use case.</Description>
                            </Parameter>
                            <Parameter ParameterId="106" type="std:BOOL">
                              <Attributes offlineaccess="read" />
                              <Value>true</Value>
                              <Name>WebServer</Name>
                              <Description>Actual activation state of WEB server</Description>
                            </Parameter>
                            <Parameter ParameterId="107" type="localTypes:NetworkStatusType">
                              <Attributes offlineaccess="read" />
                              <Value>1</Value>
                              <Name>NetworkStatus</Name>
                              <Description>Actual network status.</Description>
                            </Parameter>
                            <Parameter ParameterId="108" type="localTypes:ModuleStatusType">
                              <Attributes offlineaccess="read" />
                              <Value>1</Value>
                              <Name>ModuleStatus</Name>
                              <Description>Actual module status.</Description>
                            </Parameter>
                            <Parameter ParameterId="109" type="std:ARRAY[0..5] OF BYTE">
                              <Attributes offlineaccess="read" />
                              <Value>[16#0, 16#0, 16#0, 16#0, 16#0, 16#0]</Value>
                              <Name>MACAddress</Name>
                              <Description>Actual MAC Address.</Description>
                            </Parameter>
                            <Parameter ParameterId="110" type="std:STRING">
                              <Attributes offlineaccess="read" />
                              <Value>'ether 0'</Value>
                              <Name>NetworkInterfaceName</Name>
                              <Description>Actual Name of Network Interface</Description>
                            </Parameter>
                            <Parameter ParameterId="111" type="localTypes:ProtocolEnumType">
                              <Attributes offlineaccess="read" />
                              <Value>0</Value>
                              <Name>EtherNetProtocol</Name>
                              <Description>Actual configured EtherNet Protocol</Description>
                            </Parameter>
                            <Parameter ParameterId="10000000" type="std:BOOL">
                              <Attributes offlineaccess="none" />
                              <Value>false</Value>
                              <Name>WebserverVisible</Name>
                              <Description>enable/disable configuration of parameter WebServer</Description>
                            </Parameter>
                            <Parameter ParameterId="10000001" type="std:BOOL">
                              <Attributes offlineaccess="none" />
                              <Value>true</Value>
                              <Name>NetworkInterfaceVisible</Name>
                              <Description>enable/disable configuration of parameter NetworkInterfaceName</Description>
                            </Parameter>
                            <Parameter ParameterId="10000002" type="std:BOOL">
                              <Attributes download="false" offlineaccess="none" />
                              <Value>false</Value>
                              <Name>OnlineStatusScreenEnabled</Name>
                              <Description>enable/disable Online-Status Screen</Description>
                            </Parameter>
                            <Parameter ParameterId="10000003" type="std:WSTRING">
                              <Attributes download="false" offlineaccess="read" />
                              <Value>""</Value>
                              <Name>ReadOnlyNIC</Name>
                              <Description>NIC whose communication settings shall not be changed.</Description>
                            </Parameter>
                            <Parameter ParameterId="10000004" type="std:BOOL">
                              <Attributes offlineaccess="none" />
                              <Value>true</Value>
                              <Name>UseAsyncTask</Name>
                              <Description>Use async task to check the network connectivity. This relieves the bus cycle task.</Description>
                            </Parameter>
                            <Parameter ParameterId="20000000" type="std:__XWORD">
                              <Attributes offlineaccess="none" />
                              <Value>0</Value>
                              <Name>Dummy Parameter</Name>
                              <Description>Dummy Parameter</Description>
                            </Parameter>
                          </HostParameterSet>
                        </Connector>
                        <DeviceParameterSet />
                      </DeviceType>
                    </Device>
                  </data>
                  <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
                    <ObjectId>2fe4c2e4-b438-4114-b05a-fb5e6b996cde</ObjectId>
                  </data>
                </addData>
              </configuration>
            </configurations>
          </data>
	</#if>
</#list>