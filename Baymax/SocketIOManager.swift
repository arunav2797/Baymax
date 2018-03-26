//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by Rishabh Mittal on 28/10/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit
import SocketIO

var message = ""
var diseaseTBroadcast = ""

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()

    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://13.127.127.57:5001")! as URL)
    
    func establishConnection() {
        socket.connect()
        socket.on("emit") {(dataArray, ack) -> Void in
            print(dataArray)
            print("Emit Encountered")
        }
        socket.on("update") {(dataArray, ack) -> Void in
            let json = dataArray[0]
            let clustered = json as! [String:AnyObject]
            message = (clustered["message"] as? String? ?? "Unknown")!
            let alert = UIAlertController(title: "Emergency", message: message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(confirm)
            UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)

        }
    }
    
    func sendSignal() {
        socket.emit("update", ["disease": diseaseTBroadcast])
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func listenToServer() {
        socket.on("emit") {(dataArray, ack) -> Void in
            print(dataArray)
            print("Emit Encountered")
        }
    }

    override init() {
        super.init()
    }
}
