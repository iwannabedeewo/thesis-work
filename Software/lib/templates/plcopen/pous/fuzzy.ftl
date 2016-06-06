			<data name="http://www.3s-software.com/plcopenxml/pou" handleUnknown="implementation">
              <pou name="<@getVal pou.@name/>" pouType="functionBlock">
                <interface>
                  <inputVars>
                    <variable name="PV">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="SP">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MV_LN">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MV_MN">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MV_SN">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MV_SP">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MV_MP">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MV_LP">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="LN_Error_Rate">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MN_Error_Rate">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="MP_Error_Rate">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="LP_Error_Rate">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="Update_Time">
                      <type>
                        <WORD />
                      </type>
                    </variable>
                    <variable name="Manual">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="CV_Manual">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="CV_Min">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="CV_Max">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="Enable">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                  </inputVars>
                  <outputVars>
                    <variable name="FL_CV">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                  </outputVars>
                  <localVars>
                    <variable name="Loop_Update_ONS">
                      <type>
                        <derived name="R_TRIG" />
                      </type>
                    </variable>
                    <variable name="Loop_Update_Trigger">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="TMR_Loop_Update">
                      <type>
                        <derived name="TON" />
                      </type>
                    </variable>
                    <variable name="Loop_Update_Time">
                      <type>
                        <WORD />
                      </type>
                    </variable>
                    <variable name="Loop_Update_mSec">
                      <type>
                        <TIME />
                      </type>
                    </variable>
                    <variable name="Process_Error">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="NL_Error">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="NM_Error">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="NS_Error">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="PS_Error">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="PM_Error">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="PL_Error">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="Process_Error_Rate">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="Error_Rate_PV1">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="Error_Rate_PV2">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                    <variable name="NL_Error_Rate_Ind">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="NM_Error_Rate_Ind">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="NS_Error_Rate_Ind">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="PS_Error_Rate_Ind">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="PM_Error_Rate_Ind">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="PL_Error_Rate_Ind">
                      <type>
                        <BOOL />
                      </type>
                    </variable>
                    <variable name="Output_CV">
                      <type>
                        <REAL />
                      </type>
                    </variable>
                  </localVars>
                  <documentation>
                    <xhtml xmlns="http://www.w3.org/1999/xhtml"> @NESTEDCOMMENTS := 'Yes' 
 @PATH := '' 
 @SYMFILEFLAGS := '2048' </xhtml>
                  </documentation>
                </interface>
                <body>
                  <ST>
                    <xhtml xmlns="http://www.w3.org/1999/xhtml">
(* @END_DECLARATION := '0' *)
(***** Loop Update Logic *****)
(*  Get the Loop Update Time, ensure that lower limit of 1 is not exceeded and convert it into a time variable  *)
	IF Update_Time &lt; 1 THEN
		Loop_Update_Time := 1;
	ELSE
		Loop_Update_Time := Update_Time;
	END_IF;

	Loop_Update_mSec := WORD_TO_TIME(Loop_Update_Time);

	IF NOT TMR_Loop_Update.Q THEN
		Loop_Update_Trigger := TRUE;
	ELSE
		Loop_Update_Trigger := FALSE;
	END_IF;

	TMR_Loop_Update( IN := Loop_Update_Trigger, PT:= Loop_Update_mSec );
 	  Loop_Update_ONS( CLK := TMR_Loop_Update.Q);



(***** Calculate the Process Error and Process Error Rate *****)
	IF Loop_Update_ONS.Q THEN
	  (* Process Error Calculation *)
		Process_Error := SP - PV;

	  (* Process Error Rate Calculation *)
	 	Error_Rate_PV1 := Error_Rate_PV2;
		  Error_Rate_PV2 := PV;
		   Process_Error_Rate := (Error_Rate_PV2 - Error_Rate_PV1) / (Loop_Update_Time);
	END_IF;


(***** Membership Zone Logic *****)
(* Error Zone Identification Logic - This logic will indentify which Error Zone the Process Value is currently in *)
	(* Negative Large Membership Zone *)
		IF Process_Error &lt;= MV_LN THEN
			NL_Error := TRUE;
		ELSE
			NL_Error := FALSE;
		END_IF;

	(* Negative Medium Membership Zone *)
		IF Process_Error &gt; MV_LN AND Process_Error &lt;= MV_MN THEN
			NM_Error := TRUE;
		ELSE
			NM_Error := FALSE;
		END_IF;

	(* Negative Small Membership Zone *)
		IF Process_Error &gt; MV_MN AND Process_Error &lt;= MV_SN THEN
			NS_Error := TRUE;
		ELSE
			NS_Error := FALSE;
		END_IF;

	(* Positive Small Membership Zone *)
		IF Process_Error &lt; MV_MP AND Process_Error &gt;= MV_SP THEN
			PS_Error := TRUE;
		ELSE
			PS_Error := FALSE;
		END_IF;

	(* Positive Medium Membership Zone *)
		IF Process_Error &lt; MV_LP AND Process_Error &gt;= MV_MP THEN
			PM_Error := TRUE;
		ELSE
			PM_Error := FALSE;
		END_IF;

	(* Positive Large Membership Zone *)
		IF Process_Error &gt;= MV_LP THEN
			PL_Error := TRUE;
		ELSE
			PL_Error := FALSE;
		END_IF;

(* Error Rate Zone Identification Logic - This logic will indentify which Error Rate Zone the Process Value is currently in *)
	(* Negative Large Error Rate Membership Zone - The Error Rate is Decreasing Quickly *)
		IF Process_Error_Rate &lt;= LN_Error_Rate THEN
			NL_Error_Rate_Ind := TRUE;
		ELSE
			NL_Error_Rate_Ind := FALSE;
		END_IF;

	(* Negative Medium Error Rate Membership Zone - The Error Rate is Decreasing *)
		IF Process_Error_Rate &gt; LN_Error_Rate AND Process_Error_Rate &lt;= MN_Error_Rate THEN
			NM_Error_Rate_Ind := TRUE;
		ELSE
			NM_Error_Rate_Ind := FALSE;
		END_IF;

	(* Negative Small Error Rate Membership Zone  - The Error Rate is Decreasing slowly *)
		IF Process_Error_Rate &gt; MN_Error_Rate AND Process_Error_Rate &lt; 0.0 THEN
			NS_Error_Rate_Ind := TRUE;
		ELSE
			NS_Error_Rate_Ind := FALSE;
		END_IF;

	(* Positive Small Error Rate Membership Zone  - The Error Rate is Increasing slowly *)
		IF Process_Error_Rate &lt; MP_Error_Rate AND Process_Error_Rate &gt;= 0.0 THEN
			PS_Error_Rate_Ind := TRUE;
		ELSE
			PS_Error_Rate_Ind := FALSE;
		END_IF;

	(* Positive Meduim Error Rate Membership Zone  - The Error Rate is Increasing *)
		IF Process_Error_Rate &lt; LP_Error_Rate AND Process_Error_Rate &gt;= MP_Error_Rate THEN
			PM_Error_Rate_Ind := TRUE;
		ELSE
			PM_Error_Rate_Ind := FALSE;
		END_IF;

	(* Positive Large Error Rate Membership Zone  - The Error Rate is Increasing Quickly  *)
		IF Process_Error_Rate &gt;= LP_Error_Rate THEN
			PL_Error_Rate_Ind := TRUE;
		ELSE
			PL_Error_Rate_Ind := FALSE;
		END_IF;


(***** Fuzzy Logic Rules *****)
(* This section of logic contains all of the Fuzzy Logic rules required to produce the control action *)
	(* PV is Far Above SP and Increasing Quickly *)
		IF Loop_Update_ONS.Q AND NL_Error AND PL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 1000.0;
		END_IF;

	(* PV is Far Above SP and Increasing *)
		IF Loop_Update_ONS.Q AND NL_Error AND PM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 300.0;
		END_IF;

	(* PV is Far Above SP and Increasing slowly *)
		IF Loop_Update_ONS.Q AND NL_Error AND PS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 250.0;
		END_IF;

	(* PV is Far Above SP and Decreasing slowly *)
		IF Loop_Update_ONS.Q AND NL_Error AND NS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 300;
		END_IF;

	(* PV is Far Above SP and Decreasing *)
		IF Loop_Update_ONS.Q AND NL_Error AND NM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 250.0;
		END_IF;

	(* PV is Far Above SP and Decreasing Quickly *)
		IF Loop_Update_ONS.Q AND NL_Error AND NL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 100.0;
		END_IF;

	(* PV is Above SP and Increasing Quickly *)
		IF Loop_Update_ONS.Q AND NM_Error AND PL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 250.0;
		END_IF;

	(* PV is Above SP and Increasing *)
		IF Loop_Update_ONS.Q AND NM_Error AND PM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 100.0;
		END_IF;

	(* PV is Above SP and Increasing slowly *)
		IF Loop_Update_ONS.Q AND NM_Error AND PS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 50.0;
		END_IF;

	(* PV is Above SP and Decreasing Slowly *)
		IF Loop_Update_ONS.Q AND NM_Error AND NS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 250.0;
		END_IF;

	(* PV is Above SP and Decreasing *)
		IF Loop_Update_ONS.Q AND NM_Error AND NM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 100.0;
		END_IF;

	(* PV is Above SP and Decreasing Quickly *)
		IF Loop_Update_ONS.Q AND NM_Error AND NL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 50.0;
		END_IF;

	(* PV is Slightly Above SP and Increasing Quickly *)
		IF Loop_Update_ONS.Q AND NS_Error AND PL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 20.0;
		END_IF;

	(* PV is Slightly Above SP and Increasing *)
		IF Loop_Update_ONS.Q AND NS_Error AND PM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 10.0;
		END_IF;

	(* PV is Slightly Above SP and Increasing slowly*)
		IF Loop_Update_ONS.Q AND NS_Error AND PS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 5.0;
		END_IF;

	(* PV is Slightly Above SP and Decreasing slowly*)
		IF Loop_Update_ONS.Q AND NS_Error AND NS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 20.0;
		END_IF;

	(* PV is Slightly Above SP and Decreasing *)
		IF Loop_Update_ONS.Q AND NS_Error AND NM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 10.0;
		END_IF;

	(* PV is Slightly Above SP and Decreasing Quickly*)
		IF Loop_Update_ONS.Q AND NS_Error AND NL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV - 5.0;
		END_IF;

	(* PV is Slightly Below SP and Increasing Quickly *)
		IF Loop_Update_ONS.Q AND PS_Error AND PL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 5.0;
		END_IF;

	(* PV is Slightly Below SP and Increasing *)
		IF Loop_Update_ONS.Q AND PS_Error AND PM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 10.0;
		END_IF;

	(* PV is Slightly Below SP and Increasing Slowly *)
		IF Loop_Update_ONS.Q AND PS_Error AND PS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 20.0;
		END_IF;

	(* PV is Slightly Below SP and Decreasing Slowly *)
		IF Loop_Update_ONS.Q AND PS_Error AND NS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 20.0;
		END_IF;

	(* PV is Slightly Below SP and Decreasing *)
		IF Loop_Update_ONS.Q AND PS_Error AND NM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 10.0;
		END_IF;

	(* PV is Slightly Below SP and Decreasing Quickly *)
		IF Loop_Update_ONS.Q AND PS_Error AND NL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 5.0;
		END_IF;

	(* PV is Below SP and Increasing Quickly *)
		IF Loop_Update_ONS.Q AND PM_Error AND PL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 50.0;
		END_IF;

	(* PV is Below SP and Increasing *)
		IF Loop_Update_ONS.Q AND PM_Error AND PM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 20.0;
		END_IF;

	(* PV is Below SP and Increasing Slowly *)
		IF Loop_Update_ONS.Q AND PM_Error AND PS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 10.0;
		END_IF;

	(* PV is Below SP and Decreasing Slowly *)
		IF Loop_Update_ONS.Q AND PM_Error AND NS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 50.0;
		END_IF;

	(* PV is Below SP and Decreasing *)
		IF Loop_Update_ONS.Q AND PM_Error AND NM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 100.0;
		END_IF;

	(* PV is Below SP and Decreasing Quickly *)
		IF Loop_Update_ONS.Q AND PM_Error AND NL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 250.0;
		END_IF;

	(* PV is Far Below SP and Increasing Quickly *)
		IF Loop_Update_ONS.Q AND PL_Error AND PL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 100.0;
		END_IF;

	(* PV is Far Below SP and Increasing *)
		IF Loop_Update_ONS.Q AND PL_Error AND PM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 250.0;
		END_IF;

	(* PV is Far Below SP and Increasing Slowly *)
		IF Loop_Update_ONS.Q AND PL_Error AND PS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 300.0;
		END_IF;

	(* PV is Far Below SP and Decreasing Slowly *)
		IF Loop_Update_ONS.Q AND PL_Error AND NS_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 100.0;
		END_IF;

	(* PV is Far Below SP and Decreasing *)
		IF Loop_Update_ONS.Q AND PL_Error AND NM_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 250.0;
		END_IF;

	(* PV is Far Below SP and Decreasing Quickly *)
		IF Loop_Update_ONS.Q AND PL_Error AND NL_Error_Rate_Ind
		    AND Enable AND NOT Manual THEN
			Output_CV := Output_CV + 300.0;
		END_IF;

	(* Write Output_CV to the controller output variable, CV *)
		IF Enable AND NOT Manual THEN
			FL_CV := Output_CV;
		END_IF;


(***** Fuzzy Logic Controller Maximum and Minimum Limits Logic *****)
(* Minimum Limits Logic *)
	IF Output_CV &lt; CV_Min THEN
		Output_CV := CV_Min;
	END_IF;

(* Maximum Limits Logic *)
	IF Output_CV &gt; CV_Max THEN
		Output_CV := CV_Max;
	END_IF;

(***** Manual Fuzzy Logic Controller Operation *****)
(* This section of logic controls the manual operation of the fuzzy logic controller.  If the controller
    is enabled and the manual control is set to True, then the output of the controller, CV, will be
    equal to CV_Manual. *)
	IF Enable AND Manual AND (CV_Manual &gt; 0.0 AND CV_Manual &lt;= 32767) THEN
		FL_CV := CV_Manual;
	END_IF;

	IF Enable AND Manual AND (CV_Manual &lt; 0.0) THEN
		FL_CV := 0.0;
	END_IF;

	IF Enable AND Manual AND (CV_Manual &gt;32767.0) THEN
		FL_CV := 32767.0;
	END_IF;

(* Fuzzy Logic Controller Enable Logic *)
	IF NOT Enable THEN
		Output_CV := 0.0;
		  FL_CV := 0.0;
	END_IF;
</xhtml>
                  </ST>
                </body>
                <addData>
                  <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
                    <ObjectId>6fe0ffc8-272d-498d-b666-6a4d40636f25</ObjectId>
                  </data>
                </addData>
              </pou>
            </data>
			<data name="http://www.3s-software.com/plcopenxml/libraries" handleUnknown="implementation">
              <Libraries>
                <Library Name="#IoStandard" Namespace="IoStandard" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="true" DefaultResolution="IoStandard, 3.5.8.0 (System)" />
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
                <Library Name="SM3_Drive_PosControl, 3.5.7.0 (3S - Smart Software Solutions GmbH)" Namespace="SM3_Drive_PosControl" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" />
                <Library Name="#IoDrvEthernet" Namespace="IoDrvEthernet" HideWhenReferencedAsDependency="false" PublishSymbolsInContainer="false" SystemLibrary="true" LinkAllContent="false" DefaultResolution="IoDrvEthernet, 3.5.8.20 (3S - Smart Software Solutions GmbH)">
                  <Parameters>
                    <Parameter Name="TASK_PRIORITY" Value="15" />
                  </Parameters>
                </Library>
                <addData>
                  <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
                    <ObjectId>b092f952-2c80-495f-a5e7-ae2f4216764a</ObjectId>
                  </data>
                </addData>
              </Libraries>
            </data>