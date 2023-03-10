import Foundation
import CoreData

@objc(PersistedArticleModel)
public class PersistedArticleModel: NSManagedObject {
    static let entityName = "PersistedArticleModel"
}

//MARK: PersistedArticle Model

extension PersistedArticleModel: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistedArticleModel> {
        return NSFetchRequest<PersistedArticleModel>(entityName: PersistedArticleModel.entityName)
    }

    @NSManaged public var articleAuthor: String?
    @NSManaged public var articleText: String?
    @NSManaged public var articleTitle: String?
    @NSManaged public var articleURL: String?
    @NSManaged public var id: Int64
    @NSManaged public var isFavourite: Bool

}

