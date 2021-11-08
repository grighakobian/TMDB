//
//  TVShowsResult.swift
//  Domain
//
//  Created by Grigor Hakobyan on 07.11.21.
//

public struct TVShowsResult: Codable {
    public let page: Int?
    public let totalPages: Int?
    public let totalResults: Int?
    public let results: [TVShow]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
