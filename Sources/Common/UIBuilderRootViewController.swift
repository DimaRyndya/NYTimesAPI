import UIKit

final class UIBuilderRootViewController {

    //MARK: Public
    
    func buildRootViewController(cacheService: CacheService) -> UITabBarController {
        
        //MARK: - Set up MostEmailedScreen

        let mostEmailedNavigationController = UIStoryboard(name: ArticlesTableViewController.storybordIdentifier, bundle: nil).instantiateInitialViewController() as? UINavigationController
        let mostEmailedVC = mostEmailedNavigationController?.viewControllers.first as? ArticlesTableViewController

        let mostEmailedURL = "/svc/mostpopular/v2/emailed/30.json"
        let mostEmailedNetworkService = ArticlesNetworkService(requestURL: mostEmailedURL)
        let mostEmailedViewModel = ArticlesViewModel(cacheService: cacheService, networkService: mostEmailedNetworkService)

        mostEmailedVC?.title = "Most Emailed Articles"
        mostEmailedVC?.viewModel = mostEmailedViewModel

        //MARK: - Set up MostSharedScreen

        let mostSharedNavigationController = UIStoryboard(name: ArticlesTableViewController.storybordIdentifier, bundle: nil).instantiateInitialViewController() as? UINavigationController
        let mostSharedVC = mostSharedNavigationController?.viewControllers.first as? ArticlesTableViewController
        let mostSharedURL = "/svc/mostpopular/v2/shared/30/facebook.json"
        let mostSharedNetworkService = ArticlesNetworkService(requestURL: mostSharedURL)
        let mostSharedViewModel = ArticlesViewModel(cacheService: cacheService, networkService: mostSharedNetworkService)

        mostSharedVC?.title = "Most Shared Articles"
        mostSharedVC?.viewModel = mostSharedViewModel

        //MARK: - Set up MostViewedScreen

        let mostViewedNavigationController = UIStoryboard(name: ArticlesTableViewController.storybordIdentifier, bundle: nil).instantiateInitialViewController() as? UINavigationController
        let mostViewedVC = mostViewedNavigationController?.viewControllers.first as? ArticlesTableViewController
        let mostViewedURL = "/svc/mostpopular/v2/viewed/30.json"
        let mostViewedNetworkService = ArticlesNetworkService(requestURL: mostViewedURL)
        let mostViewedViewModel = ArticlesViewModel(cacheService: cacheService, networkService: mostViewedNetworkService)

        mostViewedVC?.title = "Most Viewed Articles"
        mostViewedVC?.viewModel = mostViewedViewModel

        //MARK: - Set up FavouritesScreen

        let favouriteArticlesNavigationController = UIStoryboard(name: FavouritesTableViewController.storybordIdentifier, bundle: nil).instantiateInitialViewController() as? UINavigationController
        let favouriteArticlesVC = favouriteArticlesNavigationController?.viewControllers.first as? FavouritesTableViewController
        let favouriteArticleViewModel = FavouriteArticlesViewModel(cacheService: cacheService)

        favouriteArticlesVC?.viewModel = favouriteArticleViewModel

        //MARK: - Set up TabBar

        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([mostEmailedNavigationController ?? UIViewController(), mostSharedNavigationController ?? UIViewController(), mostViewedNavigationController ?? UIViewController(), favouriteArticlesNavigationController ?? UIViewController()], animated: false)

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
        
        return tabBarVC
    }
}
