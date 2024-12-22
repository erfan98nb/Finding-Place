//
//  ContentView.swift
//  ModelApiTable
//
//  Created by MAC os on 2/24/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    init() {

        //Table Apperance
        UITableView.appearance().backgroundColor = Color.lightPink2
        UITableViewCell.appearance().selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = Color.lightPink2
            return view
        }()
        //Navigation Apperance
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.purple]
    }
    
    @State private var isAlertPresent = false

    var locationViewModel = LocationViewModel()
    var getDataModels = GetDataModel.shared
    @State var place = [PlaceData]()
    @State var isLoaded = true
    @State var offset = 0
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.lightPink.edgesIgnoringSafeArea(.all)
                VStack {
                    if (place.count > 0 ){
                        
                        List{
                            ForEach(place){item in
                                NavigationLink(destination:
                                                DetailView(place : item)
                                ) {
                                    VStack {
                                        HStack {
                                            
                                            WebImage(url: URL(string:item.icon))
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .background(SwiftUI.Color.purple)
                                                .cornerRadius(5)
                                                .onAppear(){
                                                }
                                            Text(item.name)
                                                .font(.system(size: 15))
                                                .lineLimit(2)
                                            Spacer()
                                            
                                        }
                                        HStack {
                                            Text(item.shortname)
                                                .font(.system(size: 14))
                                            Spacer()
                                            
                                            Text("\(item.distance)m away ")
                                                .font(.system(size: 14))
                                                
                                                .foregroundColor(.pink)
                                                .padding(.trailing, 20)
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                }
                            }
                            
                            .listRowBackground(Color.lightPink)
                            //End Of Foreach
                            VStack{
                                ActivityIndicator(.constant(true), style: .large)
                                    .onAppear(){
                                        
                                        if isLoaded {
                                            
                                            isLoaded = false
                                            pageInation()
                                            
                                        }
                                        
                                    }
                            }
                            .frame(width: UIScreen.main.bounds.width, height: 50)
                            .background(Color.lightPink)
                            .listRowBackground(Color.lightPink)
                        }
                        //End Of List
                        .alert(isPresented: $isAlertPresent) {
                            Alert(title: Text("error!"), message: nil, dismissButton: nil)
                        }
                        .listStyle(PlainListStyle())
                        .onAppear {
                            UITableView.appearance().separatorStyle = .none
                        }.onDisappear {
                            UITableView.appearance().separatorStyle = .singleLine
                        }
                        .frame(width: UIScreen.main
                                .bounds.width, height: UIScreen.main
                                    .bounds.height - 200)
                        .padding(.top , 20)
                        
                        .animation(Animation.easeInOut .delay(1) )
                        
                    }
                    
                }
                .foregroundColor(.black)
                
            }
            .alert(isPresented: $isAlertPresent) {
                Alert(title: Text("Fail to load Data"), message: nil, dismissButton: nil)
            }
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                                place.removeAll()
                                                offset = 0
                                                pageInation() }) {
                                            Image(systemName: "arrow.clockwise")
                                                .font(.largeTitle)
                                        }.foregroundColor(.purple)
                                    })
            .navigationBarTitle(Text("Places"))
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                isLoaded = true
                pageInation()
            }
        })
    }
    //below function just for test Post Method in this application
    func pageInation() {
        GetDataModel.shared.postData(fname: "erfan", lname: "nalbandian", state: "done?", completion: {(result)in
            //  print(result)
        })
        GetDataModel.shared.getPlaceDetails(lat: locationViewModel.userLatitude, lng: locationViewModel.userLongitude, offset: offset, completion: {(offers) in
            if offers == nil{
                isAlertPresent = true
            }else{
                self.place = offers!
                print("offers")
                print(self.place.count)

                offset += 10
                print(offset)
                isLoaded = true
             }
        })
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let lightPink = Color("lightPink")
    static let lightPink2 = UIColor(.lightPink)
}
