//
//  UIIndexBar.swift
//  UIIndexBar
//
//  Created by Lazy on 2020/2/3.
//

import Foundation
import UIKit

public protocol UIIndexBarDelegate: class {
    /// 索引已經更換
    /// - Parameters:
    ///   - indexBar: 哪一個Bar
    ///   - index: 索引值
    ///   - title: 文字
    func indexDidChened(indexBar: UIIndexBar, index: Int, title: String)
}

public class UIIndexBar: UIView {

    /// 風格
    public var contentBarStyle = UIIndexBarStyle()
    /// 事件代理
    public weak var delegate: UIIndexBarDelegate?
    /// 是否點擊
    public var isTouch: Bool = false

    private var isHideDetailView: Bool = false
    private var sectionHeight: CGFloat = 0.0
    private var preLabel: UILabel?
    private var preIndex = 0
    private var labelArr: [UILabel] = []
    private var indexDetailView: CustomView?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initData()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initData()
    }

    public func setIndexes(indexes: [String]) {
        self.labelArr.removeAll()
        self.preIndex = -1
        self.addCustomView()
        self.recalculateHeight(indexes: indexes)
        self.addLabels(indexes: indexes)

        if indexes.count > 0 {
            self.setSelectedLabel(index: 0)
        }
    }

    public func setSelectedLabel(index: Int) {
        self.preLabel?.backgroundColor = .clear
        self.preLabel?.textColor = self.contentBarStyle.textColor
        let label = self.labelArr[index]
        label.textColor = self.contentBarStyle.selectedTextColor
        label.backgroundColor = self.contentBarStyle.selectedBackgroundColor
        self.preLabel = label
    }

    private func addCustomView() {
        self.indexDetailView = CustomView(frame: CGRect(x: -80, y: 0, width: 50, height: 50))
        self.indexDetailView?.backgroundColor = .clear
        self.indexDetailView?.drawColor = self.contentBarStyle.detailViewDrawColor
        self.indexDetailView?.textColor = self.contentBarStyle.detailViewTextColor
        self.indexDetailView?.alpha = 0
        guard let subView = self.indexDetailView else { return }
        self.addSubview(subView)
    }

    private func recalculateHeight(indexes: [String]) {
        var rect = frame
        rect.size.height = CGFloat(indexes.count) * sectionHeight
        rect.origin.y = (UIScreen.main.bounds.height - rect.size.height) * 0.5
        self.frame = rect
    }

    private func addLabels(indexes: [String]) {
        let width = sectionHeight
        let height = sectionHeight
        let x = (self.bounds.size.width - width) * 0.5

        for (index, item) in indexes.enumerated() {
            let y = (self.sectionHeight * CGFloat(index))
            let alphaLabel = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
            alphaLabel.textAlignment = .center
            alphaLabel.text = item.uppercased()
            alphaLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
            alphaLabel.backgroundColor = UIColor.clear
            alphaLabel.textColor = self.contentBarStyle.textColor
            alphaLabel.layer.cornerRadius = width * 0.5
            alphaLabel.clipsToBounds = true
            self.addSubview(alphaLabel)
            self.labelArr.append(alphaLabel)
        }
    }

    private func initData() {
        self.preIndex = -1
        self.sectionHeight = 16.0
    }

    private func toSelectTitle(touchPoint: CGPoint) {
        if (touchPoint.x <= 0 || touchPoint.y <= 0 || touchPoint.x >= self.bounds.size.width || touchPoint.y >= self.bounds.size.height) {
            return
        }

        var title: String = ""
        var index = 0

        for (idx, item) in self.labelArr.enumerated() {
            if touchPoint.y < item.frame.maxY {
                self.preLabel?.backgroundColor = .clear
                self.preLabel?.textColor = self.contentBarStyle.textColor
                item.backgroundColor = self.contentBarStyle.selectedBackgroundColor
                item.textColor = self.contentBarStyle.selectedTextColor
                self.preLabel = item
                index = idx
                title = item.text ?? ""
                break
            }
        }

        if self.preIndex == index {
            return
        }

        self.preIndex = index

        self.indexDetailView?.center = CGPoint(x: self.indexDetailView?.center.x ?? 0, y: self.sectionHeight * 0.5 + CGFloat(index) * sectionHeight)

        self.indexDetailView?.indexLabel?.text = title

        let gen = UIImpactFeedbackGenerator(style: .light)
        gen.prepare()
        gen.impactOccurred()

        self.delegate?.indexDidChened(indexBar: self, index: index, title: title)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.isTouch = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let `self` = self else { return }
            self.indexDetailView?.alpha = 0
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.isTouch = true
        if (!isHideDetailView) {
            self.indexDetailView?.alpha = 1
        }

        guard let touchPoint = (event?.touches(for: self)?.first)?.location(in: self) else { return }
        self.toSelectTitle(touchPoint: touchPoint)
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touchPoint = (event?.touches(for: self)?.first)?.location(in: self) else { return }
        self.toSelectTitle(touchPoint: touchPoint)
    }
}

public class CustomView: UIView {

    var indexLabel: UILabel?
    var drawColor: UIColor = .black
    var textColor: UIColor = .black

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawColor = .lightGray
        self.indexLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.height))
        self.indexLabel?.textColor = .white
        self.indexLabel?.textAlignment = .center
        self.indexLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.addSubview(self.indexLabel ?? UILabel())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        self.drawInContext(context: UIGraphicsGetCurrentContext()!)
    }

    public func drawInContext(context: CGContext) {
        context.setLineWidth(2.0)
        context.setFillColor(drawColor.cgColor)
        self.getDrawPath(context: context)
        context.fillPath()
    }

    public func getDrawPath(context: CGContext) {
        let width = bounds.size.width
        let height = bounds.size.height
        let xOffset: CGFloat = bounds.size.width * 1 / 4
        let yOffset: CGFloat = bounds.size.height * 1 / 4
        let radius = sqrt(pow(xOffset, 2) + pow(yOffset, 2))

        context.move(to: CGPoint(x: width - xOffset, y: height * 0.5 - yOffset))
        context.addLine(to: CGPoint(x: width, y: height * 0.5))
        context.addLine(to: CGPoint(x: width - xOffset, y: height * 0.5 + yOffset))

        context.addArc(tangent1End: CGPoint(x: width * 0.5, y: height), tangent2End: CGPoint(x: width * 0.5 - xOffset, y: height * 0.5 + yOffset), radius: radius)
        context.addArc(tangent1End: CGPoint(x: 0, y: height * 0.5), tangent2End: CGPoint(x: width * 0.5 - xOffset, y: height * 0.5 - yOffset), radius: radius)
        context.addArc(tangent1End: CGPoint(x: width * 0.5, y: 0), tangent2End: CGPoint(x: width * 0.5 + xOffset, y: height * 0.5 - yOffset), radius: radius)
        context.closePath()
    }
}
