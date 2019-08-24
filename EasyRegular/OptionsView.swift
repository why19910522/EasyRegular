//
//  OptionsView.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/8/24.
//  Copyright © 2019 why. All rights reserved.
//

import SwiftUI

struct OptionsView: View {
    
    @EnvironmentObject var inputData: InputData
    
    @State var isCaseInsensitive = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isAnchorsMatchLines = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isIgnoreMetacharacters = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isUseUnixLineSeparators = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isUseUnicodeWordBoundaries = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isDotMatchesLineSeparators = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isAllowCommentsAndWhitespace = false {
        didSet {
            updateOptions()
        }
    }
    
    var body: some View {
        Section(header: HStack {
            Text("Options:")
            Spacer()
        }) {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ToggleButton(title: "CaseInsensitive", isOn: $isCaseInsensitive) {
                        self.isCaseInsensitive.toggle()
                    }
                    ToggleButton(title: "AnchorsMatchLines", isOn: $isAnchorsMatchLines) {
                        self.isAnchorsMatchLines.toggle()
                    }
                    ToggleButton(title: "IgnoreMetacharacters", isOn: $isIgnoreMetacharacters) {
                        self.isIgnoreMetacharacters.toggle()
                    }
                    ToggleButton(title: "UseUnixLineSeparators", isOn: $isUseUnixLineSeparators) {
                        self.isUseUnixLineSeparators.toggle()
                    }
                    Spacer()
                }
                
                HStack(spacing: 10) {
                    ToggleButton(title: "UseUnicodeWordBoundaries", isOn: $isUseUnicodeWordBoundaries) {
                        self.isUseUnicodeWordBoundaries.toggle()
                    }
                    ToggleButton(title: "DotMatchesLineSeparators", isOn: $isDotMatchesLineSeparators) {
                        self.isDotMatchesLineSeparators.toggle()
                    }
                    ToggleButton(title: "AllowCommentsAndWhitespace", isOn: $isAllowCommentsAndWhitespace) {
                        self.isAllowCommentsAndWhitespace.toggle()
                    }
                    Spacer()
                }
            }
            
        }
        .font(.headline)
        .foregroundColor(.string)
        .frame(minWidth: 800)
    }
    
    func updateOptions() {
        var options: NSRegularExpression.Options = []
        
        if isCaseInsensitive { options.insert(.caseInsensitive) }
        if isAnchorsMatchLines { options.insert(.anchorsMatchLines)  }
        if isIgnoreMetacharacters { options.insert(.ignoreMetacharacters) }
        if isUseUnixLineSeparators { options.insert(.useUnixLineSeparators) }
        if isUseUnicodeWordBoundaries { options.insert(.useUnicodeWordBoundaries) }
        if isDotMatchesLineSeparators { options.insert(.dotMatchesLineSeparators) }
        if isAllowCommentsAndWhitespace { options.insert(.allowCommentsAndWhitespace) }
        
        inputData.pattern.options = options
    }
    
}
