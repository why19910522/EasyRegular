//
//  InputData.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/8/23.
//  Copyright © 2019 why. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class InputData: ObservableObject {
    
    var objectWillChange = PassthroughSubject<PatternModel, Never>()
    
    @Published var pattern = PatternModel()
    
}

struct PatternModel {
    
    var string = ""
    var options: NSRegularExpression.Options = []
    var matchingOptions: NSRegularExpression.MatchingOptions = []
    
}
