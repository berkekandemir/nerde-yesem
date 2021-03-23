//
//  RestaurantListView.swift
//  Nerde Yesem
//
//  Created by Berke Can Kandemir on 22.12.2020.
//

import SwiftUI

struct RestaurantListView: View {
    
    // MARK: - PROPERTIES
    
    let data: datatype
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            HStack {
                Text(data.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                    .padding(.trailing)
                Spacer()
            } //: HSTACK
        } //: VSTACK
        .frame(width: 350, height: 60)
    }
}

// MARK: - PREVIEW

struct RestaurantListView_Previews: PreviewProvider {
    
    static var previews: some View {
        RestaurantListView(data: datatype(id: "112233", name: "Beğendik Abi", webUrl: "https://www.zomato.com/", location: Type4(latitude: "38.434334", longitude: "28.475674")))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

