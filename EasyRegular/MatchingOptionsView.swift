//
//  MatchingOptionsView.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/8/24.
//  Copyright © 2019 why. All rights reserved.
//

import SwiftUI

struct MatchingOptionsView: View {
    
    @EnvironmentObject var inputData: InputData
    
    @State var isReportProgress = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isReportCompletion = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isAnchored = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isTransparentBounds = false {
        didSet {
            updateOptions()
        }
    }
    
    @State var isAnchoringBounds = true {
        didSet {
            updateOptions()
        }
    }
    
    var body: some View {
        Section(header: HStack {
            Text("MatchingOptions:")
            Spacer()
        }) {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ToggleButton(title: "Anchored", isOn: $isAnchored) {
                        self.isAnchored.toggle()
                    }
                    ToggleButton(title: "ReportProgress", isOn: $isReportProgress) {
                        self.isReportProgress.toggle()
                    }
                    ToggleButton(title: "ReportCompletion", isOn: $isReportCompletion) {
                        self.isReportCompletion.toggle()
                    }
                    Spacer()
                }
                
                HStack(spacing: 10) {
                    ToggleButton(title: "TransparentBounds", isOn: $isTransparentBounds) {
                        self.isTransparentBounds.toggle()
                    }
                    ToggleButton(title: "AnchoringBounds", isOn: $isAnchoringBounds) {
                        self.isAnchoringBounds.toggle()
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
        var options: NSRegularExpression.MatchingOptions = []
        
        if isAnchored { options.insert(.anchored) }
        if isReportProgress { options.insert(.reportProgress) }
        if isReportCompletion { options.insert(.reportCompletion)  }
        if isTransparentBounds { options.insert(.withTransparentBounds) }
        if !isAnchoringBounds { options.insert(.withoutAnchoringBounds) }
        
        inputData.pattern.matchingOptions = options
    }
    
}
