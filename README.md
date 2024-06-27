# Mobile App with Flutter for Buicorporation's take‐home test Software Engineer

#
I completed three tasks for BuiCorporation's Software Engineer technical test (backend, frontend, and mobile), each in a different Git repository. This is the repo for the Mobile App task with Flutter.

Others parts:
* [Backend with Nest Js](https://github.com/AzizProg/bui-api)
* [Frontend with Next Js](https://github.com/AzizProg/bui-client)
---
# Overview
https://github.com/AzizProg/bui-client/assets/112016586/10560de5-78a2-4232-a133-f992d09b9046

---
# Description

## What was requested
- Use Flutter
- Get list transactions and update transactions from the server.
- Dependancies :Get it,BLoc, Hive, Equatable, Auto route, Dio

## Tools used
- Flutter Framework
- Dart programming language

## What I accomplished
- Auth(Login, Sign up, logout)
- Dashboard page
- Details of transaction page
- Profile page
- Local storage
- Interceptors for Dio
- Route Guard
- Logging ( for debug or send logs on sentry if you want to go in production)
- Multiple langugages support ( English and French) : Localization
- State managaement
- Dependancies injection
- Error handler
---

# Project Structure
```
├───lib
    └───src
        ├───app
        │   ├───bloc
        │   └───view
        ├───features
        │   ├───auth
        │   │   ├───core
        │   │   │   ├───application
        │   │   │   │   └───usescases
        │   │   │   └───domain
        │   │   │       ├───entities
        │   │   │       └───ports
        │   │   ├───infrastructure
        │   │   │   ├───adapters
        │   │   │   ├───data_source
        │   │   │   └───mappers
        │   │   │       ├───requests
        │   │   │       └───responses
        │   │   └───interface
        │   │       ├───bloc
        │   │       ├───login
        │   │       │   ├───bloc
        │   │       │   └───view
        │   │       ├───sign_up
        │   │       │   ├───bloc
        │   │       │   └───view
        │   │       └───widgets
        │   ├───dashboard
        │   │   ├───core
        │   │   │   ├───application
        │   │   │   │   └───usecases
        │   │   │   └───domain
        │   │   │       ├───entities
        │   │   │       └───ports
        │   │   ├───infrastructure
        │   │   │   ├───adapters
        │   │   │   ├───data_source
        │   │   │   └───mappers
        │   │   └───interface
        │   │       ├───bloc
        │   │       ├───view
        │   │       └───widgets
        │   ├───details_transaction
        │   │   ├───core
        │   │   │   ├───application
        │   │   │   │   └───usecases
        │   │   │   └───domain
        │   │   │       └───ports
        │   │   ├───infrastructure
        │   │   │   ├───adapters
        │   │   │   ├───data_source
        │   │   │   └───mappers
        │   │   ├───interface
        │   │   │   ├───blocs
        │   │   │   └───views
        │   │   └───widgets
        │   └───profil
        │       ├───core
        │       │   ├───application
        │       │   │   └───usescases
        │       │   └───domain
        │       │       └───ports
        │       ├───infrastructure
        │       │   ├───adapters
        │       │   ├───data_source
        │       │   └───mappers
        │       └───interface
        │           ├───blocs
        │           ├───view
        │           └───widgets
        └───shared
            ├───constants
            ├───dio_interceptors
            ├───enums
            ├───errors
            ├───extension
            ├───l10n
            │   └───arb
            ├───network
            ├───observers
            ├───routes
            ├───storage
            └───widgets

```

# Installation
**NB**: For this projet, I use Flutter SDK version  3.22.0  and Dart version 3.4.0 .
If you don't update your flutter version or downgrade, you can use  [Flutter Version Management](https://https://fvm.app) 

### Step 1:
- Clone this repository.
- Open the project in an IDE.
- Flutter pub get in your IDE terminal to load all dependancies in pubspec.yml file and generate also multiple languages file(localization) in (.dart_tool/flutter_gen) folder.

### Step 2:
Make sure you have the backend part for this projet : [Backend with Nest Js](https://github.com/AzizProg/bui-api)


# Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/src/shared/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "appTitle": "Bui test mobile",
    "@appTitle": {
        "description": "Bui mobile app test"
    },
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "appTitle": "Bui test mobile",
    "@appTitle": {
        "description": "Bui mobile app test"
    },
   "loginAppBarText": "Login",
}
```

3. Use the new string

```dart

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.loginAppBarText);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>fr</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/src/shared/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_fr.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
  "@@locale": "en",
    "appTitle": "Bui test mobile",
    "@appTitle": {
        "description": "Bui mobile app test"
    },
}
```

`app_fr.arb`

```arb
{
   "@@locale": "fr",
    "appTitle": "Bui test mobile",
    "@appTitle": {
        "description": "Application mobile pour le test de Bui Corporation"
    },
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n
```
---

# Usage

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in your IDE or use the following commands:

```
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```
