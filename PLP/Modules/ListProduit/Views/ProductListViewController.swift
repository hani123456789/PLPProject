//
//  ProductListViewController.swift
//  PLP
//
//  Created by HaniMac on 02/08/2022.
//

import UIKit
import RxSwift

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var productsTableView: UITableView!
    private let disposeBag = DisposeBag()
    var viewModel: ProductListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView.startAnimating()
        viewModel?.getProducts()
        setupNavigationBar()
        setUpTableView()
        setupBinding()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // setup title font color
        let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = titleAttribute
        navigationController?.navigationBar.topItem?.title = "Liste de produits"
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setUpTableView() {
        productsTableView.rowHeight = 220
        productsTableView.register(UINib.init(nibName: "ProductTableViewCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    private func setupBinding() {
        viewModel?.data.asObservable()
            .bind(to: productsTableView.rx.items(cellIdentifier: "ProductTableViewCell", cellType: ProductTableViewCell.self)) {
                row, product, cell in
                self.spinnerView.stopAnimating()
                cell.configureCell(product: product)
                //MARK: cell configuration
                
            }.disposed(by: disposeBag)
        
        viewModel?.isLoading
            .bind { [weak self] in
                $0 ? self?.startAnimation() : self?.stopAnimation()
            }
            .disposed(by: self.disposeBag)
        
        viewModel?.didShowAlert.asObservable()
            .bind(onNext: { [weak self] result in
                if result == true {
                    DispatchQueue.main.async {
                        self?.showAlertFailed()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func startAnimation() {
        spinnerView.isHidden = false
        spinnerView.startAnimating()
    }
    
    private func stopAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView.isHidden = true
            self?.spinnerView.stopAnimating()
        }
    }
    
    private func showAlertFailed() {
        let alert = UIAlertController(title: "Erreur", message: "Oups il y a une erreur ici. Nous n'avons pas réussi à récupérer vos produits. Pouvez-vous réessayer ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
