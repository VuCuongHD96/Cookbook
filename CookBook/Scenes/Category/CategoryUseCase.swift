//
//  CategoryUseCase.swift
//  CookBook
//
//  Created by Vu Xuan Cuong on 10/26/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CategoryUseCaseType {
    func getCategories() -> Observable<[Category]>
}

struct CategoryUseCase: CategoryUseCaseType {
    
    func getCategories() -> Observable<[Category]> {
        let request = CategoryRequest()
        let repository = CategoryRepository()
        return repository.getCategories(input: request)
    }
}
