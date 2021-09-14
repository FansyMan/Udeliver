//
//  DealInfoViewController.swift
//  Udeliver
//
//  Created by Surgeont on 06.09.2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DealInfoViewController: UIViewController {
    
    var deal: FirebaseDeal?
    var dealsCollection = Firestore.firestore().collection("deals")
    
    
    
    @IBOutlet weak var helpTipLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var dealIdLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var toAddressLabel: UILabel!
    @IBOutlet weak var fromAddressLabel: UILabel!
    @IBOutlet weak var dealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.text = "Статус: \(deal!.status)"
        dealIdLabel.text = "id: \(deal!.dealId)"
        priceLabel.text = "Стоимость: \(deal!.price)"
        commentsLabel.text = "Комментарии: \(deal!.comments)"
        fromAddressLabel.text = "Откуда: \(deal!.fromAddress)"
        toAddressLabel.text = "Куда: \(deal!.toAddress)"
        dealNameLabel.text = "Доставка: \(deal!.dealName)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch deal!.status {
        case "Новая":
            actionButton.isHidden = false
            helpTipLabel.text = "Вы можете взять доставку"
        case "В процессе":
            actionButton.isHidden = true
            helpTipLabel.text = "Эта доставка находится в процессе выполнения"
            
        case "Выполнено":
            actionButton.isHidden = true
            helpTipLabel.isHidden = true
        default:
            break
        }
        
        let userName = Auth.auth().currentUser?.email
        if userName == deal?.executorName && deal?.status == "В процессе" {
            actionButton.isHidden = false
            actionButton.setTitle("Выполнено", for: .normal)
            helpTipLabel.text = "Не забудьте закрыть доставку после её выполнения"
            actionButton.addTarget(self, action: #selector(completeDeal), for: .touchUpInside)
        }
        
    }
    
    @objc func completeDeal() {
        
        let user = Auth.auth().currentUser
        let email = (user?.email)!
        
        let editedDeal = FirebaseDeal(dealId: deal!.dealId,
                                      dealName: deal!.dealName,
                                fromAddress: deal!.fromAddress,
                                toAddress: deal!.toAddress,
                                price: deal!.price,
                                status: "Выполнено",
                                comments: deal!.comments,
                                executorName: email)
        
        saveUserToFireStore(deal: editedDeal)
        deleteDealFromExecutorsBase(deal: editedDeal)
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func takeOrderButtonPressed(_ sender: UIButton) {
        
        let user = Auth.auth().currentUser
        let email = (user?.email)!
        
        let editedDeal = FirebaseDeal(dealId: deal!.dealId,
                                      dealName: deal!.dealName,
                                fromAddress: deal!.fromAddress,
                                toAddress: deal!.toAddress,
                                price: deal!.price,
                                status: "В процессе",
                                comments: deal!.comments,
                                executorName: email)
        
        saveDealToExecutorsBase(deal: editedDeal)
        saveUserToFireStore(deal: editedDeal)
        
        
    }
    
    private func saveDealToExecutorsBase(deal: FirebaseDeal) {
        
        let executorsCollection = Firestore.firestore().collection("\(deal.executorName)")
        executorsCollection.document("\(deal.dealId)").setData(deal.toAnyObject()) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func deleteDealFromExecutorsBase(deal: FirebaseDeal) {
        
        let executorsCollection = Firestore.firestore().collection("\(deal.executorName)")
        executorsCollection.document("\(deal.dealId)").delete { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func saveUserToFireStore(deal: FirebaseDeal) {
        dealsCollection.document("\(deal.dealId)").setData(deal.toAnyObject()) { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
