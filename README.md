# 營新 App

## Setup

### 1. Change Package Name

- Install [change_app_package_name](https://pub.dev/packages/change_app_package_name) and run:

    ```bash
    # Install as dev dependencies
    flutter pub add -d change_app_package_name

    # Change package name e.g. com.example.yingxin
    flutter pub run change_app_package_name:main <name>
    ```

- Then clean the project:

    ```bash
    flutter clean
    flutter pub get
    ```

### 2. Firebase Project

- Install [Firebase CLI](https://firebase.google.com/docs/cli)

- Configure

    ```bash
    flutterfire configure
    ```

- Move `lib/firebase_options.dart` file to `lib/core/configs/` folder

### 3. Android Config

- Add in `android/local.properties` file

    ```bash
    flutter.minSdkVersion=23
    flutter.ndkVersion=27.0.12077973
    ```

- Create `upload-keystore.jks` and put it in `android/app/` folder

    ```bash
    # macOS or Linux
    keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
            -keysize 2048 -validity 10000 -alias upload

    # Windows
    keytool -genkey -v -keystore $env:USERPROFILE\upload-keystore.jks `
            -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 `
            -alias upload
    ```

- Create `android/key.properties`

    ```bash
    storePassword=<password>
    keyPassword=<password>
    keyAlias=upload
    storeFile=../app/upload-keystore.jks
    ```

## Usage

### Run

```bash
flutter run --release --target=lib/main.dart
```

### Build

```bash
# APK
flutter build apk --release --target=lib/main.dart

# AAB
flutter build appbundle --release --target=lib/main.dart

# IPA
flutter build ipa --release --target=lib/main.dart
```

