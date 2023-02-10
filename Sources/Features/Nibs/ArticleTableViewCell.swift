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
    }
    
    @IBAction func toggleFavouriteState(_ sender: UIButton) {
        delegate?.toggleFavouriteState(for: article!)
        article?.isFavourite.toggle()
        reloadData?()
    }
}
