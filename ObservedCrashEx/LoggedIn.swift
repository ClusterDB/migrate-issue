//
//  LoggedIn.swift
//  ObservedCrashEx
//
//  Created by KURT LIBBY on 10/6/21.
//

import SwiftUI
import RealmSwift

struct LoggedIn: View {
    @ObservedResults(Address.self) var addresses
    
    @State private var showAdd = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Addresses")
                    .font(.title)
                Spacer()
                Button(action: {
                    showAdd.toggle()
                }) {
                    Image(systemName: "plus.circle")
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
                            NavigationLink(destination: AddressDetail(address: address)) {
                                Text("View Details")
                                    .padding()
                                    .background(Capsule().opacity(0.2))
                            }
                        }
                    }
                }
            }
            NavigationLink(destination: AddAddress().environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(app.currentUser!.id)")), isActive: $showAdd) {
                EmptyView()
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
