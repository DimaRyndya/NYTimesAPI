import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let cacheService = CacheService()
        
        //MARK: - Set up MostEmailedScreen
        
        let articlesNavigationController = UIStoryboard(name: "Articles", bundle: nil).instantiateInitialViewController() as? UINavigationController
        
        let mostEmailedVC = articlesNavigationController?.viewControllers.first as? ArticlesTableViewController
        let mostEmailedURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json"
        let mostEmailedNetworkService = ArticlesNetworkService(url: mostEmailedURL)
        let mostEmailedViewModel = ArticlesViewModel(cacheService: cacheService, networkService: mostEmailedNetworkService)
        
        mostEmailedVC?.viewModel = mostEmailedViewModel
        
        //MARK: - Set up MostSharedScreen
        
        let mostSharedNavigationController = UIStoryboard(name: "Articles", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let mostSharedVC = mostSharedNavigationController?.viewControllers.first as? ArticlesTableViewController
        let mostSharedURL = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json"
        let mostSharedNetworkService = ArticlesNetworkService(url: mostSharedURL)
        let mostSharedViewModel = ArticlesViewModel(cacheService: cacheService, networkService: mostSharedNetworkService)
        
        mostSharedVC?.viewModel = mostSharedViewModel
        
        //MARK: - Set up MostViewedScreen
        
        let mostViewedNavigationController = UIStoryboard(name: "Articles", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let mostViewedVC = mostViewedNavigationController?.viewControllers.first as? ArticlesTableViewController
        let mostViewedURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json"
        let mostViewedNetworkService = ArticlesNetworkService(url: mostViewedURL)
        let mostViewedViewModel = ArticlesViewModel(cacheService: cacheService, networkService: mostViewedNetworkService)
        
        mostViewedVC?.viewModel = mostViewedViewModel
        
        //MARK: - Set up FavouritesScreen
        
        let favouriteArticlesNavigationController = UIStoryboard(name: "FavouriteArticles", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let favouriteArticlesVC = favouriteArticlesNavigationController?.viewControllers.first as? FavouritesTableViewController
        
        let favouriteArticleViewModel = FavouriteArticlesViewModel(cacheService: cacheService)
        favouriteArticlesVC?.viewModel = favouriteArticleViewModel
        
        favouriteArticlesVC?.viewModel.cacheService.managedObjectContext = managedObjectContext
        
        //MARK: - Set up TabBar
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([articlesNavigationController ?? UIViewController(), mostSharedNavigationController ?? UIViewController(), mostViewedNavigationController ?? UIViewController(), favouriteArticlesNavigationController ?? UIViewController()], animated: false)
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
