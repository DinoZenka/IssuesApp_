# Issues App

An offline-first Flutter application for browsing and managing issues (GitHub/Jira style).

## Features

- **Issues List**:
  - Client-side search and filtering (All, Open, Closed).
  - Pull-to-refresh for data synchronization.
  - Skeleton loaders for a smoother loading experience.
- **Issue Details**:
  - View issue details, toggle status (Open/Closed), and update priority.
  - Optimistic UI updates with rollback on failure.
- **Offline Support**:
  - Local data persistence using Drift.
  - Background network synchronization.
  - Connectivity status indication.

## Technologies

- **UI Framework**: Flutter (Material Design)
- **State Management**: [Riverpod](https://riverpod.dev/) (with code generation)
- **Networking**: [Dio](https://pub.dev/packages/dio) for REST API communication.
- **Local Database**: [Drift](https://drift.simonbinder.eu/) for offline-first persistence.
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router).
- **Loading States**: [Skeletonizer](https://pub.dev/packages/skeletonizer).
- **Icons**: Custom SVG icons using `flutter_svg`.

## Architecture

The project follows a layered architecture to separate concerns:

- **Data Layer**: DTOs, Local (Drift), and Remote (Dio) datasources.
- **Repository Layer**: Implementation of domain repositories that handle data synchronization and caching logic.
- **Domain Layer**: Core entities and repository interfaces.
- **Presentation Layer**: UI widgets, screens, and Riverpod providers for state management.

## Getting Started

### Prerequisites

- Flutter SDK (version specified in `pubspec.yaml`)
- Dart SDK

### Installation

1. Clone the repository.
2. Install dependencies:
   ```bash
   flutter pub get
   ```

### Code Generation

This project uses `build_runner` for code generation (Riverpod, Drift, JsonSerializable). To generate files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Running the App

The app requires specific environment variables for configuration. You can use the provided JSON files for different environments.

**Development:**

```bash
flutter run --dart-define-from-file=dev.json
```

**Production:**

```bash
flutter run --dart-define-from-file=prod.json
```

#### Environment Variables

- `BASE_URL`: The base URL for the REST API endpoint.
- `REMOTE_DATASOURCE_MOCK`: Boolean flag to enable/disable mocked remote data.
