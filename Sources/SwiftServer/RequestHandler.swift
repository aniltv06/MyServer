//
//  RequestHandler.swift
//  SwiftServer
//
//  Created by anilkumar thatha. venkatachalapathy on 15/09/16.
//
//

import Kitura
import Foundation

public class HomeParser: RouterMiddleware {
    
    public func handle (request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        print("Home called")
        do {
            try response.send("Response from Home").end()
            let folderPath = NSString(string: #file)
            let fldrPath = folderPath.deletingLastPathComponent as String
            let basePath = fldrPath.replacingOccurrences(of: "/Sources/SwiftServer", with: "")
            
            print(folderPath)
            
            let sourcePath = ("\(basePath)/Sources/SwiftServer/resources/index.html")
            try response.send(fileName: sourcePath)
            try response.status(.OK).end()
        } catch {
            print("err")
        }
        next()
    }
}
