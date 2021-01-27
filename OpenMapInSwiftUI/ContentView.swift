//
//  ContentView.swift
//  OpenMapInSwiftUI
//
//  Created by Michael Haslam on 1/26/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    
    
    var body: some View {
        VStack{
            Form{
                Section {
                    Text("Enter Address")
                    TextField("", text: $locationManager.locationString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                Button {
                    locationManager.openMapWithAddress()
                    
                } label: {
                    Text("Get Map")
                }
                .alert(isPresented: $locationManager.invalid) {
                    Alert(title: Text("Important message"), message: Text("Enter a valid address"), dismissButton: .default(Text("OK"), action:{
                        locationManager.invalid = false
                        locationManager.locationString = ""
                    }))
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(locationManager: LocationManager())
    }
}
