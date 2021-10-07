//
//  AddressDetail.swift
//  ObservedCrashEx
//
//  Created by KURT LIBBY on 10/6/21.
//

import SwiftUI
import RealmSwift

struct AddressDetail: View {
    
  @Binding var address: String
  
  @ObservedResults(Address.self) var addresses
  
  var body: some View {
    if let address = addresses.filter("_id = %@", address).first {
      Text("Street: \(address.street)")
        .font(.title)
    }
  }
}

struct AddressDetail_Previews: PreviewProvider {
    static var previews: some View {
      AddressDetail(address: .constant(""))
    }
}
