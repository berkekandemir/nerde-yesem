//
//  SettingsLabelView.swift
//  Nerde Yesem
//
//  Created by Berke Can Kandemir on 22.12.2020.
//

import SwiftUI

struct SettingsLabelView: View {
    // MARK: - PROPERTIES
    
    var labelText: String
    var labelImage: String
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        } //: HSTACK
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "Nerde Yesem", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

