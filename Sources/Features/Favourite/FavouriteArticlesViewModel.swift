import UIKit

protocol FavouriteArticlesViewModelDeleagte: AnyObject {
    func updateUI()
}

class FavouriteArticlesViewModel: ArticleTableViewCellDelegate {
    var favouriteArticlesService: FavouriteArticlesService

    init(favouriteArticlesService: FavouriteArticlesService) {
        self.favouriteArticlesService = favouriteArticlesService
    }

    weak var delegate: FavouriteArticlesViewModelDeleagte?

    func dataIsLoaded() {
        if !favouriteArticlesService.favouriteArticles.isEmpty {
            delegate?.updateUI()
        }
    }
    
    func toggleFavouriteState(for article: ArticleModel) {
        favouriteArticlesService.removeArticle(with: article.id)
    }
}
