//
//  detailView.swift
//  ModelApiTable
//
//  Created by MAC os on 2/28/21.
//

import SwiftUI
import  MapKit
import SDWebImageSwiftUI
struct DetailView: View {
    
    @State var showModal = false
    var place : PlaceData
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Spacer()
                Color.lightPink.edgesIgnoringSafeArea(.all)
                Spacer()
                
                VStack {
                    WebImage(url: URL(string:place.icon))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .background(SwiftUI.Color.purple.edgesIgnoringSafeArea(.all))
                        .clipShape(Circle())
                    
                    Text(place.name)
                    Text(place.summary)
                        .foregroundColor(.pink)
                        .font(.system(size: 10))
                    Spacer()
                        .padding(.top , 1)
                    
                    HStack{
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.purple)
                        
                        Text(String(place.address))
                        Spacer()
                    }
                    
                    HStack{
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.purple)
                        
                        Text(String(place.shortname))
                        Spacer()
                    }
                    .padding(.top,10)
                    
                    HStack{
                        Image(systemName: "location.circle")
                            .foregroundColor(.purple)
                        Text("\(place.distance)m away ")
                        Spacer()
                        
                    }
                    .padding(.top,10)
                    .padding(.bottom,30)
                    Spacer()
                    
                    Button(action: {
                        self.showModal = true
                    }) {
                        HStack {
                            Image(systemName: "message")
                                .foregroundColor(.white)
                            
                            Text("Let's Go!")
                             
                        }
                        .sheet(isPresented: self.$showModal) {
                            MapDetail(user: place)
                             
                        }
                    }
                    .animation(Animation.linear(duration: 2))
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 100, height: 50)
                    .foregroundColor(.white)
                    .background(SwiftUI.Color.pink.edgesIgnoringSafeArea(.all))
                    .cornerRadius(15)
                    .shadow(radius: 8 )
                }
                .animation(
                    Animation.easeInOut(duration: 1)
                )
                .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 50)
                .font(.system(size: 18))
                .padding( )
                
                .background(SwiftUI.Color.white.edgesIgnoringSafeArea(.all))
                .cornerRadius(15)
                
                
            } 
            
            
            
        }                  .navigationTitle("Place Detail")
        
    }
    
}


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//       // DetailView(place: PlaceData(jsonObject: JSON()))
//     }
//}


