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

 //let folderPath = FileManager.default.currentDirectoryPath
//let fileName = NSString(string: #file)
//print(folderPath)
//print(fileName)
var folderPath = NSString(string: #file)
while(folderPath.lastPathComponent != "MyServer"){
    folderPath = folderPath.deletingLastPathComponent as NSString
}

var destinationPath = ("\(folderPath)/Packages/Kitura-1.0.0/Sources/Kitura/resources") as NSString
print(folderPath)

var sourcePath = ("\(folderPath)/Sources/SwiftServer/resources") as NSString

let fileManager = FileManager.default

// Delete 'subfolder' folder

do {
    try fileManager.removeItem(atPath: destinationPath as String)
}
catch let error as NSError {
    print("Ooops! Something went wrong: \(error)")
}
do {
 try fileManager.copyItem(atPath: sourcePath as String, toPath: destinationPath as String)
} catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }

private func getFilePath(for resource: String) -> String? {
    let fileManager = FileManager.default
    let potentialResource = getResourcePathBasedOnSourceLocation(for: resource)
    
    let fileExists = fileManager.fileExists(atPath: potentialResource)
    if fileExists {
        return potentialResource
    } else {
        return getResourcePathBasedOnCurrentDirectory(for: resource, withFileManager: fileManager)
    }
}

private func getResourcePathBasedOnSourceLocation(for resource: String) -> String {
    let fileName = NSString(string: #file)
    let resourceFilePrefixRange: NSRange
    let lastSlash = fileName.range(of: "/", options: .backwards)
    if  lastSlash.location != NSNotFound {
        resourceFilePrefixRange = NSMakeRange(0, lastSlash.location+1)
    } else {
        resourceFilePrefixRange = NSMakeRange(0, fileName.length)
    }
    return fileName.substring(with: resourceFilePrefixRange) + "resources/" + resource
}

private func getResourcePathBasedOnCurrentDirectory(for resource: String, withFileManager fileManager: FileManager) -> String? {
    do {
        let packagePath = fileManager.currentDirectoryPath + "/Packages"
        let packages = try fileManager.contentsOfDirectory(atPath: packagePath)
        for package in packages {
            let potentalResource = "\(packagePath)/\(package)/Sources/Kitura/resources/\(resource)"
            let resourceExists = fileManager.fileExists(atPath: potentalResource)
            if resourceExists {
                return potentalResource
            }
        }
    } catch {
        return nil
    }
    return nil
}

//var filePath = getFilePath(for: "index.html")

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


