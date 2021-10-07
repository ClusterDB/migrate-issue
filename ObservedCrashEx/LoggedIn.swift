//
//  LoggedIn.swift
//  ObservedCrashEx
//
//  Created by KURT LIBBY on 10/6/21.
//

import SwiftUI
import RealmSwift

struct LoggedIn: View {
  
  @State private var showAdd = false
  @State private var showDetails = false
  @State private var addressID = ""
  
    // TODO: Swap
    // @ObservedResults(Address.self, configuration: Realm.Configuration(schemaVersion: 5)) var addresses
    @ObservedResults(Address.self) var addresses
  
    var body: some View {
      
      EmptyView()
        .sheet(isPresented: $showAdd) {
          AddAddress(showAdd: $showAdd)
        }
      
      EmptyView()
        .sheet(isPresented: $showDetails) {
          AddressDetail(address: $addressID)
        }
      
      VStack{
        HStack{
          Text("Addresses")
            .font(.title)
          Spacer()
          Image(systemName: "plus.circle")
            .onTapGesture {
              self.showAdd = true
            }
        }
        .padding()
        if addresses.count != 0 {
          let columns = Array(repeating: GridItem(spacing: 10), count: 1)
          LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 0,
            pinnedViews: [.sectionHeaders, .sectionFooters]
          ){
            ForEach(addresses) { address in
              VStack{
                HStack{
                  Text("\(address.number) \(address.street)")
                    .font(.body)
                  Spacer()
                  Text(address.city)
                    .font(.subheadline)
                }
                .padding()
                Button(action: {
                  self.addressID = address._id
                  self.showDetails = true
                }) {
                  Text("View Details")
                    .padding()
                    .background(Capsule().opacity(0.2))
                }
              }
            }
          }
        }
      Spacer()
          Button(action: {
              app.currentUser?.logOut() { _ in
                  print("Logged out")
              }
          }) {
            Text("Logout")
              .padding()
              .background(Capsule().opacity(0.2))
          }
      }
    }
}

struct LoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        LoggedIn()
    }
}
