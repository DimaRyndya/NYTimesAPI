import UIKit

class ArticleDetailViewModel {

    //MARK: - Properties
    
    var articleTitle = ""
    var articleText = ""
    var articleAuthor = ""
    var articleURL = ""

    //MARK: - Public

    func configure(with article: ArticleModel) {
        articleTitle = article.title
        articleText = article.description
        articleAuthor = article.author
        articleURL = article.url
    }
}