import Foundation
import CoreData

class FavouriteArticlesCacheService {

    var managedObjectContext: NSManagedObjectContext!

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

    func add(article: ArticleModel) {

        let persistedArticle = PersistedArticleModel(context: managedObjectContext)
        persistedArticle.articleTitle = article.articleTitle
        persistedArticle.articleText = article.articleText
        persistedArticle.articleAuthor = article.articleAuthor
        persistedArticle.articleURL = article.articleURL
        persistedArticle.id = Int64(article.id)
        persistedArticle.isFavourite = article.isFavourite

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }

    func getArticles() {
        var persistentArticles: [PersistedArticleModel]
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersistedArticleModel")
            persistentArticles = try managedObjectContext.fetch(fetchRequest) as! [PersistedArticleModel]
        } catch {
            fatalError("Error: \(error)")
        }

        favouriteArticles = persistentArticles.map {
            ArticleModel(article: $0)
        }
    }
}
