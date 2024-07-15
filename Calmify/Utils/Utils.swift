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
        // Obtén la escena activa
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            return nil
        }
        
        let rootViewController = controller ?? keyWindow.rootViewController
        
        if let nav = rootViewController as? UINavigationController {
            return getTopViewController(controller: nav.visibleViewController)
            
        } else if let tabController = rootViewController as? UITabBarController, let selected = tabController.selectedViewController {
            return getTopViewController(controller: selected)
            
        } else if let presented = rootViewController?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        
        return rootViewController
    }
}
