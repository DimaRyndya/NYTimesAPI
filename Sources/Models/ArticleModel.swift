import UIKit

class ArticleModel: Decodable {
    let articleTitle: String
    let articleText: String
    let articleAuthor: String
    let articleURL: String
    let id: Int

    var isFavourite = false

    init(articleTitle: String, articleText: String, articleAuthor: String, articleURL: String, isFavourite: Bool, id: Int) {
        self.articleTitle = articleTitle
        self.articleText = articleText
        self.articleAuthor = articleAuthor
        self.articleURL = articleURL
        self.isFavourite = isFavourite
        self.id = id
    }

    convenience init(article: PersistedArticleModel) {
        self.init(articleTitle: article.articleTitle ?? "", articleText: article.articleText ?? "", articleAuthor: article.articleAuthor ?? "", articleURL: article.articleURL ?? "", isFavourite: article.isFavourite, id: Int(article.id))
    }

    enum CodingKeys: String, CodingKey {
        case articleTitle = "title"
        case articleText = "abstract"
        case articleAuthor = "byline"
        case articleURL = "url"
        case id
    }
}
