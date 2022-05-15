# Weather

Weather is an application to display the weather forcast for the following 5 days.

### Build and run

#### Android and iOS

Check that the device is running.

```
flutter devices
```

If none are shown, follow the device-specific instructions on the [Install](https://flutter.dev/docs/get-started/install) page for your OS.

Then navigate to the directory of the project you want to build (`WEATHER`).

Run the app:
```
flutter run
```

#### Web (Chrome)
Build and run on chrome:
```
flutter run -d chrome
```

## Unit testing with Mocks using Mockito

Some unit tests might depend on classes that retrieves the data from the live database. This could be inconvenient to test using these classes for few reasons such as speed and reliability. For more info (https://flutter.dev/docs/cookbook/testing/unit/mocking)

To generate mocks navigate to the flutter project subdirectory, and run:

```
flutter pub run build_runner build
```
You might require to delete conflicting outputs, preventing the mock files to be regenerated. In this case run the following command:
```
flutter pub run build_runner build --delete-conflicting-outputs
```
