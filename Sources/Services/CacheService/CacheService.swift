import Foundation
import CoreData

final class CacheService {
    
//MARK: - Core Data Stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NYTimesAPI")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedObjectContext = persistentContainer.viewContext

    //MARK: - Properties
    
    private let fetchRequest = NSFetchRequest<PersistedArticleModel>(entityName: PersistedArticleModel.entityName)
    
    //MARK: - Public
    
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
            assertionFailure("Error: \(error)")
        }
    }
    
    func getArticles() -> [ArticleModel] {
        var persistentArticles: [PersistedArticleModel] = []
        do {
            persistentArticles = try managedObjectContext.fetch(fetchRequest)
        } catch {
            assertionFailure("Error: \(error)")
        }
        
        let articleModel = persistentArticles.map { ArticleModel(article: $0) }
        return articleModel
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
