# Setup NodeJS Project Structure.
### _These are the scripts to setup a nodejs project with structure and packages._

To setup a project use any one script depending on platform you are on or use python file.
linux/mac : use .sh file.
windows use : .bat file

#### (Executable file will be available in next update for windows so we can setup whole nodejs project in two clicks)

### Setps : 

- Place the file in folder where you want to create a project
- Run command (using python here)
``` python 
    ./setup.py myNodeJsProject --api-express-mongo 
``` 
done!

### Options currently supported : 

Dillinger uses a number of open source projects to work properly:

>   --api-express-mongo - create api server with Express and MongoDB

> --api-express-mysql - server with MySQL

> --api-express-postgre - server with PostgreSQL.

> --api-express - server without DB


