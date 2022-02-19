
# install Python 
https://www.youtube.com/watch?v=8BiYGIDCvvA&t=192s

# Start up and exit python interpreter

### Mac OS
* Type `python3` in Terminal to start 
* Type `quit()` or `exit()` to exit


### Windows
* Type `python` in CMD to start
* Type `quit()` or `exit()` to exit

# Locate where python is installed on your machine

### Mac OS
```bash
import os 
import sys
os.path.dirname(sys.executable)
```

**OR** type `where python3`

### Windows
```bash
import os 
import sys
os.path.dirname(sys.executable)
```

**OR** type `where python`


# Create and activate virtual environment

### Windows
```bash
pip install virtualenv
virtualenv env --version

# navigate to project folder
cd Documents\GitHub\airflow

# create virtual environment
virtualenv venv_aiflow

# activate virtual environment
cd Documents\airflow\airflow\venv_airflow

```

### Mac
```bash
pip install virtualenv
virtualenv --version

# create project folder
cd Documents
virtualenv airflow_env -p python3

# activate virtual environment
source airflow_env/bin/activate
```

```bash
OR
python3 -m venv env
source env/bin/activate
```

# References
* https://docs.python-guide.org/dev/virtualenvs/
* https://programwithus.com/learn/python/pip-virtualenv-windows
* https://realpython.com/python-virtual-environments-a-primer/
* https://realpython.com/courses/working-python-virtual-environments/
