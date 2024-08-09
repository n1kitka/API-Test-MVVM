//
//  LoaderView.swift
//  LivitaSoftware
//
//  Created by Никита Савенко on 08.08.2024.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2.0, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .red))
    }
}

#Preview {
    LoaderView()
}
