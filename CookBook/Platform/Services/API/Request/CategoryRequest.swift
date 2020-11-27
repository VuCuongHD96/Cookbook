
import Foundation
import ObjectMapper
import Alamofire

final class CategoryRequest: BaseRequest {
    
    required init() {
        let body: [String: Any]  = [:]
        super.init(url: URLs.categories, requestType: .get, body: body)
    }
}
