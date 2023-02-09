import UIKit

struct MostViewedArticleModel: Decodable {
    let articleTitle: String
    let articleText: String
    let articleAuthor: String
    let articleURL: String

    enum CodingKeys: String, CodingKey {
        case articleTitle = "title"
        case articleText = "abstract"
        case articleAuthor = "byline"
        case articleURL = "url"
    }
}
