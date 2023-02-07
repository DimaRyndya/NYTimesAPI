import UIKit
import Alamofire

class MostSharedArticleService {
    let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json"
    let parameters: Parameters = ["api-key" : "i4T2FJirMgYdE6aDvr5oBugtyBtqJff0"]

    func fetchArticles(completion: @escaping ([MostSharedArticleModel]) -> ()) {
        AF.request(baseURL, parameters: parameters).responseDecodable(of: MostSharedArticleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.mostSharedArticles)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
