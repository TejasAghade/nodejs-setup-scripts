@echo off
setlocal

rem Default values
set project_name=
set selected_option=

rem Function to display usage
:usage
echo Usage: %0 project_name [--api-express-mongo | --api-express-mysql | --api-express-postgres | --api-express]
exit /b 1

rem Parse command-line arguments
if "%~1" == "" goto :usage

set project_name=%~1
shift

rem Check if folder name is provided
if "%project_name%" == "" (
    echo Error: Project name not provided
    goto :usage
)

echo setting up '%project_name%'...

mkdir "%project_name%"
cd /d "%project_name%"

rem setup node project
npm init -y
cls
echo generating files...

echo. > .env
mkdir config
mkdir src
mkdir src\models src\controllers src\routes src\helpers
echo. > src\index.js

echo { > package.json
echo     "name": "myproj", >> package.json
echo     "version": "1.0.0", >> package.json
echo     "description": "", >> package.json
echo     "main": "index.js", >> package.json
echo     "scripts": { >> package.json
echo         "test": "echo \"Error: no test specified\" && exit 1", >> package.json
echo         "start": "node src/index.js", >> package.json
echo         "dev": "nodemon src/index.js" >> package.json
echo     }, >> package.json
echo     "keywords": [], >> package.json
echo     "author": "", >> package.json
echo     "license": "ISC" >> package.json
echo } >> package.json

rem sample express server
echo. > src\index.js
echo    const express = require('express'); >> src\index.js
echo. >> src\index.js
echo    const app = express(); >> src\index.js
echo    const port = 3000; >> src\index.js
echo. >> src\index.js
echo    app.get("/", (req, res) => { >> src\index.js
echo        res.send("Hello, World!"); >> src\index.js
echo    }); >> src\index.js
echo. >> src\index.js
echo    app.listen(port, () => { >> src\index.js
echo        console.log(`Server running at http://localhost:${port}`); >> src\index.js
echo    }); >> src\index.js

echo Installing packages...
echo npm i -g nodemon
npm i -g nodemon

set api_packages=bcrypt jsonwebtoken body-parser cors nodemon

setlocal enabledelayedexpansion
set "api_cmd="
if "%~1" == "--api-express-mongo" set api_cmd=npm i express mongodb mongoose !api_packages!
if "%~1" == "--api-express-mysql" set api_cmd=npm i express mysql2 !api_packages!
if "%~1" == "--api-express-postgre" set api_cmd=npm i express pg !api_packages!
if "%~1" == "--api-express" set api_cmd=npm i express !api_packages!

if defined api_cmd (
    %api_cmd%
) else (
    echo Invalid option
    goto :usage
)

if %errorlevel% equ 0 (
    echo Project setup successful!.
    echo.
    echo # To run the project use command:
    echo cd %project_name% && npm run dev
    echo.
    echo     or
    echo.
    echo cd %project_name%
    echo npm run dev
    echo.
) else (
    echo Failed to set up '%project_name%'.
)

endlocal
