import UIKit

final class FavouritesTableViewController: UITableViewController {
    
    var viewModel: FavouriteArticlesViewModel!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmptyCell")
        nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleCell")
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.articlesIsUpdated()
    }
}

//MARK: - FavouriteArticles ViewModel Deleagte

extension FavouritesTableViewController: FavouriteArticlesViewModelDeleagte {
    
    func reloadUI() {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath)
            tableView.separatorStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
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
