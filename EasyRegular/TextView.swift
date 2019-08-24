//
//  TextView.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/8/22.
//  Copyright © 2019 why. All rights reserved.
//

import SwiftUI
import Combine

struct TextView: NSViewRepresentable {
    
    var size: NSSize
    
    let textStorageDelegate: TextStorageDelegate
    
    let cancellbale: AnyCancellable
    
    init<T: Publisher>(pattern: T, size: NSSize) where T.Output == PatternModel, T.Failure == Never {
        self.size = size
        let textStorageDelegate = TextStorageDelegate()
        self.textStorageDelegate = textStorageDelegate
        
        cancellbale = pattern.sink(receiveValue: { (model) in
            textStorageDelegate.set(pattern: model, textStorage: nil)
        })
        
    }
    
    func makeNSView(context: NSViewRepresentableContext<TextView>) -> NSView {
        
        let scrolleView = NSScrollView(frame: NSRect(origin: .zero, size: size))
        scrolleView.hasVerticalScroller = true
        scrolleView.hasHorizontalRuler = false
        
        let textView = NSTextView(frame: NSRect(origin: .zero, size: size))
        textView.textContainerInset = NSSize(width: 5, height: 5)
        textView.font = NSFont.systemFont(ofSize: 20)
        textView.minSize = NSSize(width: 0, height: size.height)
        textView.maxSize = NSSize(width: CGFloat.infinity, height: CGFloat.infinity)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = false
        textView.textContainer?.containerSize = NSSize(width: CGFloat.infinity, height: CGFloat.infinity)
        textView.textContainer?.widthTracksTextView = true
        textView.textStorage?.delegate = textStorageDelegate
        
        scrolleView.documentView = textView
        
        return scrolleView
    }
    
    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<TextView>) {
        
    }
    
}

extension TextView {
    
    class TextStorageDelegate: NSObject, NSTextStorageDelegate {
        
        var pattern = PatternModel()
        var textStorage: NSTextStorage?
        
        func set(pattern: PatternModel, textStorage: NSTextStorage?) {
            self.pattern = pattern
            
            if let textStorage = textStorage {
                self.textStorage = textStorage
            }
            
            if let textStorage = self.textStorage {
                regex(textStorage: textStorage, with: pattern)
            }
            
        }
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            regex(textStorage: textStorage, with: pattern)
            self.textStorage = textStorage
        }
        
        func regex(textStorage: NSTextStorage, with pattern: PatternModel) {
            
            let totalRange = NSRange(location: 0, length: textStorage.string.count)
            
            let new = NSMutableAttributedString(string: textStorage.string,
                                                attributes: [.font: NSFont.systemFont(ofSize: 20),
                                                             .foregroundColor: NSColor(named: "string")!])
            
            do {
                let expression = try NSRegularExpression(pattern: pattern.string,
                                                         options: pattern.options)
                let results = expression.matches(in: textStorage.string,
                                                 options: pattern.matchingOptions,
                                                range: totalRange)
                
                results.forEach {
                    new.setAttributes([.font: NSFont.systemFont(ofSize: 20),
                                       .foregroundColor: NSColor.red],
                                      range: $0.range)
                }
                
                textStorage.replaceCharacters(in: totalRange, with: new)
            } catch {
                print("why \(error)")
            }
        }
    }
    
}

fileprivate extension NSRange {
    
    func split(with ranges: [NSRange]) -> [NSRange] {
        
        var index = 0
        
        var results = [NSRange]()
        
        ranges.sorted(by: {$0.location < $1.location})
            .forEach { (range) in
                if index >= length {
                    return
                }
                
                if range.location > index {
                    results.append(NSRange(location: index, length: range.location-index))
                }
                
                index = range.location + range.length
            }
        
        if index < length {
            results.append(NSRange(location: index, length: length-index))
        }
        
        return results
    }
    
}



