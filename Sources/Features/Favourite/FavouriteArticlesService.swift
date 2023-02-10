import Foundation

class FavouriteArticlesService {
    private(set) var favouriteArticles: [ArticleModel] = []

    func addToFavourites(article: ArticleModel) {
        favouriteArticles.append(article)
    }

    func removeArticle(with id: Int) {
        if let index = favouriteArticles.firstIndex(where: { $0.id == id }) {
            favouriteArticles.remove(at: index)
    }
}

    func isArticleExists(id: Int) -> Bool {
        favouriteArticles.filter({ $0.id == id }).isEmpty == false
    }
}
