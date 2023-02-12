import UIKit

protocol ArticleTableViewCellDelegate: AnyObject {
    func toggleFavouriteState(for article: ArticleModel)
}

class ArticleTableViewCell: UITableViewCell {

    //MARK: Outlets

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    /// Cell must be configured with article
    private var article: ArticleModel!

    weak var delegate: ArticleTableViewCellDelegate?

    //MARK: Public

    func configure(with article: ArticleModel) {
        self.article = article
        articleTitleLabel.text = article.title
        articleTextLabel.text = article.description

        let imageName = article.isFavourite ? "star.fill" : "star"
        favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    //MARK: Outlet functions
    
    @IBAction func toggleFavouriteState(_ sender: UIButton) {
        article?.isFavourite.toggle()
        delegate?.toggleFavouriteState(for: article)
    }
}
