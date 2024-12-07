# hotel_booking_app
---------
# Flutter App README

## Introduction
This Flutter app demonstrates hotel bookings using the `custom_bloc` package for efficient state management of API calls and refresh mechanisms. It also employs an `InheritedWidget` at the root level to manage global state for theming and localization.

---

## Features
- Dynamic theme switching.
- Localization support for multiple languages.
- Efficient API state management using `custom_bloc`.
- Seamless refresh functionality.

---

## Setup

### Prerequisites
1. Install [Flutter](https://flutter.dev/docs/get-started/install).
2. Ensure you have a compatible IDE (e.g., Android Studio, Visual Studio Code).
3. Set up an emulator or connect a physical device.

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Get dependencies:
   ```bash
   flutter pub get
   ```

---

## Running the App
1. Start the emulator or connect a physical device.
2. Run the app:
   ```bash
   flutter run
   ```

---

## Build the App
1. Start the emulator or connect a physical device.
2. Run the app on android
   ```bash
   flutter build apk --release
   ```
3. Run the app on ios
   ```bash
   flutter build ios
   ```

---

## Testing
Run the following command to execute unit and widget tests:
```bash
flutter test
```

---

## Architecture
### Navigation Key for Global Context Access

The app uses a GlobalKey<NavigatorState> to facilitate global context access, enabling operations such as showing dialogs or navigating between routes from non-widget contexts.


### Custom Bloc Package for API Calls
The `custom_bloc` package is used to manage the app's state effectively during API interactions. The `custom_bloc` handles the following:
- **Loading State**: Displays loading indicators during data fetching.
- **Error State**: Handles errors gracefully with retry mechanisms.
- **Success State**: Updates the UI with API response data.

**Usage:**
1. Define a `Bloc` for each feature requiring API calls.
2. Use `CustomStreamBuilder` or `CustomStreamBuilder.multi` to react to state changes in the UI.
3. Refresh mechanisms are implemented using `reload` function tied to the `Bloc` logic.

### Inherited Widget for Global State
The app's global state, including theme and language settings, is managed by an `InheritedWidget` at the root of the app. This provides a lightweight mechanism for sharing state across the widget tree without redundant rebuilds.

Access state in child widgets:
```dart
final theme = injector.of(context).textTheme;
```

---

## Design Decisions

### Why `custom_bloc`?
- Ensures separation of concerns by isolating business logic from UI.
- Simplifies handling of complex asynchronous operations like API calls and refresh mechanisms.

### Why `InheritedWidget`?
- Lightweight and built into the Flutter framework.
- Avoids the boilerplate of external packages for managing global state.
- Efficient for simple state management tasks like theme and language.

### Extensibility
The architecture is designed to be modular, allowing easy addition of features, state management, and customization.

---


