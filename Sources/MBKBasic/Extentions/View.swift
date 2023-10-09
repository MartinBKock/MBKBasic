//
//  File.swift
//  
//
//  Created by Martin Kock on 29/09/2023.
//

import Foundation
import SwiftUI

/// Header view
@available(iOS 14.0, *)
struct HeaderView: View {
    var title: String = ""
    var font: Font = .title
    var body: some View {
        Text(title)
            .font(font)
            .bold()
            .padding(.top, 16)
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
        
    }
    /// Horizontal scrollview
    struct HorizontalScrollView<Model, Content>: View where Model: Hashable, Content: View {
        var arrToShow: [Model]
        let content: (Model) -> Content
        
        init(arrToShow: [Model], @ViewBuilder content: @escaping (Model) -> Content) {
            self.arrToShow = arrToShow
            self.content = content
        }
        
        var body: some View {
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center) {
                    ForEach(arrToShow, id: \.self) { model in
                        content(model)
                    }
                }
            }
            .padding(.top, -16)
        }
    }
}


