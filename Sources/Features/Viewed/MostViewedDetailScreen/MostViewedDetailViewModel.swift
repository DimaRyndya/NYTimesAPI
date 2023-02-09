import UIKit

class MostViewedDetailViewModel {

    var articleTitle = ""
    var articleText = ""
    var articleAuthor = ""
    var articleURL = ""

    func configure(with article: MostViewedArticleModel) {
        articleTitle = article.articleTitle
        articleText = article.articleText
        articleAuthor = article.articleAuthor
        articleURL = article.articleURL
    }
}
