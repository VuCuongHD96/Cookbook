
import Foundation
import ObjectMapper
import RxSwift

protocol CategoryRepositoryType {
    func getCategories(input: CategoryRequest) -> Observable<[Category]>
}

class CategoryRepository: CategoryRepositoryType {
    private let api: APIService = APIService.share
    
    func getCategories(input: CategoryRequest) -> Observable<[Category]> {
        return api.request(input: input)
            .map { (response: CategoryResponse) -> [Category] in
                return response.categories
            }
    }
}
