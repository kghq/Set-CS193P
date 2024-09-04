//
//  Diamond.swift
//  Set-CS193P
//
//  Created by Krzysztof Garmulewicz on 04/09/2024.
//

import SwiftUI

struct DiamondControl: View {
    var body: some View {
        Diamond()
            .stroke(.red, lineWidth: 10)
            .fill(.red.opacity(0.5))
            .frame(width: 300, height: 300)
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()

        return path
    }
}

#Preview {
    DiamondControl()
}
