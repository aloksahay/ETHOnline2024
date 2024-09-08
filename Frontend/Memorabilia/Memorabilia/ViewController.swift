//
//  ViewController.swift
//  Memorabilia
//
//  Created by Alok Sahay on 02.09.2024.
//

import UIKit
import Web3Auth

class ViewController: UIViewController {

    var user: Web3AuthState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func loginUser() {
        login(provider: .GOOGLE)
    }
    
    func login(provider: Web3AuthProvider) {
        
        Task {
            do {
                
                let result = try await Web3Auth().login(W3ALoginParams(loginProvider: provider))
                // Perform action upon success
                
                if result.error == nil {
                    print("""
                       Signed in successfully!
                            Private key: \(String(describing: result.privKey))
                            Public key: \(String(describing: result.tssPubKey))
                            User info:
                                Name: \(String(describing: result.userInfo?.name))
                                Email: \(String(describing: result.userInfo?.email))
                                Profile image: \(result.userInfo?.profileImage ?? "N/A")
                                Type of login: \(String(describing: result.userInfo?.typeOfLogin))
                       """)
                    
                    self.user = result
                    // do something here
                } else {
                    print("Error: \(result.error ?? "404")")
                }
                
            } catch {
                print("Error")
            }
        }
    }
    
    func checkUserStatus() {
        Task {
            do {
                let result = try await Web3Auth()
                self.user = result.state
            }
            catch {
               print("Error")
           }
        }
    }
    
    func logout() throws {
        Task {
            try await Web3Auth().logout()
            await MainActor.run(body: {
            })
        }
    }
    
}

