import Foundation
import CoreData

class CacheService {

    var managedObjectContext: NSManagedObjectContext!
    let fetchRequest = NSFetchRequest<PersistedArticleModel>(entityName: "PersistedArticleModel")

    func removeArticle(with id: Int) {
        do {
            var articles = try managedObjectContext.fetch(fetchRequest)
            if let index = articles.firstIndex(where: {$0.id == id}) {
                let object = articles.remove(at: index)
                managedObjectContext.delete(object)
                do {
                    try managedObjectContext.save()
                } catch {
                    fatalError("Error: \(error)")
                }
            }
        } catch {
            fatalError("Error: \(error)")
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

    func getArticles() -> [ArticleModel] {
        var persistentArticles: [PersistedArticleModel] = []
        do {
            persistentArticles = try managedObjectContext.fetch(fetchRequest)
        } catch {
            fatalError("Error: \(error)")
        }

        let articleModel = persistentArticles.map {
            ArticleModel(article: $0)
        }
        return articleModel
    }
}
