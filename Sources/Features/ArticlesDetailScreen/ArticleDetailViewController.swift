import UIKit

final class ArticleDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    var viewModel =  ArticleDetailViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Article Detail"
        titleLabel.text = viewModel.articleTitle
        descriptionLabel.text = viewModel.articleDescripton
        authorLabel.text = viewModel.articleAuthor
        linkButton.setTitle("Read more", for: .normal)
    }
    
    //MARK: - IBActions
    
    @IBAction func didOpenLink(_ sender: Any) {
        if let url = URL(string: viewModel.articleURL) {
            UIApplication.shared.open(url)
        }
    }
}


