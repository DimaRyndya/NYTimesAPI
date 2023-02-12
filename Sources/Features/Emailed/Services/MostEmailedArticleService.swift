import UIKit
import Alamofire

class MostEmailedArticleService {

    private let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json"
    private let parameters: Parameters = ["api-key" : "i4T2FJirMgYdE6aDvr5oBugtyBtqJff0"]
    
    func fetchArticles(completion: @escaping ([ArticleModel]) -> ()) {
        AF.request(baseURL, parameters: parameters).responseDecodable(of: ArticleRequestResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.articles)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }

}
