# AppCargo (Flutter App)

Based on https://github.com/zubairehman/flutter-boilerplate-project

## Installing and Running (Linux with Android Studio)
Requirements: Flutter SDK, Android Studio.

Check this [Getting Started](https://flutter.dev/docs/get-started/install/linux) to install Flutter SDK and Android Studio.

### Alternative Flutter setup guide
1. Clone the flutter repo: `git clone https://github.com/flutter/flutter.git -b stable`
2. Add the binaries to your path: `echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.bashrc`
   - Change `$HOME` to the path to where you cloned the repo from
3. Reopen the terminal and check if everything’s ready with `flutter doctor`. 
What needs to be marked as without issues is at least “Flutter”, “Android toolchain” and “Android Studio”


### Environment configuration

1. After installing Flutter SDK and Android Studio, check if Android Studio is using the Flutter and Dart SDKs:
   - File -> Settings -> Language & Frameworks -> Flutter / Dart
   - Check Flutter/Dart SDK path, it should be something like:
     - Flutter SDK path: `/home/<user>/flutter`
     - Dark SDK path: `/home/<user>/flutter/bin/cache/dart-sdk`
2. Install Android Studio plugins: Flutter, Dart and Flutter Enhancement Suite (recommended). Restart if necessary.
3. Change your flutter version to `1.12.13+hotfix.5`: `flutter version v1.12.13+hotfix.5`
4. After switching your flutter version, running `flutter --version` should give something like this:
```bash
Flutter 1.12.13+hotfix.5 • channel unknown • unknown source
Framework • revision 27321ebbad (6 months ago) • 2019-12-10 18:15:01 -0800
Engine • revision 2994f7e1e6
Tools • Dart 2.7.0
```
5. Run `flutter doctor` again to see if everything is fine (you may have to [accept android licenses](https://stackoverflow.com/questions/48604914/flutter-run-error-you-have-not-accepted-the-license-agreements) again, among some other minor problems)

### Project configuration
6. Now that you have Android Studio and Flutter configured, open the project with Android Studio (File -> Open... -> select the `app/` folder)
7. Open the `pubspec.yaml` file and click on "packages get" and "packages upgrade" (*I don't know the order so just do it twice each*) to install the dependencies
8. Configure your target to build and run the project (device/emulator), if you haven't already. ([device guide](https://developer.android.com/studio/run/device) / [emulator guide](https://developer.android.com/studio/run/managing-avds#createavd))
9.  If you want to use your local backend instead of the production one, open the file `lib/constants/endpoints.dart` and change `baseUrl` to your local backend URL (something like: `http://192.168.1.4:8080`).

### Firebase Configuration
You can configure your app to use the testing Firebase project, instead of the production one (to test chat flow, notifications, etc):

10. Open the file `android/app/google-services.json` and change it locally to use the test project file:
<details>
    <summary>google-services.json file of appcargo-temporario Firebase project</summary>

```json
{
  "project_info": {
    "project_number": "470691865417",
    "firebase_url": "https://appcargo-temporario.firebaseio.com",
    "project_id": "appcargo-temporario",
    "storage_bucket": "appcargo-temporario.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:470691865417:android:da5e135bc39f8cae84f098",
        "android_client_info": {
          "package_name": "br.com.appcargo"
        }
      },
      "oauth_client": [
        {
          "client_id": "470691865417-oi8jg3016mp9o2tq2n8rkjp19rv5ke83.apps.googleusercontent.com",
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": "AIzaSyCz9fSBkCYipsyYLWxoTUmwlyIHkBWzmj0"
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": [
            {
              "client_id": "470691865417-oi8jg3016mp9o2tq2n8rkjp19rv5ke83.apps.googleusercontent.com",
              "client_type": 3
            }
          ]
        }
      }
    }
  ],
  "configuration_version": "1"
}
```
</details>

Obs: You may need to do `flutter clean` to clean cache so your project can be rebuilt with the correct configuration.

11. Open `lib/screens/chat/chat_screen.dart` and change the Firebase Storage URL used in getReferenceFromUrl method calls: `.getReferenceFromUrl("gs://appcargo-temporario.appspot.com");`

### Running

12. With your device connected or emulator running, click in the green play icon ("Run main.dart", <kbd>Shift</kbd>+<kbd>F10</kbd>)
    - PS: The first build takes a while (~1 min)

Obs: You can also use IntelliJ IDEA or Visual Studio Code by adding and setting up a few plugins.

## Deploying (Android)
### Before you build
- Check `lib/constants/endpoints.dart` to see if it's using the production URL (https://plataforma.appcargo.com.br) instead of your local backend URL
- It works in a real device

### Building for production

### Signing

### Play Store Console


-----

## Shortcuts

Building the launcher icon:
```bash
flutter packages pub run flutter_launcher_icons:main
```

Running build_runner:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```# appcargo_app
