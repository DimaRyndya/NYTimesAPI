import Foundation

struct MostViewedArticleResponse: Decodable {
    var mostViewedArticles: [MostViewedArticleModel] = []

    enum CodingKeys: String, CodingKey {
        case mostViewedArticles = "results"
    }
}
