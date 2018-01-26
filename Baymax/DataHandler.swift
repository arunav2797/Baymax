//
//  DataHandler.swift
//  Baymax
//
//  Created by Rishabh Mittal on 29/10/17.
//  Copyright © 2017 Rishabh Mittal. All rights reserved.
//

import UIKit

struct symptomStruct {
    var name: String
    var category: String
    var selected: String
}

struct analysed {
    var name: String
    var percentage: String
}

var analysedCollection = [analysed]()

var sympCollection = [symptomStruct]()
var addedItems = [String]()

var psycho = [symptomStruct]()
var fluid = [symptomStruct]()
var active = [symptomStruct]()
var pain = [symptomStruct]()

class DataHandler: NSObject {
    static let shared: DataHandler = DataHandler()
    
    override init() {
        super.init()
    }
    
    func fetchAll(completion: @escaping (Int) -> ()) {

        let urlString1 = "http://vucode.adgvit.com/categories"
        let url1 = NSURL(string: urlString1)
        var request1 = URLRequest(url: url1 as! URL)
        request1.httpMethod = "get"
        
        let task1 = URLSession.shared.dataTask(with: request1) { (data1, response1, error1) in
            if error1 != nil {
                print("error:", error1!)
                return
            }
            
            do {
                guard let data1 = data1 else { return }
                guard let json1 = try JSONSerialization.jsonObject(with: data1, options: []) as? [String: AnyObject] else { return }
                let data = json1 as! [String:AnyObject]
                let parentNode = json1["symptoms"] as! [AnyObject]
                for symptom in parentNode {
                    let cluster = symptom as! [String:AnyObject]
                    let name = cluster["name"] as? String ?? ""
                    let category = cluster["category"] as? String ?? ""
                    let selected = "no"
                    let newItem = symptomStruct(name: name, category: category, selected: selected)
                    sympCollection.append(newItem)
                    switch category {
                    case "psycological/brain":
                        psycho.append(newItem)
                        break
                    case "Fluid discharge":
                        fluid.append(newItem)
                        break
                    case "activeness and movement":
                        active.append(newItem)
                        break
                    case "pain":
                        pain.append(newItem)
                        break
                    default:
                        break
                    }
                }
                print(sympCollection)
            } catch {
                print("error:", error)
            }
        }
        task1.resume()
    }
    
    func postSymptoms()
    {
        let s1 = addedItems[0]
        let s2 = addedItems[1]
        let s3 = addedItems[2]
        let s4 = addedItems[3]
        let s5 = addedItems[4]
        
        let dataproc: [String:Any] = ["symptom1":s1, "symptom2":s2, "symptom3":s3, "symptom4":s4, "symptom5":s5]
        let jsonDataproc = try? JSONSerialization.data(withJSONObject: dataproc, options: .prettyPrinted)
        
        let urlStringproc = "http://vucode.adgvit.com/disease"
        
        let urlproc = NSURL(string: urlStringproc)
        var requestproc = URLRequest(url: urlproc! as URL)
        requestproc.httpMethod = "post"
        requestproc.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestproc.httpBody = jsonDataproc
        
        let taskproc = URLSession.shared.dataTask(with: requestproc) { (dataproc, responseproc, errorproc) in
            if errorproc != nil {
                print("error:", errorproc!)
                return
            }
            do {
                
                guard let dataproc = dataproc else { return }
                guard let json = try JSONSerialization.jsonObject(with: dataproc, options: []) as? [String:AnyObject] else { return }
                
                print(json)
                analysedCollection.removeAll()
                let node = json
                let data = node["diseases"] as! NSArray
                for cluster in data {
                    let star = cluster as! [String:AnyObject]
                    let name = star["name"] as? String ?? "Unknown"
                    var percentage = star["relative_probability"] as! Float
                    percentage = ceilf(percentage)
                    let intPercent = Int(percentage)
                    let percentage1 = String(describing: intPercent)
                    let newItem2 = analysed(name: name, percentage: percentage1)
                    analysedCollection.append(newItem2)
                }
                if analysedCollection.count != 0 {
                var max = Int(analysedCollection[0].percentage)
                diseaseTBroadcast = analysedCollection[0].name
            
                for item in analysedCollection {
                    if (Int(item.percentage))! > max! {
                        max = Int(item.percentage)
                        diseaseTBroadcast = item.name
                    }
                }
                    SocketIOManager.sharedInstance.sendSignal()
                }
                print(analysedCollection)
            }
            catch {
                print("error:", error)
            }
            
        }
        taskproc.resume()
    }
    
}
