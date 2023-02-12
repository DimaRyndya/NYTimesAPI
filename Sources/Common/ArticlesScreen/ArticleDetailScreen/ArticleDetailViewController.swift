import UIKit

final class ArticleDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    let viewModel = ArticleDetailViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = viewModel.articleTitle
        descriptionLabel.text = viewModel.articleDescripton
        authorLabel.text = viewModel.articleAuthor
        linkButton.setTitle("Read more", for: .normal)
    }
    
    //MARK: - IBAction
    
    @IBAction func didOpenLink(_ sender: Any) {
        if let url = URL(string: viewModel.articleURL) {
            UIApplication.shared.open(url)
        }
    }
}


