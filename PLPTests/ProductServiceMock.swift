//
//  ProductServiceMock.swift
//  PLPTests
//
//  Created by HaniMac on 04/08/2022.
//

import Foundation
@testable import PLP

class ProductServiceMock: ProductsServiceProtocol {
    
    var fetchProductCalled = false
    
    func getProductList(onCompletion: @escaping ([Product]) -> ()) {
        fetchProductCalled = true
    }
}
