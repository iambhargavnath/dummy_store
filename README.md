# DummyStore Flutter App

A modern Flutter e-commerce demo application built using:

- Clean Architecture
- Feature-First Modularization
- MVVM + MVI Principles
- Bloc State Management
- Dio Networking
- Drift Offline Database
- Infinite Scroll Pagination
- Dependency Injection
- Offline-First Support
- Cached Network Images

Uses DummyJSON Product API:

https://dummyjson.com/products

---

# Features

## Product Listing
- Infinite scrolling
- Lazy loading pagination
- Product cards
- Product images
- Offline support

## Product Search
- Online search API
- Offline fallback search
- Real-time search
- Search pagination

## Product Details
- Product image
- Description
- Price
- Category

## Offline Support
- Drift SQLite database
- Automatic caching
- Offline viewing
- Offline search fallback

## Image Caching
- CachedNetworkImage
- Disk cache support
- Offline image rendering

---

# Architecture

```text
lib/
│
├── core/
│   ├── database/
│   ├── di/
│   ├── network/
│   └── router/
│
├── features/
│   └── products/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
└── main.dart