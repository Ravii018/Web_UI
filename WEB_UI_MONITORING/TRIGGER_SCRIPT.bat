@echo off

setlocal enableDelayedExpansion
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/ARD') do set ARD=%%i
echo %ARD%
set setting=1
if not "!ARD!"=="!ARD:%setting%=!" (
	echo ARD
	SET TESTCASE=-t ARD
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/PHC') do set PHC=%%i
echo %PHC%
if not "!PHC!"=="!PHC:%setting%=!" (
	echo PHC
	SET TESTCASE=%TESTCASE% -t PHC
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/SWM') do set SWM=%%i
echo %SWM%
if not "!SWM!"=="!SWM:%setting%=!" (
	echo SWM
	SET TESTCASE=%TESTCASE% -t SWM
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/SWAM') do set SWAM=%%i
echo %SWAM%
if not "!SWAM!"=="!SWAM:%setting%=!" (
	echo SWAM
	SET TESTCASE=%TESTCASE% -t SWAM
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/CNUM') do set CNUM=%%i
echo %CNUM%
if not "!CNUM!"=="!CNUM:%setting%=!" (
	echo CNUM
	SET TESTCASE=%TESTCASE% -t CNUM
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/FM') do set FM=%%i
echo %FM%
if not "!FM!"=="!FM:%setting%=!" (
	echo FM
	SET TESTCASE=%TESTCASE% -t FM
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/PM') do set PM=%%i
echo %PM%
if not "!PM!"=="!PM:%setting%=!" (
	echo PM
	SET TESTCASE=%TESTCASE% -t PM
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/NBI3GPPFM') do set NBI3GPPFM=%%i
echo %NBI3GPPFM%
if not "!NBI3GPPFM!"=="!NBI3GPPFM:%setting%=!" (
	echo 3GPPFMNBI
	SET TESTCASE=%TESTCASE% -t 3GPPFMNBI
)
for /f %%i in ('xidel credentials.json -e $json^(\"Components_to_Monitor_in_WebUI\"^)/SNMPNBI') do set SNMPNBI=%%i
echo %SNMPNBI%
if not "!SNMPNBI!"=="!SNMPNBI:%setting%=!" (
	echo SNMPNBI
	SET TESTCASE=%TESTCASE% -t SNMPNBI
)
robot -d Results %TESTCASE% WebUI.robot
robot --rerunfailed Results/output.xml -d Results --output rerun_output.xml --log rerun_log.html --report rerun_report.html WebUI.robot




