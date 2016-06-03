			<data name="http://www.3s-software.com/plcopenxml/pou" handleUnknown="implementation">
              <pou name="<@getVal pou.@name/>" pouType="program">
                <interface>
                  <localVars>
                    <variable name="state">
                      <type>
                        <INT />
                      </type>
                      <initialValue>
                        <simpleValue value="1" />
                      </initialValue>
                    </variable>
                    <variable name="Distance">
                      <type>
                        <LREAL />
                      </type>
                      <initialValue>
                        <simpleValue value="360" />
                      </initialValue>
                    </variable>
                    <variable name="PowerX">
                      <type>
                        <derived name="MC_Power" />
                      </type>
                    </variable>
                    <variable name="Xonb">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="HomeX">
                      <type>
                        <derived name="MC_Home" />
                      </type>
                    </variable>
                    <variable name="Referenced">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="ExtendX">
                      <type>
                        <derived name="MC_MoveRelative" />
                      </type>
                    </variable>
                    <variable name="Wait">
                      <type>
                        <derived name="TON" />
                      </type>
                    </variable>
                    <variable name="RetractX">
                      <type>
                        <derived name="MC_MoveAbsolute" />
                      </type>
                    </variable>
                    <variable name="Wait_time">
                      <type>
                        <TIME />
                      </type>
                      <initialValue>
                        <simpleValue value="TIME#3s0ms" />
                      </initialValue>
                    </variable>
                    <variable name="Elapsed_time">
                      <type>
                        <TIME />
                      </type>
                    </variable>
                    <variable name="ResetX">
                      <type>
                        <derived name="MC_Reset" />
                      </type>
                    </variable>
                    <variable name="ReadAxisState">
                      <type>
                        <derived name="MC_ReadStatus" />
                      </type>
                    </variable>
                    <variable name="Xerrorstop">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="XerrorID">
                      <type>
                        <DWORD />
                      </type>
                    </variable>
                    <variable name="Counter">
                      <type>
                        <INT />
                      </type>
                      <initialValue>
                        <simpleValue value="0" />
                      </initialValue>
                    </variable>
                  </localVars>
                  <localVars constant="true">
                    <variable name="ERROR">
                      <type>
                        <INT />
                      </type>
                      <initialValue>
                        <simpleValue value="99" />
                      </initialValue>
                    </variable>
                  </localVars>
                </interface>
                <body>
                  <ST>
                    <xhtml xmlns="http://www.w3.org/1999/xhtml">
CASE state OF
	
1:
PowerX(
	Axis:=<@getVal pou.@name/>_Motor , 
	Enable:=TRUE , 
	bRegulatorOn:=TRUE , 
	bDriveStart:=TRUE , 
	Status=&gt; , 
	bRegulatorRealState=&gt; , 
	bDriveStartRealState=&gt; , 
	Busy=&gt; , 
	Error=&gt; , 
	ErrorID=&gt; );
	
	IF PowerX.bDriveStartRealState THEN
		Xonb:=TRUE;
		state:=state+1;
		ELSE
			state:=ERROR;
	END_IF
	
2:
HomeX(
	Axis:=<@getVal pou.@name/>_Motor , 
	Execute:=TRUE, 
	Position:=0.0, 
	Done=&gt; , 
	Busy=&gt; , 
	CommandAborted=&gt; , 
	Error=&gt; , 
	ErrorID=&gt; );
		
	IF HomeX.Done THEN
		Referenced:=TRUE;
		state:=state+1;
		HomeX.Execute:=FALSE;
		ELSIF HomeX.Error OR Xerrorstop OR <@getVal pou.@name/>_Motor.bError THEN
		state:=ERROR;
	END_IF
	
3:
ExtendX.Execute:=TRUE; 
ExtendX.Distance:=Distance; 
ExtendX.Velocity:=100; 
ExtendX.Acceleration:=1000; 
ExtendX.Deceleration:=1000; 
ExtendX.Jerk:=0; 

	IF ExtendX.Done THEN
		state:=state+1;
		ExtendX.Execute:=FALSE;
		ELSIF ExtendX.Error OR Xerrorstop OR <@getVal pou.@name/>_Motor.bError THEN
		state:=ERROR;	
	END_IF
	
4:
Wait.IN:=TRUE;
Wait.PT:=Wait_time;
Elapsed_time:=Wait.ET;

	IF Wait.Q THEN
		state:=state+1;
		Wait.IN:=FALSE;
	END_IF

5: 
RetractX.Execute:=TRUE; 
RetractX.Position:=0; 
RetractX.Velocity:=100;
RetractX.Acceleration:=1000;
RetractX.Deceleration:=1000; 
RetractX.Jerk:=0; 

IF RetractX.Done THEN
		state:=state+1;
		RetractX.Execute:=FALSE;
		counter:=counter+1;
		ELSIF RetractX.Error OR Xerrorstop THEN
		state:=ERROR;
	END_IF
	
6: 
Wait.IN:=TRUE; 
Wait.PT:=Wait_time;
Elapsed_time:=Wait.ET;

	IF Wait.Q THEN
		state:=3;
		Wait.IN:=FALSE;
	END_IF
	
ERROR:
ResetX.Execute:=TRUE;
Wait.IN:=TRUE;
IF Wait.Q THEN
	ResetX.Execute:=FALSE;
	state:=1;
END_IF

END_CASE
ExtendX(Axis:=<@getVal pou.@name/>_Motor);
Wait();
RetractX(Axis:=<@getVal pou.@name/>_Motor);
ResetX(Axis:=<@getVal pou.@name/>_Motor);
ReadAxisState(Axis:=<@getVal pou.@name/>_Motor,Enable:=TRUE,ErrorStop=&gt;Xerrorstop);



</xhtml>
                  </ST>
                </body>
                <addData>
                  <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
                    <ObjectId>63d99c5f-3f6b-4b6e-9760-f7c21e568965</ObjectId>
                  </data>
                </addData>
              </pou>
            </data>
            
            
			<data name="http://www.3s-software.com/plcopenxml/pou" handleUnknown="implementation">
              <pou name="Motor_Proba" pouType="program">
                <interface>
                  <inputVars>
                    <variable name="START" address="%MX0.1">
                      <type>
                        <BOOL />
                      </type>
                      <initialValue>
                        <simpleValue value="FALSE" />
                      </initialValue>
                    </variable>
                    <variable name="STOP" address="%MX0.2">
                      <type>
                        <BOOL />
                      </type>
                      <initialValue>
                        <simpleValue value="FALSE" />
                      </initialValue>
                    </variable>
                  </inputVars>
                  <localVars>
                    <variable name="MOTOR" address="%MX1.0">
                      <type>
                        <BOOL />
                      </type>
                      <initialValue>
                        <simpleValue value="FALSE" />
                      </initialValue>
                    </variable>
                    <variable name="ERR_TIM">
                      <type>
                        <derived name="TON" />
                      </type>
                    </variable>
                    <variable name="EL_TIME">
                      <type>
                        <TIME />
                      </type>
                    </variable>
                    <variable name="ERROR" address="%MX2.0">
                      <type>
                        <BOOL />
                      </type>
                      <initialValue>
                        <simpleValue value="FALSE" />
                      </initialValue>
                    </variable>
                  </localVars>
                  <outputVars>
                    <variable name="ST_RED" address="%QX1.1">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="ST_GREEN" address="%QX3.1">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                  </outputVars>
                </interface>
                <body>
                  <LD>
                    <leftPowerRail localId="0">
                      <position x="0" y="0" />
                      <connectionPointOut formalParameter="none" />
                    </leftPowerRail>
                    <comment localId="1" height="0" width="0">
                      <position x="0" y="0" />
                      <content>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </content>
                    </comment>
                    <vendorElement localId="2">
                      <position x="0" y="0" />
                      <alternativeText>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </alternativeText>
                      <addData>
                        <data name="http://www.3s-software.com/plcopenxml/fbdelementtype" handleUnknown="implementation">
                          <ElementType xmlns="">networktitle</ElementType>
                        </data>
                      </addData>
                    </vendorElement>
                    <contact localId="3" negated="false" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="0" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>START</variable>
                    </contact>
                    <contact localId="4" negated="false" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="0" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>MOTOR</variable>
                    </contact>
                    <contact localId="5" negated="true" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="3" />
                        <connection refLocalId="4" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>STOP</variable>
                    </contact>
                    <contact localId="6" negated="true" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="5" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>ERROR</variable>
                    </contact>
                    <coil localId="7" negated="false" storage="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="6" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>MOTOR</variable>
                    </coil>
                    <comment localId="8" height="0" width="0">
                      <position x="0" y="0" />
                      <content>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </content>
                    </comment>
                    <vendorElement localId="9">
                      <position x="0" y="0" />
                      <alternativeText>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </alternativeText>
                      <addData>
                        <data name="http://www.3s-software.com/plcopenxml/fbdelementtype" handleUnknown="implementation">
                          <ElementType xmlns="">networktitle</ElementType>
                        </data>
                      </addData>
                    </vendorElement>
                    <contact localId="11" negated="false" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="0" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>START</variable>
                    </contact>
                    <inVariable localId="12">
                      <position x="0" y="0" />
                      <connectionPointOut />
                      <expression>T#5000ms</expression>
                    </inVariable>
                    <block localId="10" typeName="TON" instanceName="ERR_TIM">
                      <position x="0" y="0" />
                      <inputVariables>
                        <variable formalParameter="IN">
                          <connectionPointIn>
                            <connection refLocalId="11" />
                          </connectionPointIn>
                        </variable>
                        <variable formalParameter="PT">
                          <connectionPointIn>
                            <connection refLocalId="12" />
                          </connectionPointIn>
                        </variable>
                      </inputVariables>
                      <inOutVariables />
                      <outputVariables>
                        <variable formalParameter="Q">
                          <connectionPointOut />
                        </variable>
                        <variable formalParameter="ET">
                          <connectionPointOut>
                            <expression>EL_TIME</expression>
                          </connectionPointOut>
                        </variable>
                      </outputVariables>
                      <addData>
                        <data name="http://www.3s-software.com/plcopenxml/fbdcalltype" handleUnknown="implementation">
                          <CallType xmlns="">functionblock</CallType>
                        </data>
                      </addData>
                    </block>
                    <coil localId="13" negated="false" storage="reset">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="10" formalParameter="Q" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>ERROR</variable>
                    </coil>
                    <comment localId="14" height="0" width="0">
                      <position x="0" y="0" />
                      <content>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </content>
                    </comment>
                    <vendorElement localId="15">
                      <position x="0" y="0" />
                      <alternativeText>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </alternativeText>
                      <addData>
                        <data name="http://www.3s-software.com/plcopenxml/fbdelementtype" handleUnknown="implementation">
                          <ElementType xmlns="">networktitle</ElementType>
                        </data>
                      </addData>
                    </vendorElement>
                    <contact localId="16" negated="false" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="0" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>MOTOR</variable>
                    </contact>
                    <contact localId="17" negated="true" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="16" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>ERROR</variable>
                    </contact>
                    <coil localId="18" negated="false" storage="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="17" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>ST_GREEN</variable>
                    </coil>
                    <comment localId="19" height="0" width="0">
                      <position x="0" y="0" />
                      <content>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </content>
                    </comment>
                    <vendorElement localId="20">
                      <position x="0" y="0" />
                      <alternativeText>
                        <xhtml xmlns="http://www.w3.org/1999/xhtml" />
                      </alternativeText>
                      <addData>
                        <data name="http://www.3s-software.com/plcopenxml/fbdelementtype" handleUnknown="implementation">
                          <ElementType xmlns="">networktitle</ElementType>
                        </data>
                      </addData>
                    </vendorElement>
                    <contact localId="21" negated="false" storage="none" edge="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="0" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>ERROR</variable>
                    </contact>
                    <coil localId="22" negated="false" storage="none">
                      <position x="0" y="0" />
                      <connectionPointIn>
                        <connection refLocalId="21" />
                      </connectionPointIn>
                      <connectionPointOut />
                      <variable>ST_RED</variable>
                    </coil>
                    <rightPowerRail localId="2147483646">
                      <position x="0" y="0" />
                      <connectionPointIn />
                    </rightPowerRail>
                  </LD>
                </body>
                <addData>
                  <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
                    <ObjectId>646ea776-bfc8-4c08-a048-9814b0a42175</ObjectId>
                  </data>
                </addData>
              </pou>
            </data>
			<data name="http://www.3s-software.com/plcopenxml/libraries" handleUnknown="implementation">
              <Libraries>
                <Library Name="#IoStandard" Namespace="IoStandard" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="true" DefaultResolution="IoStandard, 3.5.8.0 (System)" />
                <Library Name="#SM3_Basic" Namespace="SM3_Basic" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="SM3_Basic, 3.5.8.0 (3S - Smart Software Solutions GmbH)" />
                <Library Name="#SM3_CNC" Namespace="SM3_CNC" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="SM3_CNC, 3.5.8.0 (3S - Smart Software Solutions GmbH)">
                  <Parameters>
                    <Parameter Name="GC_SMC_READNCFILE_BUFFERSIZE" Value="200" />
                  </Parameters>
                </Library>
                <Library Name="#3SLicense" Namespace="_3S_LICENSE" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="3SLicense, 0.0.0.0 (3S - Smart Software Solutions GmbH)" ResolverGuid="97c3b452-d9fa-4ac2-9d0c-3d420aa6d95b" />
                <Library Name="#BreakpointLogging" Namespace="BPLog" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="Breakpoint Logging Functions, 3.5.5.0 (3S - Smart Software Solutions GmbH)" />
                <Library Name="#Standard" Namespace="Standard" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="false" LinkAllContent="false" DefaultResolution="Standard, * (System)" />
                <Library Name="#Util" Namespace="Util" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="false" LinkAllContent="false" DefaultResolution="Util, * (System)">
                  <Parameters>
                    <Parameter Name="IBLOCKSIZE" Value="22800" />
                  </Parameters>
                </Library>
                <Library Name="#System_VisuElems" Namespace="VisuElems" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElems, 3.5.8.10 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemMeter" Namespace="VisuElemMeter" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemMeter, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemsSpecialControls" Namespace="VisuElemsSpecialControls" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemsSpecialControls, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemsWinControls" Namespace="VisuElemsWinControls" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemsWinControls, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemTextEditor" Namespace="VisuElemTextEditor" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemTextEditor, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemTrace" Namespace="VisuElemTrace" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemTrace, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuNativeControl" Namespace="VisuNativeControl" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuNativeControl, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemsAlarm" Namespace="VisuElemsAlarm" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemsAlarm, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemCamDisplayer" Namespace="VisuElemCamDisplayer" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemCamDisplayer, 3.5.7.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElem3DPath" Namespace="VisuElem3DPath" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElem3DPath, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#System_VisuElemsDateTime" Namespace="VisuElemsDateTime" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="VisuElemsDateTime, 3.5.8.0 (System)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <Library Name="#system_visuinputs" Namespace="visuinputs" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="visuinputs, 3.5.8.0 (system)" ResolverGuid="2717eb6a-dd07-4c66-8d8d-cacebd7b18ae" />
                <addData>
                  <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
                    <ObjectId>ef24055f-ec53-4a74-9f53-bc1f645ce41d</ObjectId>
                  </data>
                </addData>
              </Libraries>
            </data>