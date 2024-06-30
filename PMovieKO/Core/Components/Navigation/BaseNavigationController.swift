import UIKit

class BaseNavigationController: UINavigationController {
    var bigScreenLimit: Bool = false
    var navigationBarStyle: NavigationBarStyle = .primary

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return navigationBarStyle.config.statusBarStyle
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addBackButton()

        set(navigationBarStyle: navigationBarStyle)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func addBackButton() {
        let backButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        topViewController?.navigationItem.backBarButtonItem = backButton
    }
}
