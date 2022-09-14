//
//  CertificateRequest.swift
//  job-readiness
//
//  Created by Janine Silva Leal on 13/09/22.
//

import Foundation

// MARK: - CertificateRequest
struct CertificateRequest: Codable {
    let access_token: String?
    let error: String?
}
