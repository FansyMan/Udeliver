//
//  ProfileViewController.swift
//  Udeliver
//
//  Created by Surgeont on 06.09.2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ProfileTableViewCell {
            let dealModel = myDeals[indexPath.row]
            
            cell.dealModel = dealModel
            
            cell.layer.cornerRadius = 20
            cell.layer.masksToBounds = true
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var myDeals = [FirebaseDeal]()
    
   
    var listener: ListenerRegistration?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = Auth.auth().currentUser
        let email = user?.email
        
        let executorsCollection = Firestore.firestore().collection("\(email!)")
       
        
        userNameLabel.text = "Ваш id: \(email!)"
        
        listener = executorsCollection.addSnapshotListener{ [weak self] (snapshot, error) in
            self?.myDeals.removeAll()
            
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents {
                if let deal = FirebaseDeal(dict: document.data()) {
                    self?.myDeals.append(deal)
                }
            }
            self?.tableView.reloadData()
        }
        
    }
    
    deinit {
            listener?.remove()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromProfileToInfo" {
            if let destinationVC = segue.destination as? DealInfoViewController {
                destinationVC.deal = sender as? FirebaseDeal
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let deal = myDeals[indexPath.row]
        
        performSegue(withIdentifier: "fromProfileToInfo", sender: deal)
    }
    
    
    
}
