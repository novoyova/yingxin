# 營新 App

## Setup

###	Firebase Project

1. Install [Firebase CLI](https://firebase.google.com/docs/cli)

2. Configure

    ```bash
    flutterfire configure
    ```

3. Move `lib/firebase_options.dart` file to `lib/core/configs/` folder

### Android

1. Add in `android/local.properties` file

    ```bash
    flutter.minSdkVersion=23
    flutter.ndkVersion=27.0.12077973
    ```

2. Create `upload-keystore.jks` and put it in `android/app/` folder

    ```bash
    # macOS or Linux
    keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
            -keysize 2048 -validity 10000 -alias upload

    # Windows
    keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks `
            -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
            -alias upload
    ```

3. Create `android/key.properties`

    ```bash
    storePassword=<password>
    keyPassword=<password>
    keyAlias=upload
    storeFile=../app/upload-keystore.jks
    ```

## Usage

### Run

```bash
flutter run --debug --target=lib/main.dart
flutter run --profile --target=lib/main.dart
flutter run --release --target=lib/main.dart
```

### Build

```bash
# APK
flutter build apk --release --target=lib/main.dart

# AAB
flutter build appbundle --release --target=lib/main.dart

# IPA
flutter build ipa --release --target=lib/main.dart --export-method=ad-hoc
```

