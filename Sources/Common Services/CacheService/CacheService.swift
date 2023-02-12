import Foundation
import CoreData

final class CacheService {

    var managedObjectContext: NSManagedObjectContext!

    private let fetchRequest = NSFetchRequest<PersistedArticleModel>(entityName: "PersistedArticleModel")

    //MARK: Public

   func removeArticle(with id: Int) {
        do {
            var articles = try managedObjectContext.fetch(fetchRequest)
            guard let index = articles.firstIndex(where: { $0.id == id }) else { return }

            let object = articles.remove(at: index)
            managedObjectContext.delete(object)
            try? managedObjectContext.save()
        } catch {
            assertionFailure("Error: \(error)")
        }
    }

   func isArticleExists(id: Int) -> Bool {
        do {
            let articles = try managedObjectContext.fetch(fetchRequest)
            return articles.filter({ $0.id == id }).isEmpty == false
        } catch {
            fatalError("Error: \(error)")
        }
    }

   func add(article: ArticleModel) {
        let persistedArticle = PersistedArticleModel(context: managedObjectContext)
        persistedArticle.articleTitle = article.title
        persistedArticle.articleText = article.description
        persistedArticle.articleAuthor = article.author
        persistedArticle.articleURL = article.url
        persistedArticle.id = Int64(article.id)
        persistedArticle.isFavourite = article.isFavourite

        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }

   func getArticles() -> [ArticleModel] {
        var persistentArticles: [PersistedArticleModel] = []
        do {
            persistentArticles = try managedObjectContext.fetch(fetchRequest)
        } catch {
            fatalError("Error: \(error)")
        }

        let articleModel = persistentArticles.map { ArticleModel(article: $0) }
        return articleModel
    }
}
