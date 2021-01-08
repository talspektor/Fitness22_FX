//
//  SeccionModel.swift
//  Fitness22_Ex
//
//  Created by Tal talspektor on 07/01/2021.
//

import Foundation

struct SessionsListModel: Codable {
    let array: [SessionModel]
}

struct SessionModel: Codable {
    let length: Int
    let quoteAuthor: String
    let quote: String
    let chapterName: String
    let chapter: Int
    let difficulty: String
}
