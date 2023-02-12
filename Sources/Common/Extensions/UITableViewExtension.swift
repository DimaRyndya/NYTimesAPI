import UIKit

extension UITableViewController {
    func pushDetailScreen(with article: ArticleModel) {
        let storyboard = UIStoryboard(name: "Articles", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ArticleDetail") as? ArticleDetailViewController
        detailVC?.viewModel.configure(with: article)
        self.navigationController?.pushViewController(detailVC ?? UIViewController(), animated: true)
    }
}
