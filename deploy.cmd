@if "%SCM_TRACE_LEVEL%" NEQ "4" @echo off

:: ----------------------
:: KUDU Deployment Script
:: Version: 0.1.13
:: ----------------------

IF "%SCM_TRACE_LEVEL%" EQU "4" (
  :: for debug
  set GIT_CURL_VERBOSE=1
  set MAKEFLAGS=--debug
  echo "%PATH%"
)


:: Prerequisites
:: -------------

:: Verify node.js installed
where node 2>nul >nul
IF %ERRORLEVEL% NEQ 0 (
  echo Missing node.js executable, please install node.js, if already installed make sure it can be reached from current environment.
  goto error
)

:: Setup
:: -----

setlocal enabledelayedexpansion

SET ARTIFACTS=%~dp0%..\artifacts

:: for Ruby
set RUBY_VERSION=1.9.3
set RUBY_HOME=%DEPLOYMENT_TARGET%\bin\ruby\%RUBY_VERSION%


IF NOT DEFINED DEPLOYMENT_SOURCE (
  SET DEPLOYMENT_SOURCE=%~dp0%.
)

IF NOT DEFINED DEPLOYMENT_TARGET (
  SET DEPLOYMENT_TARGET=%ARTIFACTS%\wwwroot
)

IF NOT DEFINED NEXT_MANIFEST_PATH (
  SET NEXT_MANIFEST_PATH=%ARTIFACTS%\manifest

  IF NOT DEFINED PREVIOUS_MANIFEST_PATH (
    SET PREVIOUS_MANIFEST_PATH=%ARTIFACTS%\manifest
  )
)

IF NOT DEFINED KUDU_SYNC_CMD (
  :: Install kudu sync
  echo Installing Kudu Sync
  call npm install kudusync -g --silent
  IF !ERRORLEVEL! NEQ 0 goto error

  :: Locally just running "kuduSync" would also work
  SET KUDU_SYNC_CMD=%appdata%\npm\kuduSync.cmd
)

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: Runtime setup
:-------------

IF NOT EXIST "%RUBY_HOME%" (
  :: Install ruby
  echo Installing ruby %RUBY_VERSION%
  curl -Os "https://raw.githubusercontent.com/shibayan/AzureWebSitesSetupScripts/master/ruby/%RUBY_VERSION%.bat"
  call %RUBY_VERSION%.bat
  IF !ERRORLEVEL! NEQ 0 goto error
)

set SSL_CERT_FILE=%RUBY_HOME%\cacert.pem

IF NOT EXIST "%SSL_CERT_FILE%" (
  :: download cacert file
  echo download cacert file
  curl -s "http://curl.haxx.se/ca/cacert.pem" > "%SSL_CERT_FILE%"

  IF !ERRORLEVEL! NEQ 0 goto error
)

IF NOT EXIST "%RUBY_HOME%\bin\bundle" (
  echo Installing bundler

  %RUBY_HOME%\bin\ruby.exe "%RUBY_HOME%\bin\gem" install bundler --no-ri --no-rdoc --quiet

  IF !ERRORLEVEL! NEQ 0 goto error
)


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Deployment
:: ----------

echo Handling Basic Web Site deployment.

:: 1. KuduSync
IF /I "%IN_PLACE_DEPLOYMENT%" NEQ "1" (
  call :ExecuteCmd "%KUDU_SYNC_CMD%" -v 50 -f "%DEPLOYMENT_SOURCE%" -t "%DEPLOYMENT_TARGET%" -n "%NEXT_MANIFEST_PATH%" -p "%PREVIOUS_MANIFEST_PATH%" -i ".git;.hg;.deployment;deploy.cmd"

  IF !ERRORLEVEL! NEQ 0 goto error
)


:: 2. Exec Bundler
IF EXIST "%DEPLOYMENT_TARGET%\Gemfile" (
  cd "%DEPLOYMENT_TARGET%"
  "%RUBY_HOME%\bin\ruby.exe" "%RUBY_HOME%\bin\bundle" install --verbose

  IF !ERRORLEVEL! NEQ 0 goto error
)


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Post deployment stub
IF DEFINED POST_DEPLOYMENT_ACTION call "%POST_DEPLOYMENT_ACTION%"
IF !ERRORLEVEL! NEQ 0 goto error

goto end

:: Execute command routine that will echo out when error
:ExecuteCmd
setlocal
set _CMD_=%*
call %_CMD_%
if "%ERRORLEVEL%" NEQ "0" echo Failed exitCode=%ERRORLEVEL%, command=%_CMD_%
exit /b %ERRORLEVEL%

:error
endlocal
echo An error has occurred during web site deployment.
call :exitSetErrorLevel
call :exitFromFunction 2>nul

:exitSetErrorLevel
exit /b 1

:exitFromFunction
()

:end
endlocal
echo Finished successfully.
