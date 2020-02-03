//
//  ViewController.swift
//  UIIndexBar
//
//  Created by League2EB on 02/03/2020.
//  Copyright (c) 2020 League2EB. All rights reserved.
//

import UIKit
import UIIndexBar

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataSeq: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "幹", "你", "娘", "糙", "雞", "掰"]

    var indexBar = UIIndexBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        indexBar = UIIndexBar(frame: CGRect(x: view.frame.size.width - 30, y: 0, width: 30, height: view.frame.size.height))
        indexBar.delegate = self
        indexBar.contentBarStyle.textColor = .brown
        self.tableView.reloadData()
        self.view.addSubview(indexBar)
        self.indexBar.setIndexes(indexes: dataSeq)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSeq[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSeq.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.indexBar.isTouch {
            return
        }
        guard let indexPath = tableView.indexPathForRow(at: scrollView.contentOffset) else { return }
        self.indexBar.setSelectedLabel(index: indexPath.section)
    }
}

extension ViewController: UIIndexBarDelegate {

    func indexDidChened(indexBar: UIIndexBar, index: Int, title: String) {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: false)
    }
}
