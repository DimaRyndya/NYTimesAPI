import UIKit

class MostEmailedTableViewController: UITableViewController, MostEmailedViewModelDelegate {

    @IBOutlet weak var titleArticleLabel: UILabel!

    var viewModel: MostEmailedViewModel!

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

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.state {
        case .loading:
            return 1
        case .foundArticles:
            return viewModel.mostEmailedArticles.count
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
            let article = viewModel.mostEmailedArticles[indexPath.row]
            cell.delegate = viewModel
            cell.configure(with: article)
            cell.reloadData = { [weak self] in
                self?.tableView.reloadData()
            }

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MostEmailedDetail") as? MostEmailedDetailViewController
        let article = viewModel.mostEmailedArticles[indexPath.row]
        detailVC?.viewModel.configure(with: article)
        self.navigationController?.pushViewController(detailVC ?? UIViewController(), animated: true)
    }
}
