// MARK: - ForecastRow (Reusable)
struct ForecastRow: View {
    let day: ForecastDayDisplay
    let isToday: Bool
    
    private let dayColumnWidth: CGFloat = 80
    
    var body: some View {
        HStack {
            // Day Name
            Text(day.dayName)
                .font(.system(size: 16, weight: isToday ? .semibold : .medium))
                .foregroundColor(.white)
                .frame(width: dayColumnWidth, alignment: .leading)

            Spacer()
            
            // Weather Icon
            Image(day.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.trailing, 8)

            Spacer()

            // Precipitation %
            if day.precipitationProbability != "0%" {
                Text(day.precipitationProbability)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
                    .frame(width: 35)
            } else {
                Spacer().frame(width: 35)
            }

            Spacer()
            
            // Low / High
            HStack(spacing: 16) {
                Text(day.lowTemp)
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.7))

                Text(day.highTemp)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(minWidth: 68)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white.opacity(isToday ? 0.2 : 0.1))
        .cornerRadius(8)
    }
}
