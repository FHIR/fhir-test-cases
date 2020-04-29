@echo off

set oldver=1.1.8
set newver=1.1.9

echo ..
echo ================================================================================
echo upgrade and release fhir-tests-cases from %oldver%-SNAPSHOT to %newver%-SNAPSHOT
echo ================================================================================
echo ..

call mvn versions:set -DnewVersion=%newver%-SNAPSHOT

call git commit -t v%newver% -a -m "Release new version %newver%"
call git tag v%newver%

call git push origin master
call "C:\tools\fnr.exe" -dir "C:\work\org.hl7.fhir\org.hl7.fhir.core" -fileMask "*.xml" -find "%oldver%-SNAPSHOT" -replace "%newver%-SNAPSHOT" -count 1
call "C:\tools\fnr.exe" -dir "C:\work\org.hl7.fhir\latest-ig-publisher" -fileMask "*.html" -find "%oldver%" -replace "%newver%" -count 1
call "C:\tools\fnr.exe" -dir "C:\work\org.hl7.fhir\latest-ig-publisher" -fileMask "*.json" -find "%oldver%" -replace "%newver%" -count 1
call mvn clean deploy -Dmaven.test.redirectTestOutputToFile=false -DdeployAtEnd=true 
IF %ERRORLEVEL% NEQ 0 ( 
  GOTO DONE
)

call "C:\tools\versionNotes.exe" -fileName C:\work\org.hl7.fhir\latest-ig-publisher\release-notes-test-cases.md -version %newver% -fileDest C:\temp\current-release-notes-test-cases.md -url https://storage.googleapis.com/ig-build/test-cases.zip

call "c:\program files\7-zip\7z" a ..\test-cases.zip cda npm r4 r5 ucum validator

gsutil cp -a public-read ..\test-cases.zip gs://ig-build/test-cases.zip

cd ..\latest-ig-publisher
call git commit -a -m "Release new version %newver%-SNAPSHOT. Changes: %comment%"
call git push origin master
cd ..\fhir-test-cases

call python c:\tools\zulip-api\zulip\zulip\send.py --stream committers/notification --subject "FHIR Test Cases" -m "New Test cases v%newver% released via Maven, also deployed at https://storage.googleapis.com/ig-build/test-cases.zip. See release notes at https://fhir.github.io/latest-ig-publisher/release-notes-test-cases.html" --config-file zuliprc
call python c:\tools\zulip-api\zulip\zulip\send.py --stream tooling/releases --subject "FHIR Test Cases" --config-file zuliprc < C:\temp\current-release-notes-test-cases.md 

del C:\temp\current-release-notes-test-cases.md

:DONE
echo ===============================================================
echo all done
echo ===============================================================
pause
 