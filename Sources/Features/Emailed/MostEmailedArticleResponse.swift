import Foundation

struct MostEmailedArticleResponse: Decodable {
    var mostEmailedArticles: [ArticleModel] = []

    enum CodingKeys: String, CodingKey {
        case mostEmailedArticles = "results"
    }
}
