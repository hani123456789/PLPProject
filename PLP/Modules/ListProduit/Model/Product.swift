//
//  Product.swift
//  PLP
//
//  Created by HaniMac on 02/08/2022.
//
struct Product:Codable {
    var product_name: String?
    var description: String?
    var price: Double?
    var is_special_brand: Bool?
    var images_url: ImagesURL?
}
