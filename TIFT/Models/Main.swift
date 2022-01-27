//
//  Main.swift
//  TIFT
//
//  Created by Terence Williams on 1/26/22.
//

import Foundation

struct Main: Decodable, Encodable {
    let collections: [Collection]
    
    init(collections: [Collection]) {
        self.collections = collections
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        collections = try container.decode(Array<Collection>.self, forKey: .collections)
    }
    
    enum CodingKeys: String, CodingKey {
        case collections = "collections"
    }
}
