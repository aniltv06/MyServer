//
//  RequestHandler.swift
//  SwiftServer
//
//  Created by anilkumar thatha. venkatachalapathy on 15/09/16.
//
//

import Kitura
import Foundation
import LoggerAPI

public class HomeParser: RouterMiddleware {
    
    public func handle (request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        print("Home called")
        do {
            /*#if os(Linux)
                let fileManager = FileManager.default
                let sourcePath = fileManager.currentDirectoryPath + "/resources/index.html"
            #else
                let folderPath = NSString(string: #file)
                let fldrPath = folderPath.deletingLastPathComponent as String
                let basePath = fldrPath.replacingOccurrences(of: "/Sources/SwiftServer", with: "")
                let sourcePath = ("\(basePath)/resources/index.html")
            #endif*/
            
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
            
            try response.send(fileName: destinationPath)
            //try response.send("Response from Home").end()
            try response.status(.OK).end()
        } catch {
            print("err")
        }
        next()
    }
}
