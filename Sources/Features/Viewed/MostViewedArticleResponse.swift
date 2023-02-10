import Foundation

struct MostViewedArticleResponse: Decodable {
    var mostViewedArticles: [ArticleModel] = []

    enum CodingKeys: String, CodingKey {
        case mostViewedArticles = "results"
    }
}
