//
//  main.swift
//  SwiftServer
//
//  Created by Anil Kumar T V on 14/09/16.
//
//

import Foundation
import Kitura

let router = Router()

router.all("/*", middleware: BodyParser())

// start the server
print("starting server port: 8091")
Kitura.addHTTPServer(onPort: 8091, with: router)

print("Server listening on Port: 8091")
Kitura.run()
