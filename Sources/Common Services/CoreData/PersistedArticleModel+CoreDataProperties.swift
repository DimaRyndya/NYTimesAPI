import Foundation
import CoreData


extension PersistedArticleModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistedArticleModel> {
        return NSFetchRequest<PersistedArticleModel>(entityName: "PersistedArticleModel")
    }

    @NSManaged public var articleAuthor: String?
    @NSManaged public var articleText: String?
    @NSManaged public var articleTitle: String?
    @NSManaged public var articleURL: String?
    @NSManaged public var id: Int64
    @NSManaged public var isFavourite: Bool

}

extension PersistedArticleModel : Identifiable {

}
