@ECHO OFF
color 8F
set current=%cd%
set bliss_path=%cd%\bliss
pushd ..
set parent=%cd%
popd
:menu
set choice=""
cls
echo **********************************************
echo *      EMREAKZ BUILDING TOOL HTC 10          *
echo **********************************************
echo building tool V0.1
echo created by EmreAkz
echo untested
echo main menu
echo .
echo -------------------------------------------------
echo -------------------------------------------------
:choice
echo 0.		install git
echo 1.		set build environment
echo 2.		make local_manifest.xml
echo 3.		sync (update)
echo 4.		build (build rom.zip)
echo 5.		clean (clean output)
echo 6.		push (push rom.zip)
echo 7.		exit
echo -------------------------------------------------
set p/ choice="(choose your option)"

IF %choice%==0. (goto install)
IF %choice%==1. (goto set)
IF %choice%==2. (goto make)
IF %choice%==3. (goto sync)
IF %choice%==4. (goto build)
IF %choice%==5. (goto clean)
IF %choice%==6. (goto push)
IF %choice%==7. (goto end)
echo Oh that tickles! Put your glasses and select the apropriate option!
pause
goto menu

:install
goto python

:python
goto set


paths:



:set
md %USERPROFILE%\bin
curl https://raw.githubusercontent.com/esrlabs/git-repo/stable/repo >%USERPROFILE%/bin/repo
curl https://raw.githubusercontent.com/esrlabs/git-repo/stable/repo.cmd >%USERPROFILE%/bin/repo.cmd
mkdir ~/bin
curl https://raw.githubusercontent.com/esrlabs/git-repo/stable/repo > ~/bin/repo
curl https://raw.githubusercontent.com/esrlabs/git-repo/stable/repo.cmd > ~/bin/repo.cmd
goto paths


:sync
set menu_choice=""
echo ------------------------------------------------------------------------------
echo EmreAkz building tool
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------
echo 1     update to the latest nightly
echo ------------------------------------------------------------------------------
set /p update_choice="[Choose wisely Sparky] "
if "%update_choice%"=="1" ( "%bliss_path%" update "%current%" 
echo Update done Sparky, you have the latest nightly!
pause
goto createzip

:createzip
set /p update_zip_choice="Do you want to create flashable ROM zip(Y/N)? " 
if /I "%update_zip_choice%"=="N" goto menu
if /I "%update_zip_choice%"=="Y" goto build 
goto menu



:build

:clean

:pushmenu
set storagetype=""
echo ------------------------------------------------------------------------------
echo Select where you want the rom
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------
echo 1    Internal Storage
echo 2    External SD Card
echo 3    Return to main menu
echo ------------------------------------------------------------------------------
SET /p storagetype="[Pick One] " 
if %storagetype% == 1 (
set storagetype=sdcard
goto push)
if %storagetype% == 2 (
set storagetype=sdcard2
goto push)
if %storagetype% == 3 goto menu
goto pushmenu

:push
FOR /F "delims=|" %%I IN ('DIR "*.zip" /B /O:D') DO SET NewestFile=%%I
echo Waiting for device...
"%bliss_path%%\adb" wait-for-device
"%bliss_path%%\adb" devices
echo Pushing %NewestFile% to %storagetype%
"%bliss_path%%\adb" push -p %NewestFile% /%storagetype%/
pause
goto menu

:end 
exit

