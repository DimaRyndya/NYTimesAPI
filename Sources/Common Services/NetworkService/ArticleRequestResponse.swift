import Foundation

struct ArticleRequestResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case articles = "results"
    }
    var articles: [ArticleModel] = []
}
