//
//  Settings.swift
//  NewsTest
//
//  Created by mac on 9.10.23.
//

import Foundation

final class Settings {
    public static let darkMode = "darkMode"
    public static let lightMode = "lightMode"
}

final class UserDefaultsUtils {
    static var shared = UserDefaultsUtils()
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Settings.darkMode)
    }
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Settings.darkMode)
    }
}
