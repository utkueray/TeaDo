<p align="center">
   <img src="https://github.com/utkueray/TeaDo/blob/main/teaDo_logo.png?raw=true" alt="TeaDo"/>
</p>

TeaDo is a note-taking/to-do app which runs on a backend and databse service that utilizes Django framework. Client application developed in Swift 5 with [Clean Swift Architecture](https://clean-swift.com) (a.k.a VIP) which is Uncle Bob's Clean Architecture, works with iOS 13.6+ and runs on both iPhone and iPad. App is localized for both English and Turkish, app language is selected automatically based on device's language preference.

## Backend Requirements
- Python 3.9+
- Django 4.0.2
- Django REST Framework 3.13.1
- CoreApi 2.3.3

## All in one installation
1. [Install Docker Compose](https://docs.docker.com/compose/install/)
2. Clone this repository
3. Run all containers with `docker-compose up`

## Alternative Installation
After you cloned the repository, you want to create a virtual environment, so you have a clean python installation.
You can do this by running the command
```
python -m venv env
```

After this, it is necessary to activate the virtual environment, you can get more information about this [here](https://docs.python.org/3/tutorial/venv.html)

You can install all the required dependencies by running
```
pip install -r requirements.txt
```

## API Docs
API docs can be found under following url after running the backend. Also you can checkout the API with the given [postman collection](https://github.com/utkueray/TeaDo/blob/main/TeaDo.postman_collection.json)

```
http://localhost:8000/docs/
```



## iOS App Requirements
- XCode 13
- Simulators (which comes with XCode)
- Open TeaDoApp/TeaDo.xcodeproj
- It may require to sign in with apple developer account under Project/TeaDo Target/Signing & Capabilities

## Since the backend runs on local network, app won't be able to run on a real device. Instead you should use simulator to run the app on the same device you are running the backend.
