//
//  File.swift
//  
//
//  Created by Martin Kock on 09/10/2023.
//

import Foundation

/// Example of creating a UIView and changing color based on SwiftUI State

struct Testing: UIViewRepresentable {
    @Binding var color: Color
    
    
    
    class Coordinator: NSObject {
        @Binding var color: Color
        var parent: Testing
        
        init(color: Binding<Color>, _ parent: Testing) {
            self.parent = parent
            self._color = color
        }
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor
 
        return view
    
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let color = UIColor(color)
        uiView.backgroundColor = color
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(color: $color, self)
    }
    
    typealias UIViewType = UIView
}
