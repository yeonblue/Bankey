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
    let dummyViewController = DummyViewController()
    var hasSeenOnboarded = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.delegate = self
        
        window?.rootViewController = loginViewController
        
        return true
    }
}

// MARK: - LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("DEBUG: AppDelegate LoginViewControllerDelegate didLogin() called")
        
        if hasSeenOnboarded {
            setRootViewController(viewController: dummyViewController)
        } else {
            setRootViewController(viewController: onboardingContainerViewController)
        }
    }
}

// MARK: - LogoutDelegate
extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(viewController: loginViewController)
    }
}

// MARK: - LoginViewControllerDelegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        print("DEBUG: AppDelegate OnboardingContainerViewControllerDelegate didFinishOnboarding() called")
        hasSeenOnboarded = true
        setRootViewController(viewController: dummyViewController)
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

