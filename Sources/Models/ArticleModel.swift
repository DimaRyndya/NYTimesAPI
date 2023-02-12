import UIKit

//MARK: Helper Types

extension ArticleModel: Decodable {

    enum CodingKeys: String, CodingKey {
        case title, id, url
        case description = "abstract"
        case author = "byline"
    }
}

//MARK: Model

final class ArticleModel {
    
    let title: String
    let description: String
    let author: String
    let url: String
    let id: Int

    var isFavourite = false

    //MARK: Init

    init(title: String, description: String, author: String, url: String, isFavourite: Bool, id: Int) {
        self.title = title
        self.description = description
        self.author = author
        self.url = url
        self.isFavourite = isFavourite
        self.id = id
    }

    convenience init(article: PersistedArticleModel) {
        self.init(
            title: article.articleTitle ?? "",
            description: article.articleText ?? "",
            author: article.articleAuthor ?? "",
            url: article.articleURL ?? "",
            isFavourite: article.isFavourite,
            id: Int(article.id))
    }
}
