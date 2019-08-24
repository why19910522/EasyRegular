//
//  ToggleButton.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/8/24.
//  Copyright © 2019 why. All rights reserved.
//

import SwiftUI

struct ToggleButton: View {
    
    let title: String
    
    @Binding var isOn: Bool
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Toggle(title, isOn: $isOn)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}
