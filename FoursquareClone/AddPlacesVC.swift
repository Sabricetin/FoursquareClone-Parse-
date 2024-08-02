//
//  AddPlacesVC.swift
//  FoursquareClone
//
//  Created by Sabri Çetin on 23.06.2024.
//

import UIKit
import PhotosUI

@available(iOS 14.0, *)
class AddPlacesVC: UIViewController ,PHPickerViewControllerDelegate {
    
    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmospherText: UITextField!
    @IBOutlet weak var placeİmageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeİmageView.isUserInteractionEnabled = true
        let gesturRecegnizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        placeİmageView.addGestureRecognizer(gesturRecegnizer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmospherText.text != "" {
            
            if let chosenImage = placeİmageView.image {
                
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeNameText.text!
                placeModel.placeAtmosphere = placeAtmospherText.text!
                placeModel.placeImage = chosenImage
            }
                performSegue(withIdentifier: "toMapVC", sender: nil)
        }  else {

            let alert = UIAlertController(title: "ERROR", message: "Place Name/Type/Atmosphere ???", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    /*  @objc func chooseImage () {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker , animated: true , completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeİmageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
*/
    
    //FOTOĞRAF SEÇME
    @available(iOS 14.0, *)
    @IBAction func pickImage(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images // Sadece görüntülerin seçilmesini sağlar

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        guard !results.isEmpty else {
            return
        }
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.placeİmageView.image = image // UIImageView'e seçilen görüntüyü atama
                    }
                }
            }
        }
    }
}
