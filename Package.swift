// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CFUIComponents",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CFUIComponents",
            targets: ["CFUIComponents"]),
    ],
    dependencies: [
        .package(name: "Reachability", url: "https://github.com/ashleymills/Reachability.swift", .upToNextMajor(from: "5.1.0")),
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "9.4.0"),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CFUIComponents",
            dependencies: ["Reachability",
                           .product(name: "FirebaseAnalytics", package: "Firebase"),
                           .product(name: "FirebaseCrashlytics", package: "Firebase"),
                           .product(name: "FirebaseRemoteConfig", package: "Firebase")]),
        .testTarget(
            name: "CFUIComponentsTests",
            dependencies: ["CFUIComponents"]),
    ]
)
