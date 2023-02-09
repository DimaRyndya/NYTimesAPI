import UIKit

class MostEmailedArticleModel: Decodable {
    let articleTitle: String
    let articleText: String
    let articleAuthor: String
    let articleURL: String
    
    var isFavourite = false

    init(articleTitle: String, articleText: String, articleAuthor: String, articleURL: String, isFavourite: Bool = false) {
        self.articleTitle = articleTitle
        self.articleText = articleText
        self.articleAuthor = articleAuthor
        self.articleURL = articleURL
        self.isFavourite = isFavourite
    }

    enum CodingKeys: String, CodingKey {
        case articleTitle = "title"
        case articleText = "abstract"
        case articleAuthor = "byline"
        case articleURL = "url"
    }
}
