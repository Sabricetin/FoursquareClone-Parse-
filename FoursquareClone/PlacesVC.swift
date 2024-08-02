//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Sabri Çetin on 22.06.2024.
//

import UIKit
import Parse

class PlacesVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String] ()
    var placeIdArray = [String] ()
    var selectedPlaceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation Bar Ekleme
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.done, target: self, action: #selector(logoutButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromParse()
        
    }
    //PARSE'DAN VERİLERİ TABLEVİEW'E AKTARMA
    func getDataFromParse () {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects , error) in
            
            if error != nil {
                self.makeAlert(titleInput: "ERROR", massageInput: error?.localizedDescription ?? "ERROR")
                
            } else {
                if objects != nil {
                    
                    self.placeNameArray.removeAll()
                    self.placeIdArray.removeAll()
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIdArray.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    @objc   func addButtonClicked(){
        //segue
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
  //ÇIKIŞ YAPMA BUTONU
    @objc    func logoutButtonClicked() {
        
        PFUser.logOutInBackground {(error) in
            
            if error != nil {
                self.makeAlert(titleInput: "ERROR", massageInput: error?.localizedDescription  ?? "ERROR")
                                
            } else {
                self.performSegue(withIdentifier: "toSignupVC", sender: nil)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.chosenPlaceId = selectedPlaceId
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlaceId = placeIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    //TABLEVİEW AYARLARI
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    func makeAlert (titleInput : String , massageInput : String ){
        
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert , animated: true , completion: nil)
    }
}
