# sample_app

Flutter प्रोजेक्ट.

## सुरुवात (Getting Started)

```bash
cd ~/Documents/FlutterProjects/my_app
open -a "Google Antigravity" .

flutter create --platforms=android,ios sample_app
```

---

## Package Name आणि Bundle ID बदलणे (rename package)

या प्रोजेक्टमध्ये **`rename`** package आधीच `dev_dependencies` मध्ये जोडलेले आहे. याचा वापर करून Android चा **package name** आणि iOS चा **bundle ID** सहज बदलता येतो.

### सध्याचे मूल्य (Current values)

| Platform | ID |
|----------|-----|
| Android  | `com.vijay.sampleapp` |
| iOS      | `com.vijay.sampleapp` |

### Package / Bundle ID बदलणे

प्रोजेक्टच्या root folder मध्ये terminal उघडा आणि खालील command चालवा:

```bash
flutter pub run rename setBundleId --targets android,ios --value "com.vijay.sampleapp"
```

**उदाहरण (या प्रोजेक्टसाठी):**

```bash
flutter pub run rename setBundleId --targets android,ios --value "com.vijay.sampleapp"
```

> Android आणि iOS दोन्हीसाठी `com.vijay.sampleapp` वापरले आहे. **iOS bundle ID मध्ये underscore (`_`) वापरू नका** — Firebase iOS app create fail होते.

### App Name (अॅपचे नाव) बदलणे

फक्त display name बदलायचे असेल तर:

```bash
flutter pub run rename setAppName --targets android,ios --value "माझे अॅप"
```

**उदाहरण:**

```bash
flutter pub run rename setAppName --targets android,ios --value "My App"
```

### सध्याचे ID पाहणे

```bash
# Bundle ID पाहणे
flutter pub run rename getBundleId --targets android,ios

# App Name पाहणे
flutter pub run rename getAppName --targets android,ios
```

### फक्त एक platform बदलणे

```bash
# फक्त Android
flutter pub run rename setBundleId --targets android --value "com.vijay.sampleapp"

# फक्त iOS
flutter pub run rename setBundleId --targets ios --value "com.vijay.sampleapp"
```

### Rename नंतर काय करावे

Package name / bundle ID बदलल्यानंतर clean build करा:

```bash
flutter clean
flutter pub get
flutter run
```

### महत्त्वाच्या गोष्टी

- **Android:** `applicationId`, `namespace`, `AndroidManifest.xml` आणि `MainActivity.kt` फाइल अपडेट होते.
- **iOS:** Xcode project मधील `PRODUCT_BUNDLE_IDENTIFIER` अपडेट होते.
- **Flavor setup** असेल तर `rename` package कदाचit काम करणार नाही — तेव्हा manual बदल करावे लागतील.
- Package name नेहमी **reverse domain format** मध्ये लिहा, उदा. `com.company.appname`.

### Package पुन्हा जोडायचे असेल तर

```bash
flutter pub add --dev rename
```

---

## Firebase प्रोजेक्ट जोडणे (Firebase Setup)

या प्रोजेक्टमध्ये Firebase जोडण्यासाठी खालील steps पाळा.

> **महत्त्वाचे:** Firebase setup करण्यापूर्वी package name / bundle ID **`com.vijay.sampleapp`** असल्याची खात्री करा. Firebase Console मध्ये हेच ID वापरावे.

### आवश्यक गोष्टी (Prerequisites)

- Google account
- [Firebase Console](https://console.firebase.google.com/) access
- Flutter SDK installed
- **Firebase CLI** installed (`firebase --version` काम करावे)
- **FlutterFire CLI** installed (`flutterfire configure` साठी)
- Android Studio / Xcode (iOS साठी Mac आवश्यक)
- Terminal access

---

### Step 0: Firebase CLI install करा (आवश्यक)

`flutterfire configure` चालवण्यापूर्वी **official Firebase CLI** install करणे **compulsory** आहे.

**Mac (Homebrew — recommended):**

```bash
brew install firebase-cli
firebase --version
```

**npm द्वारे (Node.js installed असेल तर):**

```bash
npm install -g firebase-tools
firebase --version
```

**Install verify:**

```bash
firebase --version
# Output: 15.x.x (version number)
```

**Google account login:**

```bash
firebase login
```

> **Error:** `The FlutterFire CLI currently requires the official Firebase CLI to also be installed`  
> **Solution:** वरील Step 0 पूर्ण करा, नंतर `flutterfire configure` पुन्हा run करा.

---

### Step 1: Firebase Console मध्ये प्रोजेक्ट तयार करा

1. [Firebase Console](https://console.firebase.google.com/) उघडा
2. **Add project** / **Create a project** वर click करा
3. Project name द्या (उदा. `sample-app`)
4. Google Analytics enable/disable करा (optional)
5. **Create project** click करा

---

### Step 2: Android App Firebase मध्ये जोडा

1. Firebase project dashboard मध्ये **Android** icon वर click करा
2. खालील details भरा:

| Field | Value |
|-------|-------|
| Android package name | `com.vijay.sampleapp` |
| App nickname | `sample_app` (optional) |
| Debug signing certificate SHA-1 | optional (Auth / Google Sign-In साठी आवश्यक) |

3. **Register app** click करा
4. `google-services.json` download करा
5. ती फाइल **`android/app/`** folder मध्ये ठेवा

**SHA-1 fingerprint काढणे (Auth / Google Sign-In साठी):**

```bash
cd android
./gradlew signingReport
```

Debug SHA-1 Firebase Console → Project Settings → Android app → Add fingerprint मध्ये add करा.

---

### Step 3: iOS App Firebase मध्ये जोडा

1. Firebase project dashboard मध्ये **iOS** icon वर click करा
2. खालील details भरा:

| Field | Value |
|-------|-------|
| iOS bundle ID | `com.vijay.sampleapp` |
| App nickname | `sample_app` (optional) |

3. **Register app** click करा
4. `GoogleService-Info.plist` download करा
5. Xcode मध्ये `ios/Runner.xcworkspace` उघडा
6. `GoogleService-Info.plist` फाइल **Runner** folder मध्ये drag & drop करा
7. **Copy items if needed** tick करा आणि **Runner** target select करा

> **टीप:** Push Notifications (FCM) साठी Apple Developer account आणि APNs key setup आवश्यक असते.

---

### Step 4: FlutterFire CLI install करा

FlutterFire CLI Firebase configuration automatic करते. Terminal मध्ये:

```bash
# FlutterFire CLI install
dart pub global activate flutterfire_cli

# PATH मध्ये global packages add करा (Mac/Linux) — हे Step 5 पूर्वी करा
export PATH="$PATH:$HOME/.pub-cache/bin"
```

**Mac वर permanent PATH साठी** `~/.zshrc` मध्ये add करा:

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

**`zsh: command not found: flutterfire` error येत असेल तर:**

हे error येतो कारण `$HOME/.pub-cache/bin` तुमच्या PATH मध्ये नाही. खालीलपैकी **एक** उपाय वापरा:

```bash
# उपाय 1: या session साठी PATH add करा (लगेच काम करेल)
export PATH="$PATH:$HOME/.pub-cache/bin"
flutterfire configure

# उपाय 2: PATH बदल न करता direct run करा
dart pub global run flutterfire_cli:flutterfire configure
```

---

### Step 5: Firebase configure करा (Recommended)

प्रोजेक्ट root folder मध्ये:

```bash
cd /Users/vijay/Desktop/AI/sample_app

# PATH set केले असेल तर:
flutterfire configure

# किंवा PATH नसेल तर:
dart pub global run flutterfire_cli:flutterfire configure
```

हे command:
- Firebase project select करण्यास सांगेल
- Android (`com.vijay.sampleapp`) आणि iOS (`com.vijay.sampleapp`) platforms configure करेल
- `lib/firebase_options.dart` फाइल generate करेल
- `google-services.json` आणि `GoogleService-Info.plist` automatic download/configure करेल

> **टीप:** `<create a new project>` फक्त नवीन project हवे असेल तेव्हाच निवडा. Project ID **global unique** असावा (उदा. `sample-app` already taken असू शकतो). Existing project वापरायचे असेल तर list मधून select करा.

**Specific project साठी:**

```bash
flutterfire configure --project=your-firebase-project-id
```

---

### Step 6: Firebase packages add करा

```bash
# Core package (required)
flutter pub add firebase_core

# जे service हवे असेल ते add करा:
flutter pub add firebase_auth          # Authentication
flutter pub add cloud_firestore        # Firestore Database
flutter pub add firebase_storage       # File Storage
flutter pub add firebase_messaging     # Push Notifications
flutter pub add firebase_analytics     # Analytics
```

---

### Step 7: `main.dart` मध्ये Firebase initialize करा

`lib/main.dart` file update करा:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

---

### Step 8: Build आणि Test करा

```bash
flutter clean
flutter pub get
flutter run
```

**Android:**

```bash
flutter run -d android
```

**iOS:**

```bash
cd ios && pod install && cd ..
flutter run -d ios
```

---

### Firebase Services Enable करणे

Firebase Console मध्ये जाऊन required services enable करा:

| Service | Firebase Console Path |
|---------|----------------------|
| Authentication | Build → Authentication → Get started |
| Firestore | Build → Firestore Database → Create database |
| Storage | Build → Storage → Get started |
| Cloud Messaging | Build → Cloud Messaging |
| Analytics | Automatically enabled |

---

### महत्त्वाच्या गोष्टी

- **`google-services.json`** → `android/app/` मध्ये ठेवा (git मध्ये commit करू शकता, secret नाही)
- **`GoogleService-Info.plist`** → `ios/Runner/` मध्ये ठेवा
- **`lib/firebase_options.dart`** → FlutterFire CLI generate करते, manual edit करू नका
- Package name / bundle ID बदलल्यास Firebase Console मध्ये नवीन app add करावी लागेल
- **Release build** साठी release SHA-1 fingerprint Firebase मध्ये add करा
- iOS push notifications साठी APNs certificate/key Apple Developer account मधून setup करा

---

### समस्या येत असेल तर (Troubleshooting)

```bash
# FlutterFire CLI reinstall
dart pub global deactivate flutterfire_cli
dart pub global activate flutterfire_cli

# iOS pods reset
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# Full clean build
flutter clean
flutter pub get
flutter run
```

**Common errors:**

| Error | Solution |
|-------|----------|
| `requires the official Firebase CLI` | `brew install firebase-cli` run करा, नंतर `firebase login` |
| `command not found: flutterfire` | `source ~/.zshrc` run करा किंवा `dart pub global run flutterfire_cli:flutterfire configure` |
| `already a project with ID` | `<create a new project>` नको — existing project select करा, किंवा unique ID वापरा (उदा. `vijay-sample-app`) |
| `Failed to create iOS app` / bundle ID error | iOS bundle ID मध्ये `_` (underscore) allowed नाही — `com.vijay.sampleapp` सारखे ID वापरा |
| `cannot load such file -- xcodeproj` | `gem install xcodeproj` run करा, नंतर `flutterfire configure` पुन्हा run करा |
| `No Firebase App '[DEFAULT]'` | `Firebase.initializeApp()` `main()` मध्ये add केले आहे का ते तपासा |
| Android build fail | `google-services.json` `android/app/` मध्ये आहे का ते तपासा |
| iOS build fail | `GoogleService-Info.plist` Runner target मध्ये add केले आहे का ते तपासा |
| SHA-1 error (Google Sign-In) | Debug/release SHA-1 Firebase Console मध्ये add करा |

---

## Push Notifications — Android + iOS (Enterprise Setup)

या प्रोजेक्टमध्ये **enterprise-level push notification** setup केले आहे. Android आणि iOS दोन्ही platforms वर notifications योग्यरित्या काम करतील.

### काय included आहे

| Feature | Package / File |
|---------|----------------|
| Remote Push (FCM) | `firebase_messaging` |
| Foreground Banner | `flutter_local_notifications` |
| Permission (Android 13+) | `permission_handler` |
| Background Handler | `background_message_handler.dart` |
| Main Service | `notification_service.dart` |

### Project Structure

```
lib/core/notifications/
├── notification_constants.dart      # Channel IDs, data keys
├── notification_service.dart        # Main singleton service
├── background_message_handler.dart  # FCM background entry point
└── models/app_notification.dart     # Normalized notification model
```

---

### Step 1: Packages (Already Added)

```bash
flutter pub add firebase_messaging flutter_local_notifications permission_handler
```

---

### Step 2: Android Setup (Already Configured)

**`android/app/src/main/AndroidManifest.xml` मध्ये:**
- `POST_NOTIFICATIONS` permission (Android 13+)
- FCM default channel: `high_importance_channel`
- Notification icon: `@drawable/ic_notification`

**App run केल्यावर:**
1. "Request Permission" button press करा
2. Allow notifications select करा

---

### Step 3: iOS Setup (Manual — Required)

iOS वर push notifications साठी **APNs key** setup **compulsory** आहे:

1. [Apple Developer](https://developer.apple.com/) → **Certificates, Identifiers & Profiles**
2. App ID (`com.vijay.sampleapp`) → **Push Notifications** enable करा
3. **Keys** → **APNs Auth Key** (.p8) create करा
4. [Firebase Console](https://console.firebase.google.com/) → **Project Settings** → **Cloud Messaging**
5. **Apple app configuration** → APNs Key upload करा (`.p8`, Key ID, Team ID)
6. Xcode → `ios/Runner.xcworkspace` उघडा
7. Runner target → **Signing & Capabilities**
8. **+ Capability** → **Push Notifications** add करा
9. **+ Capability** → **Background Modes** → **Remote notifications** tick करा

> **टीप:** iOS Simulator वर push limited आहे. Real iPhone वापरा.

---

### Step 4: App Run करा

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run
```

App open झाल्यावर home screen वर:
- **FCM Token** — Firebase test message साठी
- **Permission Status** — granted/denied
- **Last Notification** — latest received notification

---

### Step 5: Test Notification पाठवा

**Firebase Console द्वारे:**

1. [Firebase Console](https://console.firebase.google.com/) → project `vijay-sample-app`
2. **Messaging** → **Create campaign** → **Firebase Notification messages**
3. Notification title/body भरा
4. **Send test message** → app मधील FCM token paste करा
5. **Test** click करा

**3 states test करा:**

| App State | Expected Result |
|-----------|-----------------|
| Foreground (app open) | Local notification banner दिसेल |
| Background (app minimized) | System tray notification |
| Terminated (app closed) | System tray notification |

---

### Step 6: Code मध्ये वापरणे

**Topic subscribe:**

```dart
await NotificationService.instance.subscribeToTopic('announcements');
```

**Incoming notification listen:**

```dart
NotificationService.instance.onNotificationReceived.listen((notification) {
  print('Received: ${notification.title}');
});
```

**Notification tap / deep link:**

```dart
NotificationService.instance.onNotificationOpened.listen((notification) {
  final route = notification.route; // data payload मधील route
  // Navigator किंवा GoRouter ने navigate करा
});
```

**Token refresh:**

```dart
NotificationService.instance.onTokenRefresh.listen((token) {
  // Backend ला नवीन token send करा
});
```

---

### Data-only Message (Backend/API)

Notification + data payload example:

```json
{
  "message": {
    "token": "DEVICE_FCM_TOKEN",
    "notification": {
      "title": "Order Shipped",
      "body": "Your order #1234 is on the way"
    },
    "data": {
      "route": "/orders/1234",
      "type": "order_update",
      "id": "1234"
    },
    "android": {
      "priority": "HIGH",
      "notification": {
        "channel_id": "high_importance_channel"
      }
    },
    "apns": {
      "payload": {
        "aps": {
          "sound": "default",
          "badge": 1
        }
      }
    }
  }
}
```

---

### Notification Channels (Android)

| Channel ID | Purpose |
|------------|---------|
| `high_importance_channel` | Important alerts, account updates |
| `marketing_channel` | Promotions, offers |

Backend message मध्ये `"channel_id": "marketing_channel"` पाठवून channel select करता येतो.

---

### Common Issues

| Issue | Fix |
|-------|-----|
| iOS token `null` | Real device वापरा; APNs key Firebase मध्ये upload केले आहे का ते तपासा |
| iOS notification येत नाही | Xcode → Push Notifications capability add केले आहे का ते तपासा |
| Android 13+ notification नाही | App मध्ये "Request Permission" press करा |
| Foreground banner नाही | `NotificationService` auto local notification show करते — restart करा |
| `pod install` fail | `cd ios && pod install` पुन्हा run करा |

---

## अधिक माहिती

- [rename package — pub.dev](https://pub.dev/packages/rename)
- [FlutterFire documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Flutter documentation](https://docs.flutter.dev/)


                App Start
                     │
                     ▼
        NotificationService.initialize()
                     │
     ┌───────────────┼────────────────┐
     │               │                │
     ▼               ▼                ▼
Initialize      Create Channel     Register Listener
     │
     ▼
Request Permission
     │
     ▼
Firebase Token
     │
     ▼
Server मध्ये Save
     │
     ▼
Notification आली
     │
 ┌───┴───────────────┐
 │                   │
 ▼                   ▼
Foreground       Background
 │                   │
 ▼                   ▼
Local Notification  Firebase
 │                   │
 └──────┬────────────┘
        ▼
 User Notification वर Tap
        │
        ▼
Dispatch Notification
        │
        ▼
Navigate to Required Screen



