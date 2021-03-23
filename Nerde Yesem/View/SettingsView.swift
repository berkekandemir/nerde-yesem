//
//  SettingsView.swift
//  Nerde Yesem
//
//  Created by Berke Can Kandemir on 22.12.2020.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("status") var logged = true
    
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    GroupBox(label: SettingsLabelView(labelText: "Nerde Yesem", labelImage: "info.circle")) {
                        
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            
                            Text("Acıktın ve bir an önce nerede yemek yiyebilirim mi diyorsun? Tam da ihtiyacın olduğunda seni yemeğe ulaştırmak için buradayız.")
                                .font(.footnote)
                            
                        } //: HSTACK
                    } //: BOX
                    
                    if logged {
                        GroupBox(
                            label: SettingsLabelView(labelText: "Biyometrik", labelImage: "person.fill.viewfinder")
                        ) {
                            Divider().padding(.vertical, 4)
                            
                            Text("Biyometrik veriler ile girişi yeniden aktifleştirmek için anahtarı kapalı hale getirmelisin.")
                                .padding(.vertical, 8)
                                .frame(minHeight: 60)
                                .layoutPriority(1)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                            
                            Toggle(isOn: $logged) {
                                if logged {
                                    Text("Giriş yapıldı".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.green)
                                } else {
                                    Text("Giriş yapılmadı".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.secondary)
                                }
                            }
                            .padding()
                            .background(
                                Color(UIColor.tertiarySystemBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            )
                        } //: BOX
                    }
                    
                    GroupBox (label: SettingsLabelView(labelText: "Uygulama Hakkında", labelImage: "apps.iphone")) {
                        SettingsRowView(name: "Geliştirici", content: "Berke Can Kandemir")
                        SettingsRowView(name: "Websitesi", linkLabel: "LinkedIn", linkDestination: "www.linkedin.com/in/berke-can-kandemir/")
                        SettingsRowView(name: "Github", linkLabel: "Github", linkDestination: "github.com/berkekandemir")
                        SettingsRowView(name: "Versiyon", content: "1.0.0")
                        
                    } //: BOX
                } //: VSTACK
            } //: SCROLL
            .padding()
            .navigationBarTitle(Text("Ayarlar"), displayMode: .large)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        hapticImpact.impactOccurred()
                    }) {
                    Image(systemName: "xmark")
                    } //: BUTTON
                    .foregroundColor(Color("ColorAppRed"))
            )
        } //: NAVIGATION
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
