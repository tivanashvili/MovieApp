//
//  Movie.swift
//  MovieApp
//
//  Created by tornike ivanashvili on 19.07.23.
//
import Foundation

struct Movie: Codable {
    var film_name: String?
    var images: Images?
    var release_dates: [ReleaseDate]?
    var category: String?
    var synopsis_long: String?
    var film_trailer: URL?
}

struct Images: Codable {
    var poster: [String: Poster]?
    var emptyPoster: [String]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            poster = try container.decodeIfPresent([String: Poster].self, forKey: .poster)
            emptyPoster = nil
        } catch {
            poster = nil
            emptyPoster = try container.decodeIfPresent([String].self, forKey: .poster)
        }
    }
}

struct Poster: Codable {
    var image_orientation: String?
    var medium: Medium?
    var region: String?
}

struct Medium: Codable {
    var film_image: String?
}

struct ReleaseDate: Codable {
    var release_date: String?
}

struct MovieResponse: Codable {
    var films: [Movie]?
}

struct Movies {
    var poster: String
    var name: String
    var genre: String
    var year: Int
}
