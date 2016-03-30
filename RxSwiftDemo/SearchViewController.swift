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

class SearchViewController: UIViewController {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var validMessage: UILabel!
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    let minimumSize = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GitHub リポジトリ検索"
        
        let searchValid = searchTextField.rx_text
            .map { [weak self] in $0.characters.count >= self?.minimumSize }
            .shareReplay(1)
        
        searchValid
            .bindTo(validMessage.rx_hidden)
            .addDisposableTo(disposeBag)
        
        searchValid
            .bindTo(searchButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        searchButton.rx_tap
            .subscribeNext { print("tap") }
            .addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(animated: Bool) {
        viewModel.request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

