//
//  DealsViewController.swift
//  Udeliver
//
//  Created by Surgeont on 02.09.2021.
//

import UIKit
import FirebaseFirestore

class DealsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DealsTableViewCell {
            let dealModel = deals[indexPath.row]
            
            cell.dealModel = dealModel
            
            cell.layer.cornerRadius = 20
            cell.layer.masksToBounds = true
            
            return cell
        }
        return UITableViewCell()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dealsCollection = Firestore.firestore().collection("deals")
    var listener: ListenerRegistration?
    
    private var deals = [FirebaseDeal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        listener = dealsCollection.addSnapshotListener{ [weak self] (snapshot, error) in
            self?.deals.removeAll()
            
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents {
                if let deal = FirebaseDeal(dict: document.data()) {
                    self?.deals.append(deal)
                }
            }
            self?.tableView.reloadData()
        }
        
    }
    
    deinit {
            listener?.remove()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfo" {
            if let destinationVC = segue.destination as? DealInfoViewController {
                destinationVC.deal = sender as? FirebaseDeal
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let deal = deals[indexPath.row]
        
        performSegue(withIdentifier: "toInfo", sender: deal)
    }

    
    
}
