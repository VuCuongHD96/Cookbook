
import Foundation
import ObjectMapper

struct Category {
    var id: String
    var name: String
    var imageString: String
    var description: String
}

extension Category {
    init() {
        self.init(
            id: "",
            name: "",
            imageString: "",
            description: ""
        )
    }
}

extension Category: Hashable {
    
}

extension Category: BaseModel {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["idCategory"]
        name <- map["strCategory"]
        imageString <- map["strCategoryThumb"]
        description <- map["strCategoryDescription"]
    }
}
