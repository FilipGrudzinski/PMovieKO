protocol FavoritesHelping {
    func getFavorites() -> [Int]
    func isFavorite(id: Int) -> Bool
    func updateFavorites(id: Int)
}

final class FavoritesHelper: FavoritesHelping {
    private let defaults: UserDefaultsHelping
    
    init(defaults: UserDefaultsHelping) {
        self.defaults = defaults
    }

    func getFavorites() -> [Int] {
        return defaults.getArray(forKey: UserDefaultsKey.favorites) ?? []
    }
    
    func updateFavorites(id: Int) {
        var favorites = getFavorites()
        
        if isFavorite(id: id) {
            if let index = favorites.firstIndex(where: { $0 == id }) {
                favorites.remove(at: index)
                defaults.setArray(favorites, forKey: UserDefaultsKey.favorites)
            }
        } else {
            favorites.append(id)
            defaults.setArray(favorites, forKey: UserDefaultsKey.favorites)
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        let favorites = getFavorites()
        let isFavorite = favorites.contains(id)
        return isFavorite
    }
}
