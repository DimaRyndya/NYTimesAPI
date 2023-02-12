import UIKit

protocol MostViewedViewModelDelegate: AnyObject {
    func reloadUI()
}

class MostViewedViewModel {

    enum State {
        case loading
        case foundArticles
    }

    //MARK: - Properties

    var state: State = .loading
    var mostViewedArticles: [ArticleModel] = []
    let cacheService: CacheService
    let networkService: ArticlesNetworkService
    weak var delegate: MostViewedViewModelDelegate?

    //MARK: - Init

    init(cacheService: CacheService, networkService: ArticlesNetworkService) {
        self.cacheService = cacheService
        self.networkService = networkService
    }

    //MARK: - Public

    func articleIsTheSameAs(article: ArticleModel) -> Bool {
        let cachedArticles = cacheService.getArticles()
        let filteredArticles = cachedArticles.filter({ $0.id == article.id })
        return !filteredArticles.isEmpty
    }
}

extension MostViewedViewModel: ArticleTableViewCellDelegate {
    
    func loadArticles() {
        networkService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.mostViewedArticles = response
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
