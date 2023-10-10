//
//  File.swift
//  
//
//  Created by Martin Kock on 09/10/2023.
//

import Foundation
import SwiftUI

struct ContentView: View {
      @State var colorIsRed = true
      @State var color = Color.red
      @State var text = ""
      @State var sliderVal: Float = 0.5
      var body: some View {
            
         
            ScrollView {
                  //UIView
                  Text("UIView")
                  UIViewWithRepresentable(color: $color)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        .onTapGesture {
                              colorIsRed.toggle()
                              color = colorIsRed ? Color.red : Color.blue
                        }
                  
                  
                  // Textfield
                  Text("UITextField")
                  UITextFieldWithRepresentable(text: $text)
                        .background(Color.red)
                        .frame(height: 100)
                  Text(" \(text)")
                  
                  // Slider
                  Text("UISlider")
                  Slider(value: $sliderVal)
                  UISliderWithRepresentable(sliderVal: $sliderVal)
                  Text("\(sliderVal)")
            }
      }
}

#Preview {
      ContentView()
}

struct UIViewWithRepresentable: UIViewRepresentable {
      @Binding var color: Color
      
      class Coordinator: NSObject {
            @Binding var color: Color
            var parent: UIViewWithRepresentable
            
            init(color: Binding<Color>, _ parent: UIViewWithRepresentable) {
                  self.parent = parent
                  self._color = color
            }
      }
      
      func makeUIView(context: Context) -> UIView {
            let view = UIView()
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

struct UITextFieldWithRepresentable: UIViewRepresentable {
      @Binding var text: String
      func makeCoordinator() -> Coordinator {
            Coordinator(text: $text, parent: self)
      }
      
      func makeUIView(context: Context) -> UITextField {
            let textField = UITextField()
            textField.attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField.delegate = context.coordinator
            
            return textField
      }
      
      func updateUIView(_ uiView: UITextField, context: Context) {
            uiView.text = text
            uiView.textAlignment = .center
      }
      
      typealias UIViewType = UITextField
      
      class Coordinator: NSObject, UITextFieldDelegate {
            @Binding var text: String
            var parent: UITextFieldWithRepresentable
            
            init(text: Binding<String>, parent: UITextFieldWithRepresentable) {
                  self._text = text
                  self.parent = parent
                  
            }
            
            func textFieldDidChangeSelection(_ textField: UITextField) {
                  text = textField.text ?? ""
            }
            
         // show keyboard
            func textFieldDidBeginEditing(_ textField: UITextField) {
                  textField.becomeFirstResponder()
            }
            
            // hide keyboard
            func textFieldDidEndEditing(_ textField: UITextField) {
                  textField.resignFirstResponder()
            }
            
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                  textField.resignFirstResponder()
                  return true
            }
      
            
      
      }
}

struct UISliderWithRepresentable: UIViewRepresentable {
      @Binding var sliderVal: Float
      func makeCoordinator() -> Coordinator {
            Coordinator(sliderVal: $sliderVal, parent: self)
      }
      
      
      func makeUIView(context: Context) -> UISlider {
            let slider = UISlider()
            slider.value = sliderVal
            slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderDidChange(_:)), for: .valueChanged)
            
            return slider
      }
      
      func updateUIView(_ uiView: UISlider, context: Context) {
            uiView.value = sliderVal
      }
      
      class Coordinator: NSObject {
            @Binding var sliderVal: Float
            
            var parent: UISliderWithRepresentable
            
            init(sliderVal: Binding<Float>, parent: UISliderWithRepresentable) {
                  self._sliderVal = sliderVal
                  self.parent = parent
            }
            
            @objc func sliderDidChange(_ sender: UISlider) {
                  sliderVal = sender.value
            }
            
            
            
      }
      
      typealias UIViewType = UISlider
      
      
}

