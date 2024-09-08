//
//  ViewController.swift
//  Memorabilia
//
//  Created by Alok Sahay on 02.09.2024.
//

import UIKit
import Web3Auth

class LoginViewController: UIViewController {
    
    @IBOutlet var bgImageView: UIImageView!
    var signinButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
        
    func setupViews() {
        signinButton = UIButton(type: .system)
        signinButton?.setTitle("Sign in with Web3Auth", for: .normal)
        signinButton?.setTitleColor(.white, for: .normal)
        signinButton?.backgroundColor = .black
        signinButton?.layer.borderColor = UIColor.white.cgColor
        signinButton?.layer.borderWidth = 1.0
        signinButton?.layer.cornerRadius = 20
        signinButton?.clipsToBounds = true
        signinButton?.translatesAutoresizingMaskIntoConstraints = false
        signinButton?.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        
        self.view.addSubview(signinButton!)
        
        NSLayoutConstraint.activate([
            signinButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signinButton!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 270),
            signinButton!.widthAnchor.constraint(equalToConstant: 200),
            signinButton!.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func loginUser() {
        performSegue(withIdentifier: "dashboard", sender: nil)
//        login(provider: .GOOGLE)
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
                    
                    Web3AuthManager.sharedAuthManager.user = result
                    // Go to dashboard
                    performSegue(withIdentifier: "dashboard", sender: nil)
                    
                    
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
                Web3AuthManager.sharedAuthManager.user = result.state
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

