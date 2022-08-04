//
//  ProductsService.swift
//  PLP
//
//  Created by HaniMac on 02/08/2022.
//
import Foundation

class ProductService: ProductsServiceProtocol {
    
    private let baseURL = "https://sephoraios.github.io/items.json"
    
    func getProductList(onCompletion: @escaping ([Product]) -> ()) {
        let request = NSMutableURLRequest(url: NSURL(string: baseURL)! as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    do {
                        let products = try decoder.decode([Product].self, from: data!)
                        onCompletion(products.sorted (by:{ $0.is_special_brand! && !$1.is_special_brand! }))
                    } catch {
                        onCompletion([])
                    }
                } else {
                    onCompletion([])
                }
        })
        task.resume()
    }
    
}
