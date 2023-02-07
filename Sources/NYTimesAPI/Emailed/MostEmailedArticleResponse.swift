import Foundation

struct MostEmailedArticleResponse: Decodable {
    var mostEmailedArticles: [MostEmailedArticleModel] = []

    enum CodingKeys: String, CodingKey {
        case mostEmailedArticles = "results"
    }
}
