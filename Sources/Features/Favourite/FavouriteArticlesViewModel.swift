import UIKit

protocol FavouriteArticlesViewModelDeleagte: AnyObject {
    func updateUI()
}

class FavouriteArticlesViewModel: ArticleTableViewCellDelegate {

    private(set) var favouriteArticles: [ArticleModel] = []

    var cacheService: CacheService

    init(cacheService: CacheService) {
        self.cacheService = cacheService
        if !favouriteArticles.isEmpty {
            self.favouriteArticles = cacheService.getArticles()
        }
    }

    weak var delegate: FavouriteArticlesViewModelDeleagte?

    func articlesIsUpdated() {
        favouriteArticles = cacheService.getArticles()
        delegate?.updateUI()
    }
    
    func toggleFavouriteState(for article: ArticleModel) {
        cacheService.removeArticle(with: article.id)
        articlesIsUpdated()
    }
}
