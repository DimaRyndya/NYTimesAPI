import Foundation

struct MostSharedArticleResponse: Decodable {
    var mostSharedArticles: [MostSharedArticleModel] = []

    enum CodingKeys: String, CodingKey {
        case mostSharedArticles = "results"
    }
}
