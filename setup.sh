#!/bin/bash

# Default values
project_name=""
selected_option=""

# Function to display usage
usage() {
    echo "Usage: $0 <project_name> [--api-express-mongo | --api-express-mysql | --api-express-postgres | --api-express]"
    exit 1
}

# Parse command-line arguments
if [ "$#" -lt 1 ]; then
    usage
fi

project_name="$1"
shift


# Check if folder name is provided
if [ -z "$project_name" ]; then
    echo "Error: Project name not provided"
    usage
fi


echo "setting up '$project_name'..."

mkdir "$project_name"
cd "$project_name"

# setup node project
npm init -y
clear
echo "generating files..."

touch .env
mkdir config
mkdir -p src/models src/controllers src/routes src/helpers
touch src/index.js


cat > package.json <<EOF 
{
    "name": "myproj",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1",
        "start": "node src/index.js",
        "dev": "nodemon src/index.js"
    },
    "keywords": [],
    "author": "",
    "license": "ISC"
}
EOF

# sample express server
cat > src/index.js <<EOF
    const express = require('express');

    const app = express();
    const port = 3000;

    app.get("/", (req, res) => {
        res.send("Hello, World!");
    });

    app.listen(port, () => {
        console.log(`Server running at http://localhost:${port}`);
    });
    
EOF

echo "Installing packages..."
echo "sudo npm i -g nodemon"
sudo npm i -g nodemon

api_packages="bcrypt jsonwebtoken body-parser cors nodemon"

case $1 in
    --api-express-mongo )
        npm i express mongodb mongoose $api_packages
        ;;
    --api-express-mysql )
        npm i express mysql2 $api_packages
        ;;
    --api-express-postgre )
        npm i express pg $api_packages
        ;;
    --api-express)
        npm i express $api_packages
        ;;
    * )
        project_name="$1"
        ;;
esac
shift

if [ $? -eq 0 ]; then
    echo "Project setup successfull!."
    echo "
    # To run the project use command >
    \$ cd $project_name && npm run dev

            or
            
    \$ cd $project_name
    \$ npm run dev
    "
else
    echo "Failed to setup '$project_name'."
fi
