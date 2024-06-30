import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
