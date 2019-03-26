@echo off
setlocal rem EnableDelayedExpansion
cls
echo Cloud-BOINC-Client version 0.1 Alpha
echo.
if not exist variables.cmd (
echo Run configure.cmd at first
pause
goto:eof
)
call variables.cmd
echo Please wait a few minutes...
call az group create -l westus -n %RESOURCEGROUP% > resource-group-create-stdout.txt 2> resource-group-create-stderr.txt
if ERRORLEVEL 1 (
echo Group create exited with errors. See resource-group-create-stderr.txt
goto:eof
)
echo The resource group %RESOURCEGROUP% created successfully!
echo See resource-group-create-stdout.txt for more info.
call az vmss create --resource-group %RESOURCEGROUP% ^
--name %SCALESET% ^
--image UbuntuLTS ^
--upgrade-policy-mode automatic ^
--admin-username %SCALESETUSER% ^
--priority Low ^
--storage-sku Standard_LRS ^
--data-disk-caching 'None' ^
--vm-sku "Standard_D1_v2" ^
--eviction-policy Delete ^
--custom-data @cloud-init.sh ^
--instance-count 4 ^
--generate-ssh-keys > scaleset-create-stdout.txt 2> scaleset-create-stderr.txt
if ERRORLEVEL 1 (
echo The scale set create exited with errors. See scaleset-create-stderr.txt
goto:eof
)
echo The scale set %SCALESET% created successfully!
echo See scaleset-create-stdout.txt for more info.
pause
endlocal