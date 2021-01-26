//
//  ContentView.swift
//  OpenMapInSwiftUI
//
//  Created by Michael Haslam on 1/26/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var addressString = ""
    @ObservedObject var locationManager = LocationManager.instance
    
    
    var body: some View {
        VStack{
            Form{
                Section {
                    Text("Enter Address")
                    TextField("", text: $addressString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                Button {
                    getMap()
                    
                } label: {
                    Text("Get Map")
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Important message"), message: Text("Enter a valid address"), dismissButton: .default(Text("OK"), action:{
                        getMap()
                    }))
                }
            }
        }.onAppear {
            self.addressString = ""
            self.showingAlert = false
        }
        
    }
    func getMap() {
        if locationManager.isValid == false {
            self.showingAlert.toggle()
        } else {
            self.showingAlert = false
            locationManager.openMapWithAddress(address: addressString)
            self.addressString = ""
        }
        locationManager.openMapWithAddress(address: addressString)
        self.addressString = ""
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
