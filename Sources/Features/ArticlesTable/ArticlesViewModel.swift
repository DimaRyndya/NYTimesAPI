import UIKit

protocol ArticlesViewModelDelegate: AnyObject {
    func reloadUI(_ viewModel: ArticlesViewModel)
}

final class ArticlesViewModel: ArticleTableViewCellDelegate {
    
    enum State {
        case loading
        case foundArticles
    }
    
    //MARK: - Properties
    
    var state: State = .loading
    var articles: [ArticleModel] = []

    private let networkService: ArticlesNetworkService
    private let cacheService: CacheService
    
    weak var delegate: ArticlesViewModelDelegate?
    
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
    
    func loadArticles() {
        networkService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.articles = response
            self.delegate?.reloadUI(self)
        }
    }
    
    func toggleFavouriteState(_ cell: ArticleTableViewCell, for article: ArticleModel) {
        if cacheService.isArticleExists(id: article.id) {
            cacheService.removeArticle(with: article.id)
        } else {
            cacheService.add(article: article)
        }
        delegate?.reloadUI(self)
    }
}
