import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleTextLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    private var article: MostEmailedArticleModel?

    var reloadData: EmptyClosure?

    func configure(with article: MostEmailedArticleModel) {
        self.article = article
        articleTitleLabel.text = article.articleTitle
        articleTextLabel.text = article.articleText
    }
    
    @IBAction func toggleFavouriteState(_ sender: UIButton) {
        article?.isFavourite.toggle()
        reloadData?()
    }
}
