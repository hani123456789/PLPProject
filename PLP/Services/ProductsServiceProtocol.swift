//
//  ProductsServiceProtocol.swift
//  PLP
//
//  Created by HaniMac on 02/08/2022.
//
protocol ProductsServiceProtocol {
    func getProductList(onCompletion:@escaping([Product])->())
}
