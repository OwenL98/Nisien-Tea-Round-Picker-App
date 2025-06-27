# Nisien Tea Round Picker App

This project is formulated of two parts, the mobile app (this repository) and the [BE Application](https://github.com/OwenL98/Nisien-Tea-Round-Picker)

The application has been developed for the use on android in order to focus on its development rather than compatability. This can be added at a later date.

## Getting Started

### Set Up

In order to run this on an emulated android device please follow this [documentation](https://docs.flutter.dev/get-started/install) from flutter. When asked `Choose your first type of app` select android and continue with the reccommended set up.

When setting up an android emulator, please select any android phone emulator.

There is no need to continue onto the next steps `Create Your First App` once the setup is complete and the command `flutter doctor` is happy you have all required components.

### Running The Application

Within the terminal inside the app enter the commands:

`flutter emulators`

The available emulators will then be visible in the terminal, copy the name of the emulator chosen in android studio.

`flutter emulators --launch <emulator id>`  
e.g `flutter emulators --launch Medium_Phone_API_35`  
This will load up the emulator, this can sometimes take a few moments

`flutter run`  
This should run the application on the emulator. If you get an option to select which device to run on, select the number associated to the android emulator.

This is now running and you can use the app.

NOTE: The [Back End Application](https://github.com/OwenL98/Nisien-Tea-Round-Picker) will need to be run simultaneously for the 'Pick Tea maker' button to call the API and return a person to make the tea.
