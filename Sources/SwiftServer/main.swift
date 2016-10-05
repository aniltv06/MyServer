//
//  main.swift
//  SwiftServer
//
//  Created by Anil Kumar T V on 14/09/16.
//
//

import Foundation
import Kitura
import LoggerAPI

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

let fileManager = FileManager.default
#if os(Linux)
let sourcePath = fileManager.currentDirectoryPath + "/resources"
let destinationPath = fileManager.currentDirectoryPath + "/Packages/Kitura-1.0.0/Sources/Kitura/resources"
#else
let folderPath = NSString(string: #file)
let fldrPath = folderPath.deletingLastPathComponent as String
let basePath = fldrPath.replacingOccurrences(of: "/Sources/SwiftServer", with: "")
let sourcePath = ("\(basePath)/resources")
let destinationPath = ("\(basePath)/Packages/Kitura-1.0.0/Sources/Kitura/resources")
#endif

do {
    try fileManager.removeItem(atPath: destinationPath as String)
}
catch let error as NSError {
    print("Ooops! Something went wrong: \(error)")
}
do {
    try fileManager.moveItem(atPath: sourcePath as String, toPath: destinationPath as String)
} catch let error as NSError {
    print("Ooops! Something went wrong: \(error)")
}

let router = Router()
Log.debug("Main File")
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





