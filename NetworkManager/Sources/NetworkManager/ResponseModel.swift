//
//  File.swift
//  
//
//  Created by Emir Alkal on 13.04.2023.
//

import Foundation

struct ResponseModel: Codable {
    let place: Place
}

public struct Place: Codable {
    public let countryCode: String
    public let country: String
    public let region: String
    public let city: String
    public let latitude: Double
    public let longitude: Double
}
