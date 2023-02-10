import UIKit

class MostSharedDetailViewModel {

    var articleTitle = ""
    var articleText = ""
    var articleAuthor = ""
    var articleURL = ""

    func configure(with article: ArticleModel) {
        articleTitle = article.articleTitle
        articleText = article.articleText
        articleAuthor = article.articleAuthor
        articleURL = article.articleURL
    }
}
