import UIKit

protocol MostSharedViewModelDelegate: AnyObject {
    func reloadUI()
}

final class MostSharedViewModel: ArticleTableViewCellDelegate{

    enum State {
        case loading
        case foundArticles
    }

    var state: State = .loading
    var mostSharedArticles: [ArticleModel] = []
    let cacheService: CacheService
    let networkService: ArticlesNetworkService

    weak var delegate: MostSharedViewModelDelegate?

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
            self.mostSharedArticles = response
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
