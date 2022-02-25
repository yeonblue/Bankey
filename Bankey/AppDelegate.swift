//
//  AppDelegate.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        window?.rootViewController = onboardingContainerViewController
        
        return true
    }
}

// MARK: - LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("DEBUG: AppDelegate LoginViewControllerDelegate didLogin() called")
        setRootViewController(viewController: onboardingContainerViewController)
    }
}

// MARK: - LoginViewControllerDelegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("DEBUG: AppDelegate OnboardingContainerViewControllerDelegate didFinishOnboarding() called")
        setRootViewController(viewController: loginViewController)
    }
}

// MARK: - Helper
extension AppDelegate {
    func setRootViewController(viewController vc: UIViewController, animated: Bool = true) {
        if let window = window, animated {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        } else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
}
