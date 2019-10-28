@echo off

set oldver=4.0.0
set newver=1.0.1

echo ..
echo ================================================================================
echo upgrade and release fhir-tests-cases from %oldver%-SNAPSHOT to %newver%-SNAPSHOT
echo ================================================================================
echo ..
echo check versions and make sure committed...
pause

call mvn versions:set -DnewVersion=%newver%-SNAPSHOT
call git commit -a -m "Release new version"
call git push origin master
call "C:\tools\fnr.exe" --cl --dir "C:\work\org.hl7.fhir\build" --fileMask "*.xml" --find "%oldver%-SNAPSHOT" --replace "%newver%-SNAPSHOT"
call "C:\tools\fnr.exe" --cl --dir "C:\work\org.hl7.fhir\fhir-ig-publisher" --fileMask "*.xml" --find "%oldver%-SNAPSHOT" --replace "%newver%-SNAPSHOT"
call "C:\tools\fnr.exe" --cl --dir "C:\work\org.hl7.fhir\latest-ig-publisher" --fileMask "*.html" --find "%oldver%" --replace "%newver%"
call "C:\tools\fnr.exe" --cl --dir "C:\work\org.hl7.fhir\latest-ig-publisher" --fileMask "*.json" --find "%oldver%" --replace "%newver%"
call mvn clean deploy -Dmaven.test.redirectTestOutputToFile=false -DdeployAtEnd=true 
IF %ERRORLEVEL% NEQ 0 ( 
  GOTO DONE
)

call python c:\tools\zulip-api\zulip\zulip\send.py --stream committers/notification --subject "FHIR Test Cases" -m "New Test cases v%newver% released" --config-file zuliprc

:DONE
echo ===============================================================
echo all done
echo ===============================================================
pause
 