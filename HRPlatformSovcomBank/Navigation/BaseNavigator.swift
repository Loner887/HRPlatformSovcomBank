import UIKit
import SnapKit


protocol BaseNavigatorProtocol: MenuNavigatorProtocol {
    func toStartVc()
    func toVacancy(_ role: Int, _ userId: Int)
}

final class BaseNavigator: BaseNavigatorProtocol {
    
    private let navigationController: UINavigationController
    private let services: NetworkProvider
    
    init(services: NetworkProvider,
         navigationController: UINavigationController) {
        self.services = services
        self.navigationController = navigationController
    }
    
    func toStartVc() {
        let vc = ViewController()
        let viewModel = LoginViewModel(navigator: self)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toProfile() {
        let vc = ProfileViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toSettings() {
        
    }
    
    func toVacancy(_ role: Int, _ userId: Int) {
        let vc = VacancyViewController()
        vc.role = role
        vc.userID = userId
        let titleLabel = UILabel()
        titleLabel.text = "Вакансии"
        titleLabel.textColor = .primary500
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        titleLabel.sizeToFit()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let menuImage = UIImage(named: "Menu")
        let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(openMenu))
        vc.navigationItem.rightBarButtonItem = menuButton
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    @objc func openMenu() {
        toMenu()
    }
    
    func toMenu() {
        let vc = MenuViewController()
        let menuNavigator = MenuNavigator(navigationController: navigationController)
        let viewModel = MenuViewModel(navigator: menuNavigator)
        vc.viewModel = viewModel
        let imageView = UIImageView(image: UIImage(named: "sovkomPeople"))
        imageView.contentMode = .scaleAspectFit
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 227, height: 64))
        customView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.left.equalTo(imageView.snp.left)
            make.right.equalTo(imageView.snp.right)
            make.bottom.equalTo(imageView.snp.bottom)
        }
        
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)

        let clouseImage = UIImage(named: "clouseButton")
        let clouseButton = UIBarButtonItem(image: clouseImage, style: .plain, target: self, action: #selector(dismissViewController))
        vc.navigationItem.rightBarButtonItem = clouseButton
        navigationController.pushViewController(vc, animated: true)
    }
    
    @objc func dismissViewController() {
        navigationController.popViewController(animated: true)
    }
}
