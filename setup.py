#!/usr/bin/env python3

import os
import sys
import platform

# Function to display usage
def usage():
    print("Usage: {} <project_name> [--api-express-mongo | --api-express-mysql | --api-express-postgres | --api-express]".format(sys.argv[0]))
    sys.exit(1)

# Parse command-line arguments
if len(sys.argv) < 2:
    usage()

project_name = sys.argv[1]
del sys.argv[1]

# Check if folder name is provided
if not project_name:
    print("Error: Project name not provided")
    usage()

print("setting up '{}'...".format(project_name))

os.mkdir(project_name)
os.chdir(project_name)

# setup node project
os.system("npm init -y")
os.system("clear")
print("generating files...")

open(".env", "w").close()
os.mkdir("config")
os.makedirs("src/models src/controllers src/routes src/helpers")
open("src/index.js", "w").write("""
const express = require('express');

const app = express();
const port = 3000;

app.get("/", (req, res) => {
    res.send("Hello, World!");
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
""")

with open("package.json", "w") as f:
    f.write("""
{
    "name": "myproj",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
        "test": "echo \\"Error: no test specified\\" && exit 1",
        "start": "node src/index.js",
        "dev": "nodemon src/index.js"
    },
    "keywords": [],
    "author": "",
    "license": "ISC"
}
""")

# sample express server
print("Installing packages...")

if platform.system() == "Windows":
    "Windows"
    os.system(" npm i -g nodemon")
else :
    os.system("sudo npm i -g nodemon")

api_packages = "bcrypt jsonwebtoken body-parser cors nodemon"

if "--api-express-mongo" in sys.argv:
    os.system("npm i express mongodb mongoose " + api_packages)
elif "--api-express-mysql" in sys.argv:
    os.system("npm i express mysql2 " + api_packages)
elif "--api-express-postgres" in sys.argv:
    os.system("npm i express pg " + api_packages)
elif "--api-express" in sys.argv:
    os.system("npm i express " + api_packages)

print("Project setup successful!.")
print("""
# To run the project use command >
$ cd {} && npm run dev

        or
        
$ cd {}
$ npm run dev
""".format(project_name, project_name))
