del *.tgz /s /q
del *.tar /s /q

cd test.format.old
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other
cd ..
copy test.format.old\package.tar package

"C:\Program Files\7-Zip\7z.exe" a -tgzip test.format.old.tgz package

del package. /s /q

cd test.format.new
"C:\Program Files\7-Zip\7z.exe" a -ttar package.tar package other
cd ..
copy test.format.new\package.tar package

"C:\Program Files\7-Zip\7z.exe" a -tgzip test.format.new.tgz package

del package. /s /q

pause