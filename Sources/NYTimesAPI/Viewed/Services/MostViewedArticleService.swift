import UIKit
import Alamofire

class MostViewedArticleService {
    let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json"

    let parameters: Parameters = ["api-key" : "i4T2FJirMgYdE6aDvr5oBugtyBtqJff0"]

    func fetchArticles(completion: @escaping ([MostViewedArticleModel]) -> ()) {
        AF.request(baseURL, parameters: parameters).responseDecodable(of: MostViewedArticleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.mostViewedArticles)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
