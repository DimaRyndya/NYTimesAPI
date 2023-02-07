import UIKit

struct MostViewedArticleModel: Decodable {
    let articleTitle: String
    let articleText: String

    enum CodingKeys: String, CodingKey {
        case articleTitle = "title"
        case articleText = "abstract"
    }
}
