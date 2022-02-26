//
//  OnBoardingContainerViewController.swift
//  Bankey
//
//  Created by yeonBlue on 2022/02/22.
//

import UIKit
import SnapKit
import Then

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {

    // MARK: - Properties
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1) // 마지막 페이지일때만 표시
        }
    }

    let nextButton = UIButton().then {
        $0.setTitle("Next", for: .normal)
        $0.setTitleColor(.systemCyan, for: .normal)
        $0.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    let backButton = UIButton().then {
        $0.setTitle("Back", for: .normal)
        $0.setTitleColor(.systemCyan, for: .normal)
        $0.addTarget(self, action: #selector(backButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    let doneButton = UIButton().then {
        $0.setTitle("Done", for: .normal)
        $0.setTitleColor(.systemCyan, for: .normal)
        $0.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    let closeButton = UIButton().then {
        $0.setTitle("Close", for: .normal)
        $0.setTitleColor(.systemCyan, for: .normal)
        $0.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .primaryActionTriggered)
    }
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
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
        
        pageViewController.setViewControllers([pages.first!],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        currentVC = pages.first!
    }
    
    private func layout() {
        view.addSubview(closeButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(64)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(64)
        }
        
        doneButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(64)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func closeButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        guard let previousVC = getPreviousViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([previousVC],
                                              direction: .reverse,
                                              animated: true,
                                              completion: nil)
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        guard let nextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([nextVC],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
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
