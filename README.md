# Flutter Contact App
A simple app to test if we can get the iOS contacts properly onto the app and list them out.

Literally just to test the import.

## Setup
1. Ensure Flutter is installed on your system.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Connect an Android device or emulator.
5. Run `flutter run` to start the app.

## Features
- Requests contact permission on startup
- Displays a list of all contacts with thumbnails
- Shows detailed contact information on tap (phone numbers, emails)
- Refresh button to reload contacts

## Permissions
This app requires contact permission to work properly. 

### Android
The following permission is added to the AndroidManifest.xml:
```xml
<uses-permission android:name="android.permission.READ_CONTACTS" />
```

### iOS (Future Development)
For iOS, you would need to add the following to Info.plist:
```xml
<key>NSContactsUsageDescription</key>
<string>This app requires contacts access to display them in the app.</string>
```

## Dependencies
- flutter_contacts: ^1.1.7+1 - For accessing and managing contacts

## Getting Started with Flutter

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

