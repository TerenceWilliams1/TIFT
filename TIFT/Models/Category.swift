//
//  Category.swift
//  TIFT
//
//  Created by Terence Williams on 1/4/22.
//

struct Category: Decodable, Encodable {
    let title: String
    let quotes: [Quote]
    
    init(title: String, quotes: [Quote]) {
        self.title = title
        self.quotes = quotes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        quotes = try container.decode(Array<Quote>.self, forKey: .quotes)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case quotes = "quotes"
    }
}

