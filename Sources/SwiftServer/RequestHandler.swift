//
//  RequestHandler.swift
//  SwiftServer
//
//  Created by anilkumar thatha. venkatachalapathy on 15/09/16.
//
//

import Kitura

public class HomeParser: RouterMiddleware {
    
    public func handle (request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
        print("Home called")
        do {
            try response.send("Response from Home").end()
        } catch {
            print("err")
        }
        next()
    }
}
