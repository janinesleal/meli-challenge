//
//  StringExtensions.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 15/09/22.
//

import Foundation

extension String {
    func toHttps() -> URL? {
        guard let http = URL(string: self) else { return nil }
        guard var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) else { return nil }
        comps.scheme = "https"
        guard let https = comps.url else { return nil }
        return https
    }
}
