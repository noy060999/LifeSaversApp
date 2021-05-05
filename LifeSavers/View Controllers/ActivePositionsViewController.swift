//
//  ActivePositionsViewController.swift
//  LifeSavers
//
//  Created by user167523 on 7/7/20.
//  Copyright © 2020 NoyD. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class ActivePositionsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let cellReuseID = "cell"
    
    //outlets define
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewActivePositions: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    //all lcoations by strings
    var allLocationsStrings: [String] = []
    var allLocations: [Location] = []
    var isSearching = false
    
    var searchValue = [String]()
    var myIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the keyboard disappear when clicking anywhere on screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //setActivePositionsToFireStore()
        mapView.showAnnotations(mapView.annotations, animated: true)
        addAllPositionsToMap()
        
        tableViewActivePositions.delegate = self
        tableViewActivePositions.dataSource = self
        
        makeList()
        
    }
    
    //add all the active positions to db
    func setActivePositionsToFireStore(){
        let db = Firestore.firestore()
        let docRefTA1 = db.collection("activePositions").document("Tel-Aviv1")
        docRefTA1.setData(["city":"Tel-Aviv", "address": "Rotchild Blvd 55", "lat": 32.064732, "lon": 34.7734587, "startTime": "8:30", "endTime": "12:00"])
        let docRefTA2 = db.collection("activePositions").document("Tel-Aviv2")
        docRefTA2.setData(["city":"Tel-Aviv", "address": "Tel Hai school", "lat": 32.0517405, "lon": 34.804797, "startTime": "8:00", "endTime": "12:00"])
        let docRefHolon = db.collection("activePositions").document("Holon1")
        docRefHolon.setData(["city":"Holon", "address": "Harokmim 1", "lat": 32.0108836, "lon": 34.7946041, "startTime": "8:00", "endTime": "12:30"])
        let docRefRG1 = db.collection("activePositions").document("Ramat-Gan1")
        docRefRG1.setData(["city":"Ramat-Gan", "address": "Tel-Hashomer hospital", "lat": 32.046725, "lon": 34.8420477, "startTime": "8:00", "endTime": "12:30"])
        let docRefMigdalEmek1 = db.collection("activePositions").document("Migdal-Ha'Emek1")
        docRefMigdalEmek1.setData(["city":"Migdal-Ha'Emek", "address": "Peretz Center", "lat": 32.6780967, "lon": 35.2409872, "startTime": "8:30", "endTime": "13:30"])
        let docRefLehavim = db.collection("activePositions").document("Lehavim1")
        docRefLehavim.setData(["city":"Lehavim", "address": "Lehavim Center", "lat": 31.3731069, "lon": 34.8092819, "startTime": "8:30", "endTime": "13:00"])
        let docRefJerusalem = db.collection("activePositions").document("Jerusalem1")
        docRefJerusalem.setData(["city":"Jerusalem", "address": "King-George 20", "lat": 31.78153, "lon": 35.2138313, "startTime": "9:00", "endTime": "12:45"])
        let docRefHaifa = db.collection("activePositions").document("Haifa1")
        docRefHaifa.setData(["city":"Haifa", "address": "Yizhak Sade 10", "lat": 32.824678, "lon": 34.9860711, "startTime": "8:00", "endTime": "12:30"])
        let docRefAfula = db.collection("activePositions").document("Afula1")
        docRefAfula.setData(["city":"Afula", "address": "Kehilat Tzion 2", "lat": 32.6079613, "lon": 35.2901985, "startTime": "8:30", "endTime": "13:30"])
    }
    
    //add annotations to the map
    func addAllPositionsToMap (){
        
        //mapView inits
        _ = CLLocationCoordinate2D(latitude: 32.064732, longitude: 34.7734587)
        let initialLocation = CLLocation(latitude: 32.064732, longitude: 34.7734587)
        mapView.centerToLocation(initialLocation)
        
        //get locations from firestore, and add them to mapView
        let db = Firestore.firestore()
        let collectionRef = db.collection("activePositions")
        let _: Void = collectionRef.getDocuments { (querySnapshot, err) in
            if err != nil{
                print("error")
            }
            else {
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    let docLat: Double = (docData["lat"])! as! Double
                    let docLon: Double = (docData["lon"])! as! Double
                    let docCity: String = (docData["city"])! as! String
                    let docAddress: String = (docData["address"])! as! String
                    let docLocation = CLLocationCoordinate2D(latitude: docLat, longitude: docLon)
                    
                    //add annotation to mapView
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = docLocation
                    annotation.title = docCity
                    annotation.subtitle = docAddress
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    
    //table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{ //if the user searched something
            return searchValue.count
        }
        else{
            return allLocationsStrings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableViewActivePositions.dequeueReusableCell(withIdentifier: cellReuseID) ?? UITableViewCell(style: .default, reuseIdentifier: "cell") as UITableViewCell
        if isSearching{
            cell.textLabel?.text = searchValue[indexPath.row]
        }
        else{
            cell.textLabel?.text = self.allLocationsStrings[indexPath.row]
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        var mySelectedLocation: CLLocation
        //center to selected location on map
        if isSearching{
            mySelectedLocation = findSelectedLocationFromStr(locStr: searchValue[myIndex])
        }
        else {
            mySelectedLocation = findSelectedLocationFromStr(locStr: allLocationsStrings[myIndex])
        }
        mapView.centerToLocation(mySelectedLocation)
    }
    
    //figure the location from the str in the table view
    func findSelectedLocationFromStr(locStr: String) -> CLLocation{
        var tempCllocation = CLLocation(latitude: 0.0, longitude: 0.0)
        for loc in allLocations{
            if loc.locationString == locStr{
                let tempLat = loc.location.latitude
                let templon = loc.location.longitude
                tempCllocation = CLLocation(latitude: tempLat, longitude: templon)
                return tempCllocation
            }
        }
        return tempCllocation
    }
    
    //make strings list to put in the table view
    func makeList (){
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("activePositions")
        var tempList : [String] = []
        var tempLocationList : [Location] = []
        self.allLocationsStrings.removeAll()
        let _: Void = collectionRef.getDocuments { (querySnapshot, err) in
            if err != nil{
                print("error")
            }
            else {
                //check all documents
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    let docCity: String = (docData["city"])! as! String
                    let docLoc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (docData["lat"]) as! CLLocationDegrees, longitude: (docData["lon"]) as! CLLocationDegrees)
                    let docAddress: String = (docData["address"])! as! String
                    let docStartTime: String = (docData["startTime"])! as! String
                    let docEndTime: String = (docData["endTime"])! as! String
                    let docDate: String = (docData["date"])! as! String
                    let tempLocation = Location(_location: docLoc, _city: docCity, _address: docAddress, _startTime: docStartTime, _endTime: docEndTime)
                    tempLocation.locationString = "\(docCity), \(docAddress), התחלה: \(docDate) \(docStartTime), סיום: \(docEndTime)"
                    tempLocationList.append(tempLocation)
                    tempList.append(tempLocation.locationString)
                }
                self.allLocationsStrings = tempList
                self.allLocations = tempLocationList
                self.tableViewActivePositions.reloadData()
            }
        }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

//mapView extension
private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

//searchBar extension
extension ActivePositionsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchValue = allLocationsStrings.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearching = true
        tableViewActivePositions.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        self.view.endEditing(true)
        tableViewActivePositions.reloadData()
        
    }
}
