//
//  ViewController.swift
//  test_snapkit
//
//  Created by Aka on 2018/5/30.
//  Copyright © 2018年 Aka. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(box)
        box.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
        box.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

