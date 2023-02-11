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
    var cacheService: CacheService
    weak var delegate: MostEmailedViewModelDelegate?

    init(cacheService: CacheService) {
        self.cacheService = cacheService
    }

    func articleIsTheSameAS(article: ArticleModel) -> Bool {
        let cachedArticles = cacheService.getArticles()
        return cachedArticles.filter({ $0.id == article.id }).isEmpty == false
    }

    func loadArticles() {
        mostEmailedArtcleService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.mostEmailedArticles = response
            self.delegate?.reloadUI()
        }
    }

    func toggleFavouriteState(for article: ArticleModel) {
        if cacheService.isArticleExists(id: article.id) {
            cacheService.removeArticle(with: article.id)
        } else {
            cacheService.add(article: article)
        }
    }
}
