//
//  Package.swift
//  
//
//  Created by Anil Kumar T V on 14/09/16.
//
//

import PackageDescription

let package = Package(
    name: "SwiftServer",
    targets: [
        Target(
            name: "SwiftServer",
            dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 28),
    ]
)
