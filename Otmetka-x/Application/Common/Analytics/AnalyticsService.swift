//
//  AnalyticsService.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

enum App {
    static var appVersion: String {
        let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "version undefined"
        let devSuffix = isProduction ? "" : "-DEV"
        return appVersion + devSuffix
    }
}
