
### install django on mac

```
pip install virtualenv
virtual env --version

# create project folder
cd Documents
virtualenv env_django -p python3

# activate virtual environment
source env_djnago/bin/activate

pip install django
python -m django --version
```

### start a django project
```
django-admin startproject mydjangosite
```

### verify that your django project works
```
cd mydjangosite
python manage.py runserver
```

### change the port 
default port is 8000; 
    if you want to change it, run
```
python manage.py runserver 8080
```

### create a new app
```
python manage.py startapp comics
```

### create admin user
```
# detects changes to be made
python manage.py makemigrations

# creates backend database and default tables
python manage.py migrate

python manage.py createsuperuser
angelinat
tenevaa21@gmail.com
ateneva2021

python manage.py runserver
```

### connect django to MySQL database
```
# install mysql client
brew install mysql
pip install mysqlclient

# update settings file in your django project
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'djangodatabase',
        'USER': 'dbadmin',
        'PASSWORD': '12345',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

# test connectivity
python manage.py dbshell

# update database
python manage.py migrate
```

### create django classes
```
python manage.py inspectdb > models.py

python manage.py makemigrations
python manage.py migrate --fake-initial
```

```
# sample class of exisiting DB 
class Example(models.Model):
  ...
    
  class Meta:
    managed = False # remove this line
    db_table = 'example_table_name'

# your database must have a primary key, otherwise django creates one automatically
```

### implement the django classes that were written to database
```
python manage.py makemigrations
python manage.py migrate
```

### print out the sql code that is going to run
```
python manage.py sqlmigrate comics 0001
```

# References
* https://docs.djangoproject.com/en/3.2/intro/tutorial01
* https://www.youtube.com/watch?v=UmljXZIypDc
* https://docs.djangoproject.com/en/3.2/topics/install/
* https://docs.djangoproject.com/en/3.2/intro/tutorial01/
* https://docs.djangoproject.com/en/3.2/intro/tutorial02/
* https://docs.djangoproject.com/en/3.2/intro/tutorial03/
* https://docs.djangoproject.com/en/3.2/intro/tutorial04/
* https://docs.djangoproject.com/en/3.2/intro/tutorial05/
* https://docs.djangoproject.com/en/3.2/intro/tutorial06/
* https://docs.djangoproject.com/en/3.2/intro/tutorial07/
* https://docs.djangoproject.com/en/3.2/ref/models/fields/
* https://www.youtube.com/playlist?list=PL-osiE80TeTtoQCKZ03TU5fNfx2UY6U4p
* https://www.youtube.com/watch?v=ZsJRXS_vrw0
* https://docs.djangoproject.com/en/3.1/ref/django-admin/
* https://medium.com/swlh/create-a-calculator-using-django-d2d5573dfe61

#### connect django to mysql database
* https://medium.com/@omaraamir19966/connect-django-with-mysql-database-f946d0f6f9e3
* https://www.youtube.com/watch?v=rI95wyHD_6k&list=PLCC34OHNcOtoYVT2654KIzait8_eYO_j5
* https://djangoadventures.com/how-to-integrate-django-with-existing-database/https://djangoadventures.com/how-to-integrate-django-with-existing-database/
* https://dev.to/idrisrampurawala/creating-django-models-of-an-existing-db-288m
* https://books.agiliq.com/projects/django-orm-cookbook/en/latest/existing_database.html
