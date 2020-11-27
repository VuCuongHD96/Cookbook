
import Foundation
import ObjectMapper

final class CategoryResponse : Mappable {
    var categories = [Category]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        categories <- map["categories"]
    }
}
