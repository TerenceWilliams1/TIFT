//
//  Quote.swift
//  TIFT
//
//  Created by Terence Williams on 1/4/22.
//

import Foundation

struct Quote: Decodable, Encodable {
    var quote: String
    var author: String
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quote = try container.decode(String.self, forKey: .quote)
        author = try container.decode(String.self, forKey: .author)
    }
    
    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case author = "author"
    }
}

