//
//  AddressDetail.swift
//  ObservedCrashEx
//
//  Created by KURT LIBBY on 10/6/21.
//

import SwiftUI
import RealmSwift

struct AddressDetail: View {
    @ObservedRealmObject var address: Address

    var body: some View {
        Text("Street: \(address.street)")
            .font(.title)
    }
}

struct AddressDetail_Previews: PreviewProvider {
    static var previews: some View {
        AddressDetail(address: Address())
    }
}
