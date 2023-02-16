import UIKit

extension UITableViewController {
    
    func pushDetailScreen(with article: ArticleModel) {
        let storyboard = UIStoryboard(name: ArticlesTableViewController.storybordIdentifier, bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: ArticleDetailViewController.identifier) as? ArticleDetailViewController
        detailVC?.viewModel.configure(with: article)
        self.navigationController?.pushViewController(detailVC ?? UIViewController(), animated: true)
    }
}
