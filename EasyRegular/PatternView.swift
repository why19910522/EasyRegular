//
//  PatternView.swift
//  EasyRegular
//
//  Created by 王洪运 on 2019/8/24.
//  Copyright © 2019 why. All rights reserved.
//

import SwiftUI

struct PatternView: NSViewRepresentable {
    
    var size: NSSize
    
    let textStorageDelegate: TextStorageDelegate = TextStorageDelegate()
        
    func makeNSView(context: NSViewRepresentableContext<PatternView>) -> NSView {
        
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
    
    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<PatternView>) {
        
    }
    
    func onChanged(_ handler: @escaping (String) -> Void) -> PatternView {
        textStorageDelegate.handler = handler
        return self
    }
    
}

extension PatternView {
    
    class TextStorageDelegate: NSObject, NSTextStorageDelegate {
        
        var handler: (String) -> Void = {_ in}
        
        func textStorage(_ textStorage: NSTextStorage, willProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            
        }
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            handler(textStorage.string)
        }
        
    }
    
}
