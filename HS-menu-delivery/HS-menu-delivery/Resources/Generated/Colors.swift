// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import UIKit

extension UIColor {

    /// 0xf3f5f9ff
    static let menuBackgorund = UIColor(rgbaValue: 0xf3f5f9ff)
    /// 0xffffffff
    static let tabBarBackground = UIColor(rgbaValue: 0xffffffff)
    /// 0xc3c4c9ff
    static let tabBarNotSelect = UIColor(rgbaValue: 0xc3c4c9ff)
    /// 0xfd3a69ff
    static let tabBarSelect = UIColor(rgbaValue: 0xfd3a69ff)
    /// 0xfd3a69ff
    static let textMenuHorizontal = UIColor(rgbaValue: 0xfd3a69ff)
    /// 0x222831ff
    static let textTitleLabel = UIColor(rgbaValue: 0x222831ff)

    convenience init(rgbaValue: UInt32) {
        self.init(
            red: CGFloat((rgbaValue >> 24) & 0xff) / 255,
            green: CGFloat((rgbaValue >> 16) & 0xff) / 255,
            blue: CGFloat((rgbaValue >> 8) & 0xff) / 255,
            alpha: CGFloat((rgbaValue) & 0xff) / 255
        )
    }
}
