@echo off
setlocal
call variables.cmd
call az group delete -n %RESOURCEGROUP%
endlocal