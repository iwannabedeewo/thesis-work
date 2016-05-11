<#include "util.ftl">
<#assign aDateTime = .now>
<#assign eth = app.ethernet>
[PROJECT]
CREATED=BenceDevossa Template Export : ${aDateTime?string["dd MMMM yyyy hh:mm:ss"]} by <@getVal info.@companyName/>
TARGET=FECX
COMMENT=No comment
USE_MPRAM_IO=0
TIMESTAMP=1462090577l
[FEC_IO]
IO_0=FEC.IOD,0,0,0
[HC0X_IO]
IO_0=HC0X.IOD,0,0,0
[FECX_IO]
IO_0=208,1,8,1,8,-1,-1,""
PARAM_0=00
IDLE_0=0
FAIL_0=0
SYS_DATA=00 1f
TRACE_PARAMS=02 00 00 00 20 00 00 05
[FECX_DRV]
DRV_0=FECCPX
DRV_1=MODBUSTCP
DRV_2=TCPIPCPX
DRV_3=WEB_SRVR
[FECX_DRV_FECCPX]
SOLL=
[FECX_DRV_MODBUSTCP]
SOLL=
[FECX_DRV_TCPIPCPX]
IP=<@getAddress eth.address.@value/>
MASK=255.255.255.0
GATEWAY=0.0.0.0
[FECX_DRV_WEB_SRVR]
ROOTDIR=B:\WEB
[MODULES]
SRC_0=CZ0P00V1.awl,1,No comment
