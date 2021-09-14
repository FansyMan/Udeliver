//
//  AddNewDeliveryViewController.swift
//  Udeliver
//
//  Created by Surgeont on 05.09.2021.
//

import UIKit
import FirebaseFirestore


class AddNewDeliveryViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addDealNameTextField: UITextField!
    
    @IBOutlet weak var addToAddressTextField: UITextField!
    @IBOutlet weak var addFromAddressTextField: UITextField!
    @IBOutlet weak var addCommentsTextField: UITextView!
    @IBOutlet weak var addPriceTextField: UITextField!
    
    var deal: FirebaseDeal?
    var dealsCollection = Firestore.firestore().collection("deals")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCommentsTextField.layer.borderColor = UIColor.lightGray.cgColor
        addCommentsTextField.layer.borderWidth = 1.0
        addCommentsTextField.layer.cornerRadius = 5
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func goToDeals() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "TapBar")
        present(destinationVC, animated: true, completion: nil)
        
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        
        goToDeals()
        
    }
    
    
    @IBAction func createNewDealButtonPressed(_ sender: UIButton) {
        
        if addDealNameTextField.text == "" || addPriceTextField.text == "" || addCommentsTextField.text == "" || addFromAddressTextField.text == "" || addToAddressTextField.text == "" {
            showAlert()
        } else {
        let deal = FirebaseDeal(dealId: Int.random(in: 1...1000000),
                                dealName: addDealNameTextField.text ?? "Error",
                                fromAddress: addFromAddressTextField.text ?? "Error",
                                toAddress: addToAddressTextField.text ?? "Error",
                                price: addPriceTextField.text ?? "Error",
                                status: "Новая",
                                comments: addCommentsTextField.text,
                                executorName: "Не определён")
        
                
        dealsCollection.document("\(deal.dealId)").setData(deal.toAnyObject()) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        goToDeals()
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Warning!", message: "Заполните все поля", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    

}
