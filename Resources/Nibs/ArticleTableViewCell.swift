import UIKit

protocol ArticleTableViewCellDelegate: AnyObject {
    func toggleFavouriteState(_ cell: ArticleTableViewCell, for article: ArticleModel)
}

final class ArticleTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    /// Cell must be configured with article
    private var article: ArticleModel!

    static let nibName = "ArticleTableViewCell"
    static let identifier = "ArticleCell"
    
    weak var delegate: ArticleTableViewCellDelegate?
    
    //MARK: - Public
    
    func configure(with article: ArticleModel) {
        self.article = article
        articleTitleLabel.text = article.title
        articleTextLabel.text = article.description
        
        let imageName = article.isFavourite ? "star.fill" : "star"
        
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    //MARK: - Outlet functions
    
    @IBAction func toggleFavouriteState(_ sender: UIButton) {
        article?.isFavourite.toggle()
        delegate?.toggleFavouriteState(self, for: article)
    }
}
