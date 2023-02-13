import UIKit

class ArticleDetailViewModel {
    
    //MARK: - Properties
    
    var articleTitle = ""
    var articleDescripton = ""
    var articleAuthor = ""
    var articleURL = ""
    
    //MARK: - Public
    
    func configure(with article: ArticleModel) {
        articleTitle = article.title
        articleDescripton = article.description
        articleAuthor = article.author
        articleURL = article.url
    }
}
