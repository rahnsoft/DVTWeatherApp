import SwiftUI

struct InternetStatusView: View {
    var isConnected: Bool
    var lastOnline: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isConnected ? "wifi" : "wifi.slash")
                .foregroundColor(isConnected ? .green : .red)
            VStack(alignment: .leading, spacing: 2) {
                Text(isConnected ? "Connected" : "No Internet Connection")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.white)
                Text("Last online: \(lastOnline)")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
        }
        .padding(12)
        .background(Color.black.opacity(0.6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
