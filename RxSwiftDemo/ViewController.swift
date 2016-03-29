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

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

