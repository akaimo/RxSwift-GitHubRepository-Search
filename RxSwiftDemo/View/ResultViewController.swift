//
//  ResultViewController.swift
//  RxSwiftDemo
//
//  Created by Shuhei Kawaguchi on 2016/04/02.
//  Copyright © 2016年 Shuhei Kawaguchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ResultViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ResultViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.repository
            .asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell")) {  _, repository, cell in
                cell.textLabel?.text = repository.fullName
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
