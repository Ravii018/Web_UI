@echo off

set target_package1=robotframework
set target_package2=robotframework-ride
set target_package3=robotframework-selenium2library
set target_package4=robotframework-seleniumlibrary

set robotframework=""
set robotframework-ride=""
set robotframework-selenium2library=""
set robotframework-seleniumlibrary=""

where python >nul 2>&1
if %errorlevel% equ 0 (
    echo ********************************
    echo # Checking Pre-dependencies...
    echo Python is already installed.
    where pip >nul 2>&1
    if %errorlevel% equ 0 (
        echo Pip is already installed.
        echo Pre-dependencies are OK
        echo.
        echo ********************************
        for /f "delims=" %%i in ('pip freeze') do (
        set "packages=!packages!%%i\n"
        )

        echo # Checking needed libraries and installing if required...

        

        if not "!packages!"=="!packages:%target_package1%=!" (
            echo %target_package1% is installed
            set robotframework="1"
        ) else (
            echo Installing %target_package1%...
            for /f "delims=" %%i in ('pip --proxy http://87.254.212.120:8080 --retries 1 install robotframework') do (
                set "packages1=!packages1!%%i\n"
            )
            set target_packageq=Retrying
            if not "!packages1!"=="!packages1:%target_packageq%=!" (
                echo VPN is not enabled. Installing %target_package1% without proxy..
                for /f "delims=" %%i in ('pip install robotframework') do (
                set "packages1=!packages1!%%i\n"
                )     
            ) 
            set target_packageqq=Successfully
            if not "!packages1!"=="!packages1:%target_packageqq%=!" (
                set robotframework="1"
            ) else (
                set robotframework="0"
            )
            echo ----------
        )



        if not "!packages!"=="!packages:%target_package2%=!" (
            echo %target_package2% is installed
            set robotframework-ride="1"
        ) else (
            echo Installing %target_package2%...
            for /f "delims=" %%i in ('pip --proxy http://87.254.212.120:8080 --retries 1 install robotframework-ride') do (
                set "packages1=!packages1!%%i\n"
            )
            set target_packageq=Retrying
            if not "!packages1!"=="!packages1:%target_packageq%=!" (
                echo VPN is not enabled. Installing %target_package2% without proxy..  
                for /f "delims=" %%i in ('pip install robotframework-ride') do (
                set "packages1=!packages1!%%i\n"
                )  
            )  
            set target_packageqq=Successfully
            if not "!packages1!"=="!packages1:%target_packageqq%=!" (
                set robotframework-ride="1"
            ) else (
                set robotframework-ride="0"
            )
            echo ----------
        )



        if not "!packages!"=="!packages:%target_package3%=!" (
            echo %target_package3% is installed
            set robotframework-selenium2library="1"

        ) else (
            echo Installing %target_package3%...
            for /f "delims=" %%i in ('pip --proxy http://87.254.212.120:8080 --retries 1 install robotframework-selenium2library') do (
                set "packages1=!packages1!%%i\n"
            )
            set target_packageq=Retrying
            if not "!packages1!"=="!packages1:%target_packageq%=!" (
                echo VPN is not enabled. Installing %target_package3% without proxy.. 
                for /f "delims=" %%i in ('pip install robotframework-selenium2library') do (
                set "packages1=!packages1!%%i\n"
                )    
            ) 
            set target_packageqq=Successfully
            if not "!packages1!"=="!packages1:%target_packageqq%=!" (
                set robotframework-selenium2library="1"
            ) else (
                set robotframework-selenium2library="0"
            )
            echo ----------
        )



        if not "!packages!"=="!packages:%target_package4%=!" (
            echo %target_package4% is installed
            set robotframework-seleniumlibrary="1"

        ) else (
            echo Installing %target_package4% with proxy...
            
            for /f "delims=" %%i in ('pip --proxy http://87.254.212.120:8080 --retries 1 install robotframework-seleniumlibrary') do (
                set "packages1=!packages1!%%i\n"
            )
            set target_packageq=Retrying
            if not "!packages1!"=="!packages1:%target_packageq%=!" (
                echo VPN is not enabled. Installing %target_package4% without proxy..
                for /f "delims=" %%i in ('pip install robotframework-seleniumlibrary') do (
                set "packages1=!packages1!%%i\n"
                )
            )    
            set target_packageqq=Successfully
            if not "!packages1!"=="!packages1:%target_packageqq%=!" (
                set robotframework-seleniumlibrary="1"
            ) else (
                set robotframework-seleniumlibrary="0"
            )
            echo ----------
        )
        if !robotframework!=="1" if !robotframework-ride!=="1" if !robotframework-selenium2library!=="1" if !robotframework-seleniumlibrary!=="1" (
            echo Python libraries are OK
        ) else (
            echo Python libraries are NOK
        )
                    

        
        echo.
        echo *********************************

        echo # Checking 'chromedriver' path is added to the PATH variable... 

        if exist "%CD%" (
			echo %CD%
            echo "chromedriver" folder found in current directory path.
            set "pathvar=%PATH%"
            if "!pathvar:%CD%!=" neq "!pathvar!" (
                echo "chromedriver" path is found in PATH variable.
                echo Environment variable is OK
                echo.
                echo *********************************
                echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                echo Please proceed with editing the credentials.json file and run the main.py
                echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                echo.
            ) else (
                echo "chromedriver" path NOT found in PATH variable. Adding it...
                for /f "delims=" %%i in ('setx /M PATH "%PATH%;%CD%"') do (
                    set "packagesqw=!packagesqw!%%i\n"
                )
                
                set target_packageqw=SUCCESS
                if not "!packagesqw!"=="!packagesqw:%target_packageqw%=!" (
                    echo "chromedriver" path is successfully added to PATH variable.
                    echo Environment variable is OK
                    echo.
                    echo *********************************
                    echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                    echo Please proceed with editing the credentials.json file and run the main.py
                    echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                    echo.
                ) else (
                    echo Not able to add "chromedriver" path to PATH variable.
                    echo Environment variable is NOK
                    echo.
                    echo *********************************
                    echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                    echo Add the "chromedriver" path to the PATH variable.
                    echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
                    echo.
                )
                
            )
        )
        
    ) else (
        echo Pip is not installed. Installing pip...
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python get-pip.py
        echo pip is installed.
        echo.
        echo *********************************
        echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        echo Kindly, exit and run the batch file again to install remaining libraries.
        echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        echo.
    )

) else (
    echo Python is not installed.
    echo.
    echo **********************
    echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    echo Please install python to proceed
    echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    echo.
)

goto end

pause
