import UIKit

class MostSharedDetailViewModel {

    var articleTitle = ""
    var articleText = ""
    var articleAuthor = ""
    var articleURL = ""

    func configure(with article: ArticleModel) {
        articleTitle = article.title
        articleText = article.description
        articleAuthor = article.author
        articleURL = article.url
    }
}
