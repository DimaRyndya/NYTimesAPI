import UIKit

final class MostSharedTableViewController: UITableViewController {

    var viewModel: ArticlesViewModel!

    //MARK: Lifecycle

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

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension MostSharedTableViewController: ArticlesViewModelDelegate {

    //MARK: MostShared ViewModel Delegate

    func reloadUI() {
        viewModel.state = .foundArticles
        tableView.reloadData()
    }
}

extension MostSharedTableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .loading:
            return 1
        case .foundArticles:
            return viewModel.articles.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
            let article = viewModel.articles[indexPath.row]

            tableView.separatorStyle = .singleLine

            article.isFavourite = viewModel.articleIsTheSameAs(article: article)
            
            cell.delegate = viewModel
            cell.configure(with: article)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artile = viewModel.articles[indexPath.row]
        pushDetailScreen(with: artile)
    }
}
