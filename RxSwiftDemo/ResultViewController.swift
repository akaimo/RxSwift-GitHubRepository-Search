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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
