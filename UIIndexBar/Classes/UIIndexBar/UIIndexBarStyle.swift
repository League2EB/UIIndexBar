//
//  UIIndexBarStyle.swift
//  UIIndexBar
//
//  Created by Lazy on 2020/2/3.
//

import Foundation
import UIKit

public class UIIndexBarStyle {

    /// 文字顏色
    public var textColor: UIColor
    /// 選擇文字顏色
    public var selectedTextColor: UIColor
    /// 選擇背景顏色
    public var selectedBackgroundColor: UIColor
    /// 外框氣泡背景顏色
    public var detailViewDrawColor: UIColor
    /// 外框氣泡文字顏色
    public var detailViewTextColor: UIColor

    public init(textColor: UIColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.7411764706, alpha: 0.6236795775), selectedTextColor: UIColor = .white, selectedBackgroundColor: UIColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.7411764706, alpha: 0.6236795775), detailViewDrawColor: UIColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.7411764706, alpha: 0.6236795775), detailViewTextColor: UIColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 0.7411764706, alpha: 0.6236795775)) {
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.detailViewDrawColor = detailViewDrawColor
        self.detailViewTextColor = detailViewTextColor
    }
}
