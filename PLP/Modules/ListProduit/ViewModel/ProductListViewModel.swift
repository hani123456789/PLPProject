//
//  ProductListViewModel.swift
//  PLP
//
//  Created by HaniMac on 02/08/2022.
//
import RxSwift
import RxCocoa

class ProductListViewModel {
    
    var productsServices: ProductsServiceProtocol
    let data = BehaviorRelay<[Product]>(value: [])
    let isLoading = BehaviorSubject<Bool>(value: false)
    let didShowAlert = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    
    init(productsServices: ProductsServiceProtocol = ProductService()) {
        self.productsServices = productsServices
    }
    
    func getProducts() {
        isLoading.onNext(true)
        productsServices.getProductList(onCompletion: { (list) in
            if !list.isEmpty {
                self.isLoading.onNext(false)
                self.data.accept(list)
            } else {
                self.didShowAlert.onNext(true)
                self.isLoading.onNext(false)
            }
        })
    }
}
