//
//  CityesModel.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 06.07.2023.
//

import Foundation

struct CityesModel: Codable {
    let status: Int
    let items: [Item]
    let limit, balans: Int
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let name: String
    let area: Int
    let telcod: Telcod
    let latitude, longitude: Double
    let timeZone: Int
    let english: String
    let rajon: Int
    let country: Country
    let level: Int
    let iso: String?
    let vid: Int
    let post: Post
    let fullName: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, name, area, telcod, latitude, longitude
        case timeZone = "time_zone"
        case english, rajon, country, level, iso, vid, post
        case fullName = "full_name"
        case url
    }
}

enum Country: String, Codable {
    case ru = "RU"
}

enum Post: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Post.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Post"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum Telcod: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Telcod.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Telcod"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
