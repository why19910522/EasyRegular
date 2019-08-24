//
//  ContentView.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/7/2.
//  Copyright © 2019 why. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject var inputData: InputData
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Text("Easy Regular")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                Spacer()
            }
            
            Section(header: HStack {
                Text("Pattern:")
                    .font(.title)
                    .foregroundColor(.accentColor)
                Spacer()
            }) {
                PatternView(size: NSSize(width: 800, height: 100))
                    .onChanged { (string) in
                        self.inputData.pattern.string = string
                    }
            }
            
            Section(header: HStack {
                Text("Text:")
                    .font(.title)
                    .foregroundColor(.accentColor)
                Spacer()
            }) {
                TextView(pattern: inputData.$pattern, size: NSSize(width: 800, height: 100))
            }
            
            OptionsView()
            
            MatchingOptionsView()
            
        }
        .frame(minHeight: 700)
        .padding()
        .padding(.bottom, 20)
    }
    
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(InputData())
    }
}
#endif
