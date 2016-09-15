//
//  main.swift
//  SwiftServer
//
//  Created by Anil Kumar T V on 14/09/16.
//
//

import Foundation
import Kitura

#if os(Linux)
    import Glibc
    #else
    import Darwin.C
#endif

let router = Router()

router.all("/*", middleware: BodyParser())

let portNumber: UInt16!

if let arg = Process.arguments.last, value = UInt16(arg) {
    portNumber = value
} else {
    print("Usage: \(Process.arguments.first!) portNumber")
    exit(1)
}

// start the server
print("starting server port: 8091")
Kitura.addHTTPServer(onPort: portNumber, with: router)

print("Server listening on Port: 8091")
Kitura.run()
