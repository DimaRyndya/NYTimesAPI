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
    let networkService: ArticlesNetworkService
    let cacheService: CacheService

    weak var delegate: MostEmailedViewModelDelegate?

    //MARK: Init

    init(cacheService: CacheService, networkService: ArticlesNetworkService) {
        self.cacheService = cacheService
        self.networkService = networkService
    }

    //MARK: Public

    func articleIsTheSameAs(article: ArticleModel) -> Bool {
        let cachedArticles = cacheService.getArticles()
        let filteredArticles = cachedArticles.filter({ $0.id == article.id })
        return !filteredArticles.isEmpty
    }

    func loadArticles() {
        networkService.fetchArticles { [weak self] response in
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
        delegate?.reloadUI()
    }
}
