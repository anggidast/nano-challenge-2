//
//  ItemModel.swift
//  NanoChallenge2
//
//  Created by anggidast on 26/07/22.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: Int
    let title: String
    let link: String
    let isDone: Bool
    
    init(id: Int, title: String, link: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.link = link
        self.isDone = isDone
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, link: link, isDone: !isDone)
    }
}

struct DataModel: Codable {
    let id: Int
    let user_id: Int
    let title: String
    let description: String
    let status: String
}


struct Response: Codable {
    let data: [DataModel]
}

struct PostResponse: Codable {
    let data: DataModel
}
