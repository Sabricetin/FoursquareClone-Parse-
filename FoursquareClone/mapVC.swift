//
//  mapVC.swift
//  FoursquareClone
//
//  Created by Sabri Çetin on 23.06.2024.
//

import UIKit
import MapKit
import Parse

class mapVC: UIViewController , MKMapViewDelegate , CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
   var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "<Back", style: .plain, target: self, action: #selector(backButtonClicked))
      
        //KULLANICININ KORDİNATINI ALMA
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gesturRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
    }
    // KULLANICININ YERİNİ HARİTADA İŞARETLEME (ANNOTATİON)
    @objc func chooseLocation(gesturRecognizer:UIGestureRecognizer) {
        
        if gesturRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gesturRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches , toCoordinateFrom: self.mapView )
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        locationManager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    // PARS'A VERİLERİ KAYIT ETME
    @objc func saveButtonClicked () {

        let placeModel = PlaceModel.sharedInstance

        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["atmosphere"] = placeModel.placeAtmosphere
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
            object.saveInBackground { success, error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
                }
            }
        }
    }
    @objc func backButtonClicked () {
        
        self.dismiss(animated: true , completion: nil)
    }
}
