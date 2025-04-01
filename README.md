# Flutter Contact App
A simple app to test if we can get the iOS contacts properly onto the app and list them out.

Literally just to test the import.

## Setup
1. Ensure Flutter is installed on your system.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Connect an Android device/emulator or Apple device (requires Mac with Xcode).
5. Run `flutter run` to start the app.

## Features
- Requests contact permission on startup
- Displays a list of all contacts with thumbnails
- Shows detailed contact information on tap (phone numbers, emails)
- Refresh button to reload contacts
- Cross-platform support (Android and iOS)

## Permissions
This app requires contact permission to work properly. 

### Android
The following permission is added to the AndroidManifest.xml:
```xml
<uses-permission android:name="android.permission.READ_CONTACTS" />
```

### iOS
The following permission is added to Info.plist:
```xml
<key>NSContactsUsageDescription</key>
<string>This app needs access to contacts to display your contact list.</string>
```

## Development Notes
- The app is configured for both Android and iOS platforms
- iOS testing requires a Mac with Xcode installed
- Android testing can be done on Windows with Android Studio and an emulator

## Dependencies
- flutter_contacts: ^1.1.7+1 - For accessing and managing contacts

## Getting Started with Flutter
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

