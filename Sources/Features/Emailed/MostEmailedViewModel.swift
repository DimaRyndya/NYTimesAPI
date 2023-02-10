import UIKit

protocol MostEmailedViewModelDelegate: AnyObject {
    func reloadUI()
}

class MostEmailedViewModel: ArticleTableViewCellDelegate {

    enum State {
        case loading
        case foundArticles
    }

    var state: State = .loading
    var mostEmailedArticles: [ArticleModel] = []
    let mostEmailedArtcleService = MostEmailedArticleService()
    var favouriteArticlesService: FavouriteArticlesService
    weak var delegate: MostEmailedViewModelDelegate?

    init(favouriteArticlesService: FavouriteArticlesService) {
        self.favouriteArticlesService = favouriteArticlesService

    }


    func loadArticles() {
        mostEmailedArtcleService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.mostEmailedArticles = response
            self.delegate?.reloadUI()
        }
    }

    func toggleFavouriteState(for article: ArticleModel) {
        if favouriteArticlesService.isArticleExists(id: article.id) {
            favouriteArticlesService.removeArticle(with: article.id)
        } else {
            favouriteArticlesService.addToFavourites(article: article)
        }
    }
}
