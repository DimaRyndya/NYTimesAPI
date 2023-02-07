import UIKit
import Alamofire

class MostEmailedArticleService {

    let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json"
    let parameters: Parameters = ["api-key" : "i4T2FJirMgYdE6aDvr5oBugtyBtqJff0"]
    
    func fetchArticles(completion: @escaping ([MostEmailedArticleModel]) -> ()) {
        AF.request(baseURL, parameters: parameters).responseDecodable(of: MostEmailedArticleResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.mostEmailedArticles)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }

}
