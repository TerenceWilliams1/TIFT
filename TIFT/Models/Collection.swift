//
//  Collection.swift
//  TIFT
//
//  Created by Terence Williams on 1/4/22.
//

import Foundation

struct Collection: Decodable, Encodable {
    let categories: [Category]
    let highlights: [Quote]
    
    init(categories: [Category], highlights: [Quote]) {
        self.categories = categories
        self.highlights = highlights
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categories = try container.decode(Array<Category>.self, forKey: .categories)
        highlights = try container.decode(Array<Quote>.self, forKey: .highlights)
    }
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case highlights = "highlights"
    }
}
