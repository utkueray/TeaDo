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

## iOS Project Requirements

<p align="center">
<img src="./start_main.gif" alt="Start GIF">
<img src="./create_note.gif" alt="Create Note GIF">
</p>

> __This project is written in Swift 5 and Xcode 13 is required for development.__

Before you begin, you should already have the Xcode downloaded and set up correctly. You can find a guide on how to do this here: [Setting up Xcode](https://developer.apple.com/xcode/)

## Setting up the iOS Project

1. Download the project from the repository. You can do this either by forking and cloning the repository (recommended if you plan on pushing changes) or by downloading it as a ZIP file and extracting it. OR
```
$ git clone https://github.com/utkueray/TeaDo.git
```

2. Open `TeaDo.xcodeproj` from the TeaDoApp folder.

3. Build the project (⌘+B) and check for any errors.

4. Run the app (⌘+R).

> __Since the backend runs on local network, app won't be able to run on a real device. Instead you should use simulator to run the app on the same device you are running the backend.__

> __iOS 15 has a bug where copying a text and pasting it may cause a crash.__

> __There isn't any local data storage on client app, whole data saving is done on the backend. Therefore, if you are writing a note and kill the app then note will not be saved. You should dismiss the note to trigger saving. Could have updated database whenever there is a valid user input, but it would be too many request sent.__
## License

This project is currently licensed under the Apache License Version 2.0. A copy of [LICENSE.md](https://github.com/utkueray/TeaDo/blob/main/LICENSE) should be present along with the source code.

