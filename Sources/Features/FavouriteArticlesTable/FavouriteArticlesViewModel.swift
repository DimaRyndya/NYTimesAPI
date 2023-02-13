import UIKit

protocol FavouriteArticlesViewModelDeleagte: AnyObject {
    func reloadUI()
}

final class FavouriteArticlesViewModel {

    //MARK: - Properties

    private(set) var favouriteArticles: [ArticleModel] = []

    var cacheService: CacheService

    weak var delegate: FavouriteArticlesViewModelDeleagte?

    //MARK: - Init

    init(cacheService: CacheService) {
        self.cacheService = cacheService
        if !favouriteArticles.isEmpty {
            self.favouriteArticles = cacheService.getArticles()
        }
    }
}

//MARK: - ArticleTableViewCell Delegate

extension FavouriteArticlesViewModel: ArticleTableViewCellDelegate {

    func articlesIsUpdated() {
        favouriteArticles = cacheService.getArticles()
        delegate?.reloadUI()
    }

    func toggleFavouriteState(for article: ArticleModel) {
        cacheService.removeArticle(with: article.id)
        articlesIsUpdated()
        delegate?.reloadUI()
    }
}
