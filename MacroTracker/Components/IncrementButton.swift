//
//  IncrementButton.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 15/12/2023.
//

import SwiftUI

struct IncrementButton: View {
    @Binding var number: CGFloat
    @State private var timer: Timer?
    @State private var isLongPressing = false
    
    var width: CGFloat
    var color: Color
    
    enum Constants {
        static let imageDivier: CGFloat = 8
        static let opacity: CGFloat = 0.6
        static let fieldMultiplier: CGFloat = 2
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    if(self.isLongPressing) {
                        self.isLongPressing.toggle()
                        self.timer?.invalidate()
                        
                    } else {
                        self.number += 1
                    }
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: self.width, height: self.width)
                }.simultaneousGesture(LongPressGesture(minimumDuration: 0.4).onEnded { _ in
                    self.isLongPressing = true
                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                        self.number += 1
                    })
                })
                .tint(.black)
            }
            .padding()
            .background(Color(self.color).opacity(Constants.opacity))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            HStack {
                TextField("", value: $number, formatter: NumberFormatter())
            }
            .multilineTextAlignment(.center)
            .frame(width: self.width * Constants.fieldMultiplier)
            .font(.system(size: width))
            .bold()
            
            HStack {
                Button(action: {
                    if(self.isLongPressing) {
                        self.isLongPressing.toggle()
                        self.timer?.invalidate()
                        
                    } else {
                        self.number -= 1
                    }
                }, label: {
                    Image(systemName: "minus")
                        .resizable()
                        .frame(width: self.width, height: self.width/Constants.imageDivier)
                        .frame(height: self.width)
                }).simultaneousGesture(LongPressGesture(minimumDuration: 0.4).onEnded { _ in
                    self.isLongPressing = true
                    self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                        self.number -= 1
                    })
                })
                .tint(.black)
            }
            .padding()
            .background(Color(self.color).opacity(Constants.opacity))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding()
    }
}

#Preview {
    IncrementButton(number: .constant(0), width: 30, color: .brown)
}
