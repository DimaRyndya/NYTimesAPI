import UIKit
import Alamofire

class ArticlesNetworkService {

    private let baseURL: String
    private let parameters: Parameters = ["api-key" : "i4T2FJirMgYdE6aDvr5oBugtyBtqJff0"]

    init(url: String) {
        self.baseURL = url
    }

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
