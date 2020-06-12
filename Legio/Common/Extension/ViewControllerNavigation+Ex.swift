//
//  ViewControllerNavigation+Ex.swift
//  Legio
//
//  Created by Марат Нургалиев on 10/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit
import NotificationBannerSwift

// Протокол для объектов, имеющих идентификатор в сториборде
protocol StoryboardIdentifiable {
	static var storyboardIdentifier: String { get }
}

enum NavigationBarState {
    case hide
    case onlyBackButton
    case show
}

extension UIViewController {
    
    func configureNavigationBar(state: NavigationBarState) {
        switch state {
        case .hide:
            self.navigationController?.navigationBar.isHidden = true
        
        case .show:
            self.navigationController?.navigationBar.isHidden = false
        
        case .onlyBackButton:
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.topItem?.title = ""
        }
    }
    
    // TO DO: Придумать решение лучше
    func setupReturnToPreviousViewController() {
        guard let previousViewController = self.navigationController?.previousViewController() else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            return
        }
        if previousViewController.isKind(of: RootView.self) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            return
        }
        
        if previousViewController.isKind(of: AuthView.self) && !(self.navigationController?.visibleViewController?.isKind(of: RegisterView.self))! {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            return
        }
        
        if previousViewController.isKind(of: RegisterView.self) {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            return
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func showNotificationBanner(title: String, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.show()
    }
    
    func updateStatusBackground(isDefault: Bool) {
        
        let backgroundColor: UIColor = isDefault ? .clear : UIColor.black.withAlphaComponent(0.3)
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = backgroundColor
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = backgroundColor
        }
    }

}

extension UINavigationController {
    
    ///Get previous view controller of the navigation stack
    func previousViewController() -> UIViewController? {
        
        let lenght = self.viewControllers.count
        
        let previousViewController: UIViewController? = lenght >= 2 ? self.viewControllers[lenght-2] : nil
        
        return previousViewController
    }
    
    /// Override для использования насктроек статусбара из контроллера, отображаемого на экране
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
}

// Расширение UIViewController,
// которое даёт совместимость с протоколом StoryboardIdentifiable
extension UIViewController: StoryboardIdentifiable { }

// Расширение протокола StoryboardIdentifiable для UIViewController,
// создающее идентификатор в сториборде, равный названию класса контроллера
extension StoryboardIdentifiable where Self: UIViewController {
	
	static var storyboardIdentifier: String {
		return String(describing: self)
	}
}

extension UIStoryboard {
	
	func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
		guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
			fatalError("View controller с идентификатором \(T.storyboardIdentifier) не найден")
		}
		
		return viewController
	}
	
	func instantiateViewController<T: UIViewController>() -> T {
		guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
			fatalError("View controller с идентификатором \(T.storyboardIdentifier) не найден")
		}
		
		return viewController
	}
}
