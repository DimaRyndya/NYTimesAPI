import UIKit

protocol MostSharedViewModelDelegate: AnyObject {
    func reloadUI()
}

class MostSharedViewModel {

    enum State {
        case loading
        case foundArticles
    }

    var state: State = .loading
    var mostSharedArticles: [ArticleModel] = []
    let mostSharedArticleService = MostSharedArticleService()
    weak var delegate: MostSharedViewModelDelegate?

    func loadArticles() {
        mostSharedArticleService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.mostSharedArticles = response
            self.delegate?.reloadUI()
        }
    }
}
