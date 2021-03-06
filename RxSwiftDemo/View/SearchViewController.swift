//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/03/13.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class SearchViewController: UIViewController {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var validMessage: UILabel!
    
    var viewModel: SearchViewModel!
    let disposeBag = DisposeBag()
    let minimumSize = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GitHub リポジトリ検索"
        
        viewModel = SearchViewModel(
            search: searchTextField.rx_text.asObservable(),
            buttonTap: searchButton.rx_tap.asObservable(),
            keyboardReturn: searchTextField.rx_controlEvent(.EditingDidEndOnExit).asObservable()
        )
        
        searchTextField.rx_text
            .bindTo(viewModel.searchText)
            .addDisposableTo(disposeBag)
        
        viewModel.validation
            .bindTo(validMessage.rx_hidden)
            .addDisposableTo(disposeBag)
        
        viewModel.validation
            .bindTo(searchButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        viewModel.response
            .subscribeNext { [weak self] response in
                MBProgressHUD.hideHUDForView(self?.view, animated: true)
                self?.view.endEditing(true)
                
                let vc = self?.storyboard?.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
                vc.title = self?.searchTextField.text
                vc.viewModel.repository.value = response.repository
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.request
            .subscribeNext { [weak self] _ in
                MBProgressHUD.showHUDAddedTo(self?.view, animated: true)
            }
            .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

