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

var destinationPath : String = ""
let sourcePath: String
#if os(Linux)
 sourcePath = fileManager.currentDirectoryPath + "/resources"
let basePath = fileManager.currentDirectoryPath
for suffix in ["/Packages", "/.build/checkouts"] {
    let packagePath: String
    packagePath = basePath + suffix
    
    do {
        let packages = try fileManager.contentsOfDirectory(atPath: packagePath)
        for package in packages {
            let potentialResource = "\(packagePath)/\(package)/Sources/Kitura"
            print(potentialResource)
            let resourceExists = fileManager.fileExists(atPath: potentialResource)
            if resourceExists {
                print("Resource Found")
                destinationPath = potentialResource + "/resources"
            }
        }
    } catch {
        Log.error("No packages found in \(packagePath)")
    }
}
#else
let folderPath = NSString(string: #file)
let fldrPath = folderPath.deletingLastPathComponent as String
let basePath = fldrPath.replacingOccurrences(of: "/Sources/SwiftServer", with: "")
    
for suffix in ["/Packages", "/.build/checkouts"] {
    let packagePath: String
    packagePath = basePath + suffix
    
    do {
        let packages = try fileManager.contentsOfDirectory(atPath: packagePath)
        for package in packages {
            let potentialResource = "\(packagePath)/\(package)/Sources/Kitura"
            print(potentialResource)
            let resourceExists = fileManager.fileExists(atPath: potentialResource)
            if resourceExists {
                print("Resource Found")
                destinationPath = potentialResource + "/resources"
            }
        }
    } catch {
        Log.error("No packages found in \(packagePath)")
    }
}
    
sourcePath = ("\(basePath)/resources")
#endif

if destinationPath != "" {
    do {
        try fileManager.removeItem(atPath: destinationPath as String)
        print("Removed destination items successfully")
    }
    catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }
    do {
        #if os(Linux)
            try fileManager.moveItem(atPath: sourcePath as String, toPath: destinationPath as String)
        #else
            try fileManager.copyItem(atPath: sourcePath as String, toPath: destinationPath as String)
        #endif
        print("Copied destination items successfully")
    } catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }

}

let router = Router()
Log.debug("Main File")
router.all("/*", middleware: BodyParser())
router.all("/home", middleware: HomeParser())

let environmentVars = ProcessInfo.processInfo.environment
print(environmentVars)
let portString: String = environmentVars["PORT"] ?? "8091"
let portNumber = Int(portString)
print("port Number \(String(describing: portNumber)))")

// start the server
print("starting server port: \(String(describing: portNumber))")
Kitura.addHTTPServer(onPort: portNumber!, with: router)

print("Server listening on Port: \(String(describing: portNumber))")
Kitura.run()





