//
//  CustomTextfield.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 20/7/24.
//

import SwiftUI

struct CustomTextfield<Icon: View>: View {
    
    let iconPrefix: Icon
    @Binding var text: String
    let placeHolder: String
    let textContentType: UITextContentType
    
    var body: some View {
        HStack {
            customIconPrefix
            textfield
            
        }
    }
}

extension CustomTextfield {
    
    var customIconPrefix: some View {
        iconPrefix
            .foregroundStyle(Color(.systemGray))
            .padding(.trailing, 20)
    }
    
    var textfield: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .textContentType(textContentType)
            Divider()
                .background(Constants.backgroundInvert)
        }
    }
}

#Preview {
    CustomTextfield(iconPrefix: Text("@"), text: .constant(""), placeHolder: "Full name", textContentType: .name)
}
