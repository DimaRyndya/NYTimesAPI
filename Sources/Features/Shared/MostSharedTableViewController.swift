import UIKit

final class MostSharedTableViewController: UITableViewController, MostSharedViewModelDelegate {

    let viewModel = MostSharedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleCell")
        nib = UINib(nibName: "LoadingTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LoadingCell")

        viewModel.delegate = self
        viewModel.loadArticles()
        viewModel.state = .loading
    }

    func reloadUI() {
        viewModel.state = .foundArticles
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .loading:
            return 1
        case .foundArticles:
            return viewModel.mostSharedArticles.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.state {
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            tableView.separatorStyle = .none

            return cell
        case .foundArticles:
            tableView.separatorStyle = .singleLine
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
            let article = viewModel.mostSharedArticles[indexPath.row]
            cell.configure(with: article)

            if article.isFavourite {
                cell.favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                cell.favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            }

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artile = viewModel.mostSharedArticles[indexPath.row]
        pushDetailScreen(with: artile)
    }
}
