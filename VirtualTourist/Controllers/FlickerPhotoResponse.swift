//
//  FlickerPhotoResponse.swift
//  Combinestagram
//
//  Created by Abdelahad on 2/16/19.
//  Copyright © 2019 Underplot ltd. All rights reserved.
//

import Foundation


struct FlickerPhotoResponse: Codable {
    let stat: String
    let photos: Photos
}

struct Photos: Codable {
    let perpage, pages: Int
    let photo: [Photo]
    let total: String
    let page: Int
}

struct Photo: Codable {
    let owner, secret, server, id: String
    let farm: Int
    let title: String
    let isfriend, isfamily, ispublic: Int
}

// MARK: Convenience initializers and mutators

extension FlickerPhotoResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(FlickerPhotoResponse.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
  }
}



public extension Collection {
    
    /// Convert self to JSON String.
    /// - Returns: Returns the JSON as String or empty string if error while parsing.
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Can't create string with data.")
                return "{}"
            }
            return jsonString
        } catch let parseError {
            print("json serialization error: \(parseError)")
            return "{}"
        }
    }
}
