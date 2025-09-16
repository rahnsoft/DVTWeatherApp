//
//  InternetStatusView.swift
//  DVTWeatherApp
//
//  Created by Nick on 15/09/2025.
//

import SwiftUI

struct InternetStatusView: View {
    let lastOnline = Date().formatted(date: .abbreviated, time: .shortened)

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Image(systemName: "wifi.slash")
                    .foregroundColor(Color(.label))
                    .font(.title2)

                Text("No Internet Connection")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(Color(.label))
            }

            Text("Last online: \(lastOnline)")
                .font(.caption2)
                .foregroundColor(Color(.label))
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }
}
