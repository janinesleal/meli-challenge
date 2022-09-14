//
//  ProductResponse.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 14/09/22.
//

import Foundation

// MARK: - ProductResponse
struct ProductResponse: Codable, Hashable {
    let code: Int?
    let body: Body?
    
    static func == (lhs: ProductResponse, rhs: ProductResponse) -> Bool { lhs.body?.id == rhs.body?.id }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(body?.id)
    }
}

// MARK: - Body
struct Body: Codable {
    let id: String?
    let title: String?
    let officialStoreID: Int?
    let price: Double?
    let originalPrice: Double?
    let currencyID: String?
    let initialQuantity, availableQuantity, soldQuantity: Int?
    let buyingMode, listingTypeID, startTime, stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnailID: String?
    let thumbnail: String?
    let secureThumbnail: String?
    let pictures: [Picture]?
    let videoID: String?
    let acceptsMercadopago: Bool?
    let status: String?
    let tags: [String]?
    let warranty: String?
    let dateCreated, lastUpdated: String?
}

// MARK: - Picture
struct Picture: Codable {
    let id: String?
    let url: String?
    let secureURL: String?
    let size, maxSize, quality: String?
}
