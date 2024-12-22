//
//  UserDetail.swift
//  ModelApiTable
//
//  Created by MAC os on 3/8/21.
//
import SwiftUI
import MapKit
struct MapDetail: UIViewRepresentable {
    let user: PlaceData
    
    func makeUIView(context: Context) -> MKMapView {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: user.lat, longitude: user.lng)
        annotation.title = user.name
        
        MKMapView.appearance().addAnnotation(annotation)
        return MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let latitude = (user.lat)
        let longitude = (user.lng)
        let coordinate = CLLocationCoordinate2D(
            latitude: Double(latitude), longitude: Double(longitude))
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        view.isZoomEnabled = true
        //view.isUserInteractionEnabled = false
        view.isScrollEnabled = false
        view.isPitchEnabled = true
        view.setRegion(region, animated: true)
    }
    
    
}

//struct MapDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MapDetail()
//    }
//}
