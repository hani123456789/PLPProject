//
//  ProductListViewModelTest.swift
//  PLPTests
//
//  Created by HaniMac on 04/08/2022.
//

import XCTest
@testable import PLP

class ProductListViewModelTest: XCTestCase {
    
    var sut: ProductListViewModel!
    var productServiceMock: ProductServiceMock!

    override func setUp() {
        super.setUp()
        productServiceMock = ProductServiceMock()
        sut = ProductListViewModel(productsServices: productServiceMock)
    }

    override func tearDown() {
        sut = nil
        productServiceMock = nil
        super.tearDown()
    }
    
    func testInitFetch() {
        sut.getProducts()
        // THEN
        XCTAssert(productServiceMock.fetchProductCalled)
    }
}

