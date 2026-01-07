@echo off
REM Equivalent of the bash script for Windows Command Prompt

set IMAGE_NAME=jwgrenning/cpputest-runner
set HOST_WORKDIR=%CD%
set WORKDIR=/home

docker run ^
--rm ^
--name cpputest-runner ^
-v "%HOST_WORKDIR%:%WORKDIR%" ^
-w "%WORKDIR%" ^
-it %IMAGE_NAME%
