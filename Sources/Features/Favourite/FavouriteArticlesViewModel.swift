import UIKit

protocol FavouriteArticlesViewModelDeleagte: AnyObject {
    func updateUI()
}

class FavouriteArticlesViewModel: ArticleTableViewCellDelegate {

    var favouriteArticlesService: FavouriteArticlesCacheService

    init(favouriteArticlesService: FavouriteArticlesCacheService) {
        self.favouriteArticlesService = favouriteArticlesService
    }

    weak var delegate: FavouriteArticlesViewModelDeleagte?

    func dataIsLoaded() {
        favouriteArticlesService.getArticles()
        if !favouriteArticlesService.favouriteArticles.isEmpty {
            delegate?.updateUI()
        }
    }
    
    func toggleFavouriteState(for article: ArticleModel) {
        favouriteArticlesService.removeArticle(with: article.id)
    }
}
