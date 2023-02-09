import UIKit

class MostEmailedDetailViewModel {

    var articleTitle = ""
    var articleText = ""
    var articleAuthor = ""
    var articleURL = ""

    func configure(with article: MostEmailedArticleModel) {
        articleTitle = article.articleTitle
        articleText = article.articleText
        articleAuthor = article.articleAuthor
        articleURL = article.articleURL
    }
}
