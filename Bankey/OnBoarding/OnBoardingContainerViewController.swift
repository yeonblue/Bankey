//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/22.
//

import UIKit
import SnapKit
import Then

class OnboardingContainerViewController: UIViewController {

    // MARK: - Properties
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController

    let closeButton = UIButton().then {
        $0.setTitle("Close", for: .normal)
        $0.setTitleColor(.systemCyan, for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
    }
    
    // MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .horizontal,
                                                       options: nil)
        
        let page1 = OnBoardingViewController(imgName: "car",
                                             labelText: "We provide the best service at a reasonable price and differentiated technology.\n\n1. Consumer finance system.\n2. Collateralized financial system.\n3. Sales management system.")
        let page2 = OnBoardingViewController(imgName: "earth",
                                             labelText: "Move your money around the world quickly and securely")
        let page3 = OnBoardingViewController(imgName: "best",
                                             labelText: "Let's start our best service")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}

extension OnboardingContainerViewController {
    private func setup(){
        view.backgroundColor = .lightGray
        
        // 추가할 때는 부모입장에서
        // add child VC, child VC를 embeded할 때 사용, 반대로 날릴 때는 willMove를 시작으로 역순으로 call
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self) // VC 이벤트를 콜함, viewDidLoad, viewWillAppear 등
        
        // 날릴 때는 자식 입장에서
        // 1. pageViewController.willMove(toParent: nil) // 제거되기 직전에 호출
        // 2. pageViewController.removeFromParent() // parentVC로 부터 관계 삭제
        // 3. pageViewController.view.removeFromSuperview() // parentVC.view.addsubView()와 반대 기능
        
        pageViewController.dataSource = self
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageViewController.setViewControllers([pages.first!],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        currentVC = pages.first!
    }
    
    private func layout() {
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
