import Foundation

struct MostSharedArticleResponse: Decodable {
    var mostSharedArticles: [ArticleModel] = []

    enum CodingKeys: String, CodingKey {
        case mostSharedArticles = "results"
    }
}
