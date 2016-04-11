@echo off
IF DEFINED ANT_HOME (call %ANT_HOME%/bin/ant -f %~dp0\build.xml) ELSE (ECHO "Please define ANT_HOME environment variable!")
pause