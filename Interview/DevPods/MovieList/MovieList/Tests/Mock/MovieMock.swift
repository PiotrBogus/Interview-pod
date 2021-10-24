
import Foundation
import Shared

extension Movie {
    
    static let fixture = Movie.init(title: "test_title",
                                    year: "test_year",
                                    rated: "test_rated",
                                    released: "test_released",
                                    runtime: "test_runtime",
                                    genre: "test_genre",
                                    director: "test_director",
                                    writer: "test_writer",
                                    actors: "test_actors",
                                    plot: "test_plot",
                                    language: "test_language",
                                    country: "test_country",
                                    awards: "test_awards",
                                    poster: "test_poster",
                                    ratings: [Rating.fixture],
                                    metascore: "test_metascore",
                                    imdbRating: "test_imdbRating",
                                    imdbVotes: "test_imdbVotes",
                                    imdbID: "test_imdbID",
                                    type: .movie,
                                    dvd: "test_dvd",
                                    boxOffice: "test_boxOffice",
                                    production: "test_production",
                                    website: "test_website",
                                    response: "test_response")
}
