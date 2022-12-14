//
//  ProductByCategoryResponse.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation
// MARK: - ProductByCategory
struct ProductByCategoryResponse: Codable {
    let query_data: QueryData?
    let content: [Content]?
    let status: Int?
}

// MARK: - Content
struct Content: Codable {
    let id: String?
    let position: Int?
    let type: String?
}

// MARK: - QueryData
struct QueryData: Codable {
    let highligh_type, criteria, id: String?
}

