//
//  ContentView.swift
//  ObservedCrashEx
//
//  Created by KURT LIBBY on 10/6/21.
//

import SwiftUI
import RealmSwift

class Address: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var _id: String = UUID().uuidString
  @Persisted var _partition: String = ""
  @Persisted var number: Int = 0
  @Persisted var street: String = ""
  @Persisted var city: String = ""
    // TODO: Uncomment
//  @Persisted var state: String? = ""
  
  convenience init(id: String,
                   partition: String,
                   number: Int,
                   street: String,
                   city: String,
                   state: String) {
    self.init()
    self._id = id
    self._partition = partition
    self.number = number
    self.street = street
    self.city = city
      // TODO: Uncomment
//    self.state = state
  }
}

extension Address: Identifiable {
  var id: String { _id }
}

let app = App(id: "kurt-rhbjo")

struct ContentView: View {
  @State private var loggedIn = false
  
  var body: some View {
    if app.currentUser != nil || loggedIn {
      LoggedIn()
        .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(app.currentUser!.id)"))
    } else {
      Spacer()
        .onAppear(perform: login )
    }
  }
  
  private func login() {
    app.login(credentials: Credentials.anonymous) { result in
      switch result {
      case .failure(let error):
        print("Login failed with \(error)")
      case .success(let user):
        print("Login successful with \(user)")
        self.loggedIn = true
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
