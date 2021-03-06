<#include "macros.ftl">
<#assign wiring = document.wiring>
<?xml version="1.0" encoding="utf-8"?>
<project xmlns="http://www.plcopen.org/xml/tc6_0200">
  <fileHeader companyName="" productName="" productVersion="CODESYS V3.5 SP8 Patch 2" creationDateTime="1990-01-12T12:00:00" />
  <contentHeader name="Wiring" modificationDateTime="1990-01-12T12:12:12">
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
    <addData>
      <data name="http://www.3s-software.com/plcopenxml/projectinformation" handleUnknown="implementation">
        <ProjectInformation />
      </data>
    </addData>
  </contentHeader>
  <types>
    <dataTypes />
    <pous>
      <pou name="WIRING" pouType="program">
        <interface />
        <body>
          <ST>
          	<xhtml xmlns="http://www.w3.org/1999/xhtml">
<#list wiring.Condition as cond>
%<@getVal cond.@start/> := %<@getVal cond.@if/>;
 
</#list>
			</xhtml>
          </ST>
        </body>
        <addData>
          <data name="http://www.3s-software.com/plcopenxml/objectid" handleUnknown="discard">
            <ObjectId>97388cb7-b9e8-40a9-8cc9-83c0cd020a68</ObjectId>
          </data>
        </addData>
      </pou>
    </pous>
  </types>
  <instances>
    <configurations />
  </instances>
</project>