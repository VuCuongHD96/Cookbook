//
//  SectionDataMealDetail.swift
//  CookBook
//
//  Created by KIMOCHI on 11/29/20.
//  Copyright © 2020 Vu Xuan Cuong. All rights reserved.
//

import RxDataSources

struct SectionDataMealDetail {
    var header: String
    var items: [Item]
}

extension SectionDataMealDetail: SectionModelType {
    typealias Item = String
    
    init(original: SectionDataMealDetail, items: [Item]) {
        self = original
        self.items = items
    }
}
