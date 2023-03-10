import UIKit

// MARK: - Helper Types

private enum EmptyCellConstants {
    static let nibName = "EmptyTableViewCell"
    static let identifier = "EmptyCell"
}

final class FavouritesTableViewController: UITableViewController {
    
    var viewModel: FavouriteArticlesViewModel!

    static let storybordIdentifier = "FavouriteArticlesStoryboard"
    static let tableViewRowHeight = 44.0
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: EmptyCellConstants.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: EmptyCellConstants.identifier)
        nib = UINib(nibName: ArticleTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = FavouritesTableViewController.tableViewRowHeight
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.articlesIsUpdated()
    }
}

//MARK: - FavouriteArticles ViewModel Deleagte

extension FavouritesTableViewController: FavouriteArticlesViewModelDeleagte {
    
    func reloadUI(_ viewModel: FavouriteArticlesViewModel) {
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension FavouritesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.favouriteArticles.isEmpty {
            return 1
        } else {
            return viewModel.favouriteArticles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.favouriteArticles.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCellConstants.identifier, for: indexPath)

            tableView.separatorStyle = .none
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as! ArticleTableViewCell
            let article = viewModel.favouriteArticles[indexPath.row]
            
            tableView.separatorStyle = .singleLine
            
            cell.delegate = viewModel
            cell.configure(with: article)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = viewModel.favouriteArticles[indexPath.row]
        pushDetailScreen(with: article)
    }
}
