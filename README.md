# keeper

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Development Notes

- This app uses Supabase for auth and realtime database features. The
	primary database service code is in `lib/services/database.dart` and the
	auth wrapper is in `lib/services/auth.dart`.
- The app prefers realtime updates (Supabase Realtime). If you enable
	realtime for the `items` table, the UI will update incrementally.
- The authentication wrapper exposes a stream `AuthenticationService().authStateChanges`.
- UI-level providers are located in `lib/pages/wrapper.dart` and the
	`HomePage` listens to a stream of items. To avoid temporary placeholder
	data the `Wrapper` widget uses a `StreamBuilder` and passes the resolved
	`MyUser` down via a `Provider`.

<img height="1000" alt="Simulator Screenshot - iPhone 16e - 2025-12-19 at 22 14 48" src="https://github.com/user-attachments/assets/b62d31f8-ea4e-477f-90be-318be3039f04" />
<img height="1000" alt="Simulator Screenshot - iPhone 16e - 2025-12-19 at 22 15 06" src="https://github.com/user-attachments/assets/73e9ae85-fd70-4326-89f7-6eb670cbf778" />


## Quick Commands

Run the app:

```bash
flutter pub get
flutter run
```

Analyze the project:

```bash
flutter analyze
```

