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

/*let portNumber: UInt16!

if let arg = CommandLine.arguments.last, let value = UInt16(arg) {
    portNumber = value
} else {
    print("Usage: \(CommandLine.arguments.first!) portNumber")
    exit(1)
}
*/
//.listen(process.env.PORT)

// start the server
print("starting server port: 8091")
Kitura.addHTTPServer(onPort: 80, with: router)

print("Server listening on Port: 8091")
Kitura.run()


