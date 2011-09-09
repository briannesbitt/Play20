@echo off

set cwd=%~dp0
set args=%*

SET ansiconPath=%cwd%ansicon\x64\

Set RegQry=HKLM\Hardware\Description\System\CentralProcessor\0
 
REG.exe Query %RegQry% > checkOS.txt
 
Find /i "x86" < CheckOS.txt > StringCheck.txt
 
If %ERRORLEVEL% == 0 (
   SET AnsiConPath=%cwd%ansicon\x86\
)

echo %AnsiConPath%

del CheckOS.txt
del StringCheck.txt

if exist "conf/application.yml" (
	%cwd%framework\build.bat play %args% | %AnsiConPath%ansicon.exe -t
) else (
	"%JAVA_HOME%\bin\java" -cp %cwd%framework/sbt/boot/scala-2.9.0/lib/*;%cwd%framework/sbt/boot/scala-2.9.0/org.scala-tools.sbt/sbt/0.10.1/*;%cwd%repository/play/play_2.9.0/2.0/jars/* play.console.Console %args% | %AnsiConPath%ansicon.exe -t
)