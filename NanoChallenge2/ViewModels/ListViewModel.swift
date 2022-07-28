//
//  ListViewModel.swift
//  NanoChallenge2
//
//  Created by anggidast on 27/07/22.
//

import Foundation
import UIKit
import SwiftUI

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    @State var isEdit: Bool = false
    @State var url = "https://gotodo-api.herokuapp.com"
    @State var headers = [
        "Content-Type": "application/json",
        "Accept": "*/*",
        "access_token": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImRlbW9AdXNlci5jb20iLCJleHAiOjE2NTkwNDc3NzMsImlkIjoxfQ.A4Xip-ek4rjnmaBE0dh75otcs0pHFp1OkldBsDTkkn8"
    ]
    
    init() {
        getItems()
    }
    
    func getItems() {
        let getUrl = URL(string: "\(url)/todos")
        guard getUrl != nil else { return }
        var request = URLRequest(url: getUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil && data != nil {
                if let response = try? JSONDecoder().decode(Response.self, from: data!) {
                    DispatchQueue.main.async {
                        let dataResponse = response.data
                        for item in dataResponse {
                            let dataItem = ItemModel(id: item.id, title: item.title, link: item.description, isDone: item.status == "done" ? true : false)
                            self.items.append(dataItem)
                        }
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func deleteItem(id: Int) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            
            let getUrl = URL(string: "\(url)/todos/\(id)")
            guard getUrl != nil else { return }
            var request = URLRequest(url: getUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            request.allHTTPHeaderFields = headers
            request.httpMethod = "DELETE"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil && data != nil {
                    if (try? JSONDecoder().decode(PostResponse.self, from: data!)) != nil {
                        DispatchQueue.main.async {
                            self.items.remove(at: index)
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func addItem(title: String, link: String) {
        let getUrl = URL(string: "\(url)/todos")
        guard getUrl != nil else { return }
        var request = URLRequest(url: getUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        request.allHTTPHeaderFields = headers
        let jsonBody = [
            "title": title,
            "description": link,
            "status": "undone",
            "due_date": "2023-01-01"
        ] as [String:Any]
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .fragmentsAllowed)
            request.httpBody = requestBody
        } catch {
            return
        }
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil && data != nil {
                if let response = try? JSONDecoder().decode(PostResponse.self, from: data!) {
                    let item = response.data
                    DispatchQueue.main.async {
                        let newItem = ItemModel(id: item.id, title: item.title, link: item.description, isDone: item.status == "done" ? true : false)
                        self.items.append(newItem)
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func updateStatus(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            
            let getUrl = URL(string: "\(url)/todos/\(item.id)")
            guard getUrl != nil else { return }
            var request = URLRequest(url: getUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            request.allHTTPHeaderFields = headers
            let jsonBody = [
                "status": item.isDone == true ? "undone" : "done"
            ] as [String:Any]
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .fragmentsAllowed)
                request.httpBody = requestBody
            } catch {
                return
            }
            request.httpMethod = "PATCH"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil && data != nil {
                    if let response = try? JSONDecoder().decode(PostResponse.self, from: data!) {
                        let item = response.data
                        DispatchQueue.main.async {
                            let updatedItem = ItemModel(id: item.id, title: item.title, link: item.description, isDone: item.status == "done" ? true : false)
                            self.items[index] = updatedItem
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            
            let getUrl = URL(string: "\(url)/todos/\(item.id)")
            guard getUrl != nil else { return }
            var request = URLRequest(url: getUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            request.allHTTPHeaderFields = headers
            let jsonBody = [
                "title": item.title,
                "description": item.link,
                "status": item.isDone ? "done" : "undone",
                "due_date": "2023-01-01"
            ] as [String:Any]
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: jsonBody, options: .fragmentsAllowed)
                request.httpBody = requestBody
            } catch {
                return
            }
            request.httpMethod = "PUT"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil && data != nil {
                    if let response = try? JSONDecoder().decode(PostResponse.self, from: data!) {
                        print(response)
                        let item = response.data
                        DispatchQueue.main.async {
                            let updatedItem = ItemModel(id: item.id, title: item.title, link: item.description, isDone: item.status == "done" ? true : false)
                            self.items[index] = updatedItem
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
    
}
