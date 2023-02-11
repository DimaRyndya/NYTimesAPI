import UIKit

protocol ArticleTableViewCellDelegate: AnyObject {
    func toggleFavouriteState(for article: ArticleModel)
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    private var article: ArticleModel?

    weak var delegate: ArticleTableViewCellDelegate?

    var reloadData: EmptyClosure?

    func configure(with article: ArticleModel) {
        self.article = article
        articleTitleLabel.text = article.articleTitle
        articleTextLabel.text = article.articleText
        if article.isFavourite {
            favouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    @IBAction func toggleFavouriteState(_ sender: UIButton) {
        article?.isFavourite.toggle()
        delegate?.toggleFavouriteState(for: article!)
        reloadData?()
    }
}
