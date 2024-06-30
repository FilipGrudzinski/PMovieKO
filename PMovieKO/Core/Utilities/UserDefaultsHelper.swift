import Foundation

enum UserDefaultsKey: String {
    case favorites 
}

protocol UserDefaultsHelping {
    func setArray<T: Codable>(_ value: [T], forKey key: UserDefaultsKey)
    func getArray<T: Codable>(forKey key: UserDefaultsKey) -> [T]?
}

final class UserDefaultsHelper: UserDefaultsHelping {
    private let defaults = UserDefaults.standard
    
    func setArray<T: Codable>(_ value: [T], forKey key: UserDefaultsKey) {
        let data = try? JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func getArray<T: Codable>(forKey key: UserDefaultsKey) -> [T]? {
        guard let data = defaults.value(forKey: key.rawValue) as? Data else {
          return nil
        }
        return try? JSONDecoder().decode([T].self, from: data)
    }
}

