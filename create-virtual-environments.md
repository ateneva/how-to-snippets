
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

## Windows
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

## Mac

### create virtual environment using venv
```bash
python3 -m venv env
source env/bin/activate
```

### create virtual environment using virtualenv
```bash
pip install virtualenv
virtualenv --version

# create project folder
cd Documents
virtualenv airflow_env -p python3

# activate virtual environment
source airflow_env/bin/activate
```
* https://virtualenv.pypa.io/en/latest/installation.html
* https://virtualenv.pypa.io/en/latest/

# What if I don't have pip installed?
 * you can use `pipx` to  install `virtualenv`

```bash
# install pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx completions

# install virtualenv via pipx
pipx install virtualenv
virtualenv --help
```

  * You can install `pip` using
```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
```

 * OR you can install `pip` via `homebrew`
   * this is recommended as it is likely you'll need `pip` for other installations

```bash
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# use brew to install pip and virtualenv
brew install brew-pip
brew install virtualenv
```
* https://brew.sh/
* https://formulae.brew.sh/formula/brew-pip




# References
* https://docs.python-guide.org/dev/virtualenvs/
* https://programwithus.com/learn/python/pip-virtualenv-windows

* https://pypi.org/project/pipx/
* https://virtualenv.pypa.io/en/latest/installation.html
* https://virtualenv.pypa.io/en/latest/

* https://realpython.com/python-virtual-environments-a-primer/
* https://realpython.com/courses/working-python-virtual-environments/
