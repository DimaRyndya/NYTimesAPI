import UIKit

protocol MostViewedViewModelDelegate: AnyObject {
    func reloadUI()
}

class MostViewedViewModel {

    enum State {
        case loading
        case foundArticles
    }

    var state: State = .loading
    var mostViewedArticles: [ArticleModel] = []
    let mostViewedArticleService = MostViewedArticleService()
    weak var delegate: MostViewedViewModelDelegate?

    func loadArticles() {
        mostViewedArticleService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.mostViewedArticles = response
            self.delegate?.reloadUI()
        }
    }
    
}
