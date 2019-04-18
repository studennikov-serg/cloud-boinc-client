@echo off
setlocal
cls
echo Cloud-BOINC-Client version 0.1 Alpha
echo.
echo Welcome!
Echo A Microsoft Azure account is required
choice /m "Open a browser to create one? "
if ERRORLEVEL 2 goto skipreg
start "Registration" "https://azure.microsoft.com/en-us/free/"
:skipreg
choice /m "Open the login page? "
if ERRORLEVEL 2 goto skiplogin
az login
:skiplogin

set RESOURCEGROUP=BOINCResourceGroup
set /P RESOURCEGROUP="Enter the resource group name, leave blank for default [BOINCResourceGroup] "
echo @set RESOURCEGROUP=%resourcegroup%>variables.cmd

set SCALESET=BOINCScaleSet
set /P SCALESET="Enter the scale set name, leave blank for default [BOINCScaleSet] "
echo @set SCALESET=%SCALESET%>>variables.cmd

set SCALESETUSER=boincuser
echo Enter the scale set user name (only lower case characters)
set /P SCALESETUSER="Leave blank for default [boincuser] "
echo @set SCALESETUSER=%SCALESETUSER%>>variables.cmd

set PROJECTURL=http://www.worldcommunitygrid.org
echo Enter the BOINC project url, leave blank for default
set /P PROJECTURL="[http://www.worldcommunitygrid.org] "
echo @set PROJECTURL=%PROJECTURL%>>variables.cmd

:ackey
set /P ACCOUNTKEY="Enter the account key "
if not defined ACCOUNTKEY (
echo Account key can not be blank
goto ackey
)
echo @set ACCOUNTKEY=%ACCOUNTKEY%>>variables.cmd

copy /Y cloud-init-template.sh cloud-init.sh>nul
echo %PROJECTURL% %ACCOUNTKEY% #>>cloud-init.sh
endlocal