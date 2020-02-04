# UIIndexBar

[![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen)]()
[![Swift 5](https://img.shields.io/badge/Swift-5.0-F05138)](https://swift.org/)

#### Index
* [安裝](#installation)
* [範例](#example)
* [需求](#requirements)

## Preview

![](https://s5.gifyu.com/images/Democd2e6fae575d6eda.gif)

## Installation

```ruby
  pod 'UIIndexBar'
```

## Example

ViewController
```swift
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataSeq: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "不", "要", "這", "樣", "搞"]

    /// 宣告UIIndexBar
    var indexBar = UIIndexBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 設定CGRect
        indexBar = UIIndexBar(frame: CGRect(x: view.frame.size.width - 30, y: 0, width: 30, height: view.frame.size.height))
        /// 代理指向
        indexBar.delegate = self
        /// 風格設定
        indexBar.contentBarStyle.textColor = .brown
        /// 加入UIIndexBar到畫面中
        self.view.addSubview(indexBar)
        /// 設定UIIndexBar內容
        self.indexBar.setIndexes(indexes: dataSeq)
    }
}
```

Extension
```swift
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
        /// 如果indexBar正在被點擊，直接Return
        if self.indexBar.isTouch {
            return
        }
        guard let indexPath = tableView.indexPathForRow(at: scrollView.contentOffset) else { return }
        /// 已捲動時馬上設定該選擇狀態的indexBar
        self.indexBar.setSelectedLabel(index: indexPath.section)
    }
}
```

```swift
extension ViewController: UIIndexBarDelegate {

    func indexDidChened(indexBar: UIIndexBar, index: Int, title: String) {
        /// 選動到指定索引
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: false)
    }
}
```

## Requirements
- iOS 10.0
- Portrait


## Author

Lazy, poloa51404@gmail.com

## License

UIIndexBar is available under the MIT license. See the LICENSE file for more info.
