//
//  ContentView.swift
//  Nerde Yesem
//
//  Created by Berke Can Kandemir on 22.12.2020.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @State private var isShowingSettings: Bool = false
    @ObservedObject var networkingManager = NetworkingManager()
    @AppStorage("status") var logged = false
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            if logged {
                ScrollView(.vertical, showsIndicators: false) {
                    Divider()
                    ForEach(networkingManager.datas) { i in
                        NavigationLink (destination: WebView(url: i.webUrl)) {
                            RestaurantListView(data: i)
                        }
                        Divider()
                    } //: FOR
                } //: SCROLL
                .padding()
                .navigationBarTitle("Nerde Yesem", displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            isShowingSettings = true
                            hapticImpact.impactOccurred()
                    }) {
                        Image(systemName: "slider.horizontal.3")
                        } //: BUTTON
                    .foregroundColor(.accentColor)
                    .sheet(isPresented: $isShowingSettings) {
                        SettingsView()
                    }
                )
            } else {
                Authenticate()
            }
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Authenticate: View {

    @AppStorage("status") var logged = false
    
    var body: some View {
        if !logged {
            Button(action: authenticateUser, label: {
                Image(systemName: LAContext().biometryType == .faceID ? "touchid" : "faceid")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("ColorAppRed"))
                    .clipShape(Circle())
            })
        }
    }
    
    func getBiometricStatus() -> Bool {
        let scanner = LAContext()
        if scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func authenticateUser() {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Açmak için") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            withAnimation(.easeOut) {
                logged = true
                
            }
        }
    }
}
