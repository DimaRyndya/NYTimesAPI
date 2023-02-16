import UIKit

private enum TitleConstants {
    static let articleDetail = "Article Detail"
    static let button = "Read more"
}

final class ArticleDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!


    //MARK: - Properties
    
    var viewModel =  ArticleDetailViewModel()

    static let identifier = "ArticleDetail"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = TitleConstants.articleDetail

        titleLabel.text = viewModel.articleTitle
        descriptionLabel.text = viewModel.articleDescripton
        authorLabel.text = viewModel.articleAuthor
        linkButton.setTitle(TitleConstants.button, for: .normal)
    }
    
    //MARK: - IBActions
    
    @IBAction func didOpenLink(_ sender: Any) {
        if let url = URL(string: viewModel.articleURL) {
            UIApplication.shared.open(url)
        }
    }
}


