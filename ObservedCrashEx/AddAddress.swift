//
//  AddAddress.swift
//  ObservedCrashEx
//
//  Created by KURT LIBBY on 10/6/21.
//

import SwiftUI

struct AddAddress: View {
  @State private var number = ""
  @State private var street = ""
  @State private var city = ""
  
  @Binding var showAdd: Bool
  
  @Environment(\.realm) var userRealm
  
  var body: some View {
    VStack(alignment: .leading){
      HStack{
        Text("New Address")
          .bold()
        Spacer()
        Button(action: addAddress) {
          Text("+ ADD")
            .disabled(number == "" || street == "" || city == "")
        }
        .padding()
        .background(Capsule().opacity(0.2))
      }
      TextField("Number", text: $number)
        .keyboardType(.numberPad)
      TextField("Street", text: $street)
      TextField("City", text: $city)
      Spacer()
    }
    .padding()
  }
  
  private func addAddress() {
    let address = Address(
      id: UUID().uuidString,
      partition: "user=\(app.currentUser!.id)",
      number: Int(self.number) ?? 123,
      street: self.street,
      city: self.city,
      state: ""
    )
    
    do {
      try! userRealm.write{
        userRealm.add(address)
      }
      self.showAdd = false
    }
  }
}

struct AddAddress_Previews: PreviewProvider {
    static var previews: some View {
      AddAddress(showAdd: .constant(false))
    }
}
