//
//  SignUpApiClient.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

struct AuthorizationApiClient {
    private static let signUpPath = "organization/register"
    private static let personSignInPath = "auth/login"
    private static let organizationSignInPath = "auth/organization/login"
    
    static func signUp(parameters: SignUpParameters) -> ApiClient {
        ApiClient(
            path: signUpPath,
            method: .post,
            task: .multipart(parameters: parameters),
            headers: [])
    }
    
    static func personSignIn(parameters: SignInParameters) -> ApiClient {
        ApiClient(
            path: personSignInPath,
            method: .post,
            task: .multipart(parameters: parameters),
            headers: [])
    }
    
    static func organizationSigIn(parameters: SignInParameters) -> ApiClient {
        ApiClient(path: organizationSignInPath,
                  method: .post,
                  task: .multipart(parameters: parameters),
                  headers: [])
    }
}
