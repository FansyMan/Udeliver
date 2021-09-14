//
//  FirebaseDeal.swift
//  Udeliver
//
//  Created by Surgeont on 02.09.2021.
//

import Foundation
import FirebaseDatabase

class FirebaseDeal {
    
    let dealId: Int
    let dealName: String
    let fromAddress: String
    let toAddress: String
    let price: String
    let status: String
    let comments: String
    let executorName: String
    
    
    
    let ref: DatabaseReference?
    
    init(dealId: Int,
         dealName: String,
         fromAddress: String,
         toAddress: String,
         price: String,
         status: String,
         comments: String,
         executorName: String) {
        
        self.dealId = dealId
        self.dealName = dealName
        self.fromAddress = fromAddress
        self.toAddress = toAddress
        self.price = price
        self.status = status
        self.comments = comments
        self.executorName = executorName
        
        self.ref = nil
    }



    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else { return nil }
        
        guard let dealId = value["dealId"] as? Int,
              let dealName = value["dealName"] as? String,
              let fromAddress = value["fromAddress"] as? String,
              let toAddress = value["toAddress"] as? String,
              let status = value["status"] as? String,
              let comments = value["comments"] as? String,
              let executorName = value["executorName"] as? String,
              let price = value["price"] as? String else { return nil }
        
        self.dealId = dealId
        self.dealName = dealName
        self.fromAddress = fromAddress
        self.toAddress = toAddress
        self.price = price
        self.status = status
        self.comments = comments
        self.executorName = executorName
        
        self.ref = snapshot.ref
    }
    
    init?(dict: [String: Any]) {
        
        guard let dealId = dict["dealId"] as? Int,
              let dealName = dict["dealName"] as? String,
              let fromAddress = dict["fromAddress"] as? String,
              let toAddress = dict["toAddress"] as? String,
              let status = dict["status"] as? String,
              let comments = dict["comments"] as? String,
              let executorName = dict["executorName"] as? String,
              let price = dict["price"] as? String else { return nil }
        
        self.dealId = dealId
        self.dealName = dealName
        self.fromAddress = fromAddress
        self.toAddress = toAddress
        self.status = status
        self.comments = comments
        self.executorName = executorName
        self.price = price
        
        self.ref = nil
        
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "dealId" : dealId,
            "dealName" : dealName,
            "fromAddress" : fromAddress,
            "toAddress" : toAddress,
            "status" : status,
            "comments" : comments,
            "executorName" : executorName,
            "price" : price
        ]
    }
    
}
