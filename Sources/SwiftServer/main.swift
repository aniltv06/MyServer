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
router.all("/home", middleware: HomeParser())

let environmentVars = ProcessInfo.processInfo.environment
print(environmentVars)
let portString: String = environmentVars["PORT"] ?? "8091"
let portNumber = Int(portString)
print("port Number \(portNumber))")

// start the server
print("starting server port: \(portNumber)")
Kitura.addHTTPServer(onPort: portNumber!, with: router)

print("Server listening on Port: \(portNumber)")
Kitura.run()


