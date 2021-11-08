//
//  MovieRepresentable.swift
//  TMDB
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import Foundation

protocol MovieRepresentable {
    var title: String? { get }
    var posterImageUrl: URL? { get }
    var averageRating: Double? { get }
}
