import UIKit

protocol MostEmailedViewModelDelegate: AnyObject {
    func reloadUI()
}

class MostEmailedViewModel {
    enum State {
        case loading
        case foundArticles
    }

    var state: State = .loading
    var mostEmailedArticles: [MostEmailedArticleModel] = []
    let mostEmailedArtcleService = MostEmailedArticleService()
    weak var delegate: MostEmailedViewModelDelegate?

    func loadArticles() {
        mostEmailedArtcleService.fetchArticles { [weak self] response in
            guard let self else { return }
            self.mostEmailedArticles = response
            self.delegate?.reloadUI()
        }
    }
}
