import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let mostEmailedNavigationController = UIStoryboard(name: "MostEmailed", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let mostEmailedVC = mostEmailedNavigationController?.viewControllers.first as? MostEmailedTableViewController
        let cacheService = CacheService()
        let mostEmailedViewModel = MostEmailedViewModel(cacheService: cacheService)
        mostEmailedVC?.viewModel = mostEmailedViewModel

        let mostSharedVC = UIStoryboard(name: "MostShared", bundle: nil).instantiateInitialViewController()
        let mostViewedVC = UIStoryboard(name: "MostViewed", bundle: nil).instantiateInitialViewController()

        let favouriteArticlesNavigationController = UIStoryboard(name: "FavouriteArticles", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let favouriteArticlesVC = favouriteArticlesNavigationController?.viewControllers.first as? FavouritesTableViewController

        let favouriteArticleViewModel = FavouriteArticlesViewModel(cacheService: cacheService)
        favouriteArticlesVC?.viewModel = favouriteArticleViewModel

        favouriteArticlesVC?.viewModel.cacheService.managedObjectContext = managedObjectContext
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([mostEmailedNavigationController ?? UIViewController(), mostSharedVC ?? UIViewController(), mostViewedVC ?? UIViewController(), favouriteArticlesNavigationController ?? UIViewController()], animated: false)
        if let mostEmailedItem = tabBarVC.tabBar.items?[0] {
            mostEmailedItem.title = "Most Emailed"
            mostEmailedItem.image = UIImage(systemName: "envelope.circle")
            mostEmailedItem.selectedImage = UIImage(systemName: "envelope.circle.fill")
        }
        if let mostSharedItem = tabBarVC.tabBar.items?[1] {
            mostSharedItem.title = "Most Shared"
            mostSharedItem.image = UIImage(systemName: "rectangle.stack.badge.person.crop")
            mostSharedItem.selectedImage = UIImage(systemName: "rectangle.stack.badge.person.crop.fill")
        }
        if let mostViewedItem = tabBarVC.tabBar.items?[2] {
            mostViewedItem.title = "Most Viewed"
            mostViewedItem.image = UIImage(systemName: "eye")
            mostViewedItem.selectedImage = UIImage(systemName: "eye.fill")
        }
        if let mostViewedItem = tabBarVC.tabBar.items?[3] {
            mostViewedItem.title = "Favourites"
            mostViewedItem.image = UIImage(systemName: "star")
            mostViewedItem.selectedImage = UIImage(systemName: "star.fill")
        }

        window.rootViewController = tabBarVC
        self.window = window
        window.makeKeyAndVisible()
    }

    // MARK: - Core Data stack

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


    func sceneDidEnterBackground(_ scene: UIScene) {
        saveContext()
    }
}
