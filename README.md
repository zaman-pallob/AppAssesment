
# 📱 Product Listing App

A Flutter-based mobile application that displays a list of products, supports offline caching, and includes a simple login flow. This app uses **Clean Architecture**, **BLoC**, and **Hive** for offline data persistence.

---

## 📝 Project Description

This app showcases a list of products retrieved from a remote API (https://dummyjson.com) and caches them locally for offline access. It includes a basic login screen and navigates users to a product listing page. The architecture is modular, testable, and scalable, designed using domain-driven principles.

---

## 🧠 Business Logic

- **Login Flow**: The user lands on a login screen. Upon clicking "Login", they're redirected to the product page without credential validation (demo purposes).

- **Product Fetching**:
  - Data is fetched from `https://dummyjson.com`.
  - Fetched product data is cached locally using Hive.
  - Pagination is implemented using a `skip` parameter and local box storage (`page_0`, `page_16`, etc.).
  - The app uses a sync timer (2 minutes interval) to determine if new data needs to be fetched.

- **Offline Mode**:
  - Products are retrieved from Hive if no internet is available.
  - Sync time is tracked in a `trackerBox`.

- **Dependency Injection**:
  - All major services (Dio client, NetworkInfo, repositories, and use cases) are registered with `GetIt`.

---

## 📁 Code Structure

```
lib/
├── core/
│   ├── constants/           # App constants (URLs, box names, etc.)
│   ├── errors/              # Error and exception handling
│   ├── networks/            # Network client and connectivity info
│   └── utils/               # Logging, shared utilities
│
├── dependency/              # Dependency injection setup
│   └── di.dart
│
├── features/
│   ├── login/
│   │   └── presentation/pages/login_page.dart
│   └── product/
│       ├── data/            # Remote and local datasources
│       ├── domain/          # Usecases and repository interfaces
│       └── presentation/    # UI and Bloc for product page
│
└── main.dart                # App entry point
```

---

## 📥 App Download

**[👉 Download APK here](https://example.com/download/product-listing-app.apk)**  
> _Replace this link with your actual APK hosting link (e.g., Firebase App Distribution, GitHub Releases, etc.)_

---

## 🚀 Getting Started

To run the app locally:

```bash
flutter pub get
flutter run
```

---

## ✅ Dependencies

- Flutter BLoC
- Hive & Hive Flutter
- Dio
- GetIt
- Flutter ScreenUtil
