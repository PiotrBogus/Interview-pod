
import UIKit

public struct Movie: Codable, Hashable {
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    public let identifier = UUID()

    public let title: String
    public let year: String
    public let rated: String?
    public let released: String?
    public let runtime: String?
    public let genre: String?
    public let director:String?
    public let writer: String?
    public let actors: String?
    public let plot: String?
    public let language: String?
    public let country: String?
    public let awards: String?
    public let poster: String
    public let ratings: [Rating]?
    public let metascore: String?
    public let imdbRating: String?
    public let imdbVotes: String?
    public let imdbID: String
    public let type: TypeEnum
    public let dvd: String?
    public let boxOffice: String?
    public let production: String?
    public let website: String?
    public let response: String?

    public init(title: String,
                year: String,
                rated: String?,
                released: String?,
                runtime: String?,
                genre: String?,
                director: String?,
                writer: String?,
                actors: String?,
                plot: String?,
                language: String?,
                country: String?,
                awards: String?,
                poster: String,
                ratings: [Rating]?,
                metascore: String?,
                imdbRating: String?,
                imdbVotes: String?,
                imdbID: String,
                type: TypeEnum,
                dvd: String?,
                boxOffice: String?,
                production: String?,
                website: String?,
                response: String?) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
        self.ratings = ratings
        self.metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.type = type
        self.dvd = dvd
        self.boxOffice = boxOffice
        self.production = production
        self.website = website
        self.response = response
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

