# fidelity-app

Our tcc project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build Runner: Built Value Generator Command

flutter packages pub run build_runner build --delete-conflicting-outputs


## 1 - Installing Flutter

- git clone https://github.com/flutter/flutter.git -b stable
- From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
- Under User variables check if there is an entry called Path:
- If the entry exists, append the full path to flutter\bin using ; as a separator from existing values.
- If the entry doesn’t exist, create a new user variable named Path with the full path to flutter\bin as its value.
- You have to close and reopen any existing console windows for these changes to take effect.\n
- Then run the command 'flutter doctor' to check 

## 2 - Installing IDE (Android Studio or IntelliJ)

- Download and install Android Studio.
- Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, which are required by Flutter when developing for Android.
- Run flutter doctor to confirm that Flutter has located your installation of Android Studio. If Flutter cannot locate it, run flutter config --android-studio-dir <directory> to set the directory that Android Studio is installed to.
- Make sure that you have a version of Java 8 installed and that your JAVA_HOME environment variable is set to the JDK’s folder.
- Android Studio versions 2.2 and higher come with a JDK, so this should already be done.
- Open an elevated console window and run the following command to begin signing licenses 'flutter doctor --android-licenses'
 
