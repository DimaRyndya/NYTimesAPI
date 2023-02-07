import UIKit

struct MostSharedArticleModel: Decodable {
    let articleTitle: String
    let articleText: String

    enum CodingKeys: String, CodingKey {
        case articleTitle = "title"
        case articleText = "abstract"
    }
}
