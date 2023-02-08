import UIKit

class MostEmailedDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var articleURLLabel: UILabel!

    let viewModel = MostEmailedDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.articleTitle
        descriptionLabel.text = viewModel.articleText
        authorLabel.text = viewModel.articleAuthor
        articleURLLabel.text = viewModel.articleURL
    }
}
