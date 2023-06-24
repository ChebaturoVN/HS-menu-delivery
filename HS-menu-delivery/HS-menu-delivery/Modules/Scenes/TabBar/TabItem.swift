//
//  TabItem.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 23.06.2023.
//

import UIKit

enum TabItem: String, CaseIterable {
    case menuTI
    case contactsTI
    case profileTI
    case cartTI

    var icon: UIImage? {
        switch self {
        case .menuTI:
            return UIImage.menu
        case .contactsTI:
            return UIImage.contacts
        case .profileTI:
            return UIImage.profile
        case .cartTI:
            return UIImage.cart
        }
    }

    var iconSelected: UIImage? {
        switch self {
        case .menuTI:
            return UIImage.menuSelected
        case .contactsTI:
            return UIImage.contactsSelected
        case .profileTI:
            return UIImage.profileSelected
        case .cartTI:
            return UIImage.cartSelected
        }
    }

    var title: String? {
        switch self {
        case .menuTI:
            return L10n.TabItem.menu
        case .contactsTI:
            return L10n.TabItem.contacts
        case .profileTI:
            return L10n.TabItem.profile
        case .cartTI:
            return L10n.TabItem.cart
        }
    }
}

