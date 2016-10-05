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
            #if os(Linux)
                let fileManager = FileManager.default
                let sourcePath = fileManager.currentDirectoryPath + "/Packages/Kitura-1.0.0/Sources/Kitura/resources"
            #else
                //try response.send("Response from Home").end()
                let folderPath = NSString(string: #file)
                let fldrPath = folderPath.deletingLastPathComponent as String
                let basePath = fldrPath.replacingOccurrences(of: "/Sources/SwiftServer", with: "")
                let sourcePath = ("\(basePath)/Sources/SwiftServer/resources/index.html")
            #endif
            try response.send(fileName: sourcePath)
            try response.status(.OK).end()
        } catch {
            print("err")
        }
        next()
    }
}
