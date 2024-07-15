//
//  Utils.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 20/6/24.
//

import Foundation
import UIKit

class Utils {
    
    @MainActor
    class func getTopViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let nav = controller as? UINavigationController {
            return getTopViewController(controller: nav.visibleViewController)
            
        } else if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return getTopViewController(controller: selected)
            
        } else if let presented = controller?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        return controller
    }
}
