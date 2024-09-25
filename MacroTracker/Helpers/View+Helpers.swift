//
//  View+Helpers.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 11/09/2024.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() -> some View {
        modifier(hideKeyboardModifier())
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CornerRadiusShape(corners: corners, radius: radius))
    }
}

struct hideKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white.opacity(0.01))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

struct CornerRadiusShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
