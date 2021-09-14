//
//  LoginViewController.swift
//  Udeliver
//
//  Created by Surgeont on 02.09.2021.
//

import UIKit

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    private var listener: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.image = UIImage(named: "U")

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        listener = Auth.auth().addStateDidChangeListener { [weak self]  (auth, user) in
//            guard user != nil else { return }
//
//            self?.loginTextField.text = ""
//            self?.passwordTextField.text = ""
//
//            self?.goToTapBar()
//
//        }
        
    }
    

    @IBAction func createNewUserButtonPressed(_ sender: UIButton) {
        
        guard let email = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                Auth.auth().signIn(withEmail: email, password: password)
                
                self?.goToTapBar()
                
            }
            
        }
        
        
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = loginTextField.text,
              let password = passwordTextField.text
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Warning!", message: "Пользователь не найден", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self?.present(alert, animated: true, completion: nil)
            } else {
                Auth.auth().signIn(withEmail: email, password: password)
                
                self?.goToTapBar()
            }
            
        }
        
       
        
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
        
    }
    
    func goToTapBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TapBar")
        present(destinationVC, animated: true, completion: nil)
    }
    
    @IBAction func aboutButtonPressd(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "InfoViewController")
        present(destinationVC, animated: true, completion: nil)
        
    }
}
