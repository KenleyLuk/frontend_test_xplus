# Frontend Test XPlus

Flutter app for cryptocurrency token swapping with responsive mobile/tablet support.

## Prerequisites

- Flutter SDK 3.7.2+
- iOS: Xcode, CocoaPods (`sudo gem install cocoapods`)
- Android: Android Studio / SDK, JDK 11+
- Web: Chrome browser (recommended)

## Setup

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **iOS - Install CocoaPods:**
   ```bash
   cd ios
   pod install
   cd ..
   ```

3. **Verify setup:**
   ```bash
   flutter doctor
   ```

## Running the Service

### iOS

**Using Simulator:**
```bash
# List available devices
flutter devices

# Run on iOS simulator
flutter run -d ios

# Or specify device
flutter run -d "iPhone 15 Pro"
```

**Using Physical Device:**
1. Connect iOS device via USB
2. Trust computer on device
3. Enable Developer Mode: Settings → Privacy & Security → Developer Mode
4. Run: `flutter run -d ios`

**Build for Release:**
```bash
flutter build ios --release
```

### Android

**Using Emulator:**
```bash
# List available devices
flutter devices

# Start emulator (via Android Studio or command line)
# Then run:
flutter run -d android

# Or specify device
flutter run -d "Pixel 7"
```

**Using Physical Device:**
1. Enable Developer Options: Settings → About Phone → Tap "Build Number" 7 times
2. Enable USB Debugging: Settings → Developer Options → USB Debugging
3. Connect device via USB
4. Accept USB debugging prompt
5. Run: `flutter run -d android`

**Build for Release:**
```bash
# APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

### Web

**Development:**
```bash
# Enable web support (if not already enabled)
flutter config --enable-web

# Run in Chrome
flutter run -d chrome

# Or other browsers
flutter run -d edge
flutter run -d safari  # macOS only
flutter run -d firefox
```

**Production Build:**
```bash
flutter build web --release

# Serve locally
cd build/web
python3 -m http.server 8000
# Open http://localhost:8000
```

## Dev Commands

```bash
flutter analyze              # Lint check
flutter test                # Run all tests
flutter test test/utils/currency_formatter.dart
flutter test test/utils/validators.dart
flutter clean               # Clean build
```

## Tech Stack

- Flutter 3.7.2
- BLoC (state management)
- Responsive design (breakpoint: 430px)