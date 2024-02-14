//
//  OnTheMapModel.swift
//  optima
//
//  Created by Тауекел on 17.01.2024.
//

// MARK: - List
struct List: Codable {
    let list: [Item]
}

// MARK: - Item
struct Item: Codable {
    let logoImage, title, subtitle, distance: String
}
