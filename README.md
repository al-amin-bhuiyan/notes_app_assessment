# Notes App

A production-ready robust Notes application built with Flutter using Clean Architecture principles and Firebase integration.

## Features

*   **Authentication**: Secure user authentication using Firebase Auth (Email/Password).
*   **Real-time Database**: Cloud Firestore integration for real-time note syncing.
*   **Clean Architecture**: Separation of concerns into Data, Domain, and Presentation layers.
*   **State Management**: efficient state handling via GetX.
*   **Routing**: Robust navigation using Go Router.
*   **Responsive UI**: Adaptive layout across devices using Flutter ScreenUtil.
*   **Minimalist Design**: Clean, modern monochrome theme with flat components.

## Architecture

The application is structured using Clean Architecture:
*   `lib/app/`: App-level settings, themes, and configuration.
*   `lib/core/`: Common utilities, constants, error handling, and networking.
*   `lib/features/`: Contains feature modules (Auth, Notes). Each feature comprises:
    *   `data/`: Models, Repositories implementations, and Remote/Local sources.
    *   `domain/`: Entities, Repository interfaces, and Use Cases.
    *   `presentation/`: UI (Pages, Widgets) and State management (Controllers).

## Key Libraries Used

*   `firebase_core`, `firebase_auth`, `cloud_firestore`: Firebase integration.
*   `get`: Dependency injection and robust state management.
*   `go_router`: Declarative routing based on Navigator 2.0.
*   `toastification`: Elegant in-app notification overlays.
*   `flutter_screenutil`: Easy scaling for responsive UI.
*   `dartz`: Functional programming for solid error handling.
*   `equatable`: Simplifying value equality in Dart objects.

## Getting Started

1.  **Clone the Repository**

2.  **Ensure Flutter SDK is installed**
    Use Flutter `3.x` version. Check by running:
    ```bash
    flutter --version
    ```

3.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

4.  **Firebase Configuration**
    Ensure you have your Firebase environment configured. The project relies on `firebase_options.dart` which should be generated using the FlutterFire CLI if you are connecting it to a new backend.

5.  **Run the App**
    ```bash
    flutter run
    ```