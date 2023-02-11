import UIKit

class FavouritesTableViewController: UITableViewController, FavouriteArticlesViewModelDeleagte {

    var viewModel: FavouriteArticlesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmptyCell")
        nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleCell")

        viewModel.delegate = self
    }

    func updateUI() {
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.articlesIsUpdated()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.favouriteArticles.isEmpty {
            return 1
        } else {
            return viewModel.favouriteArticles.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if viewModel.favouriteArticles.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            tableView.separatorStyle = .none

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
            tableView.separatorStyle = .singleLine
            let article = viewModel.favouriteArticles[indexPath.row]
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
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "FavouriteArticlesDetail") as? FavouriteArticlesDetailViewController
        let article = viewModel.favouriteArticles[indexPath.row]
        detailVC?.viewModel.configure(with: article)
        self.navigationController?.pushViewController(detailVC ?? UIViewController(), animated: true)
    }
}
