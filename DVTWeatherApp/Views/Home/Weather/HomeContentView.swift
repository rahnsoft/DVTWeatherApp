//
//  HomeContentView.swift
//  DVTWeatherApp
//
//  Created by Nick on 15/09/2025.
//
import SwiftUI

// MARK: - BlurView

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blur
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - HomeContentView

struct HomeContentView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab: Int = 1

    var body: some View {
        GeometryReader { geo in
            ZStack {
                switch selectedTab {
                case 0:
                    MapView()

                case 1:
                    WeatherView()
                        .environmentObject(weatherViewModel)

                default:
                    EmptyView()
                }

                VStack {
                    Spacer()
                    HStack {
                        Button(action: { selectedTab = 0 }) {
                            Image(systemName: "map")
                                .font(.system(size: 22))
                                .foregroundColor(selectedTab == 0 ? Color(UIColor.label) : Color.gray)
                                .frame(maxWidth: .infinity)
                        }

                        Button(action: { selectedTab = 1 }) {
                            Image(systemName: "location.fill")
                                .font(.system(size: 12))
                                .foregroundColor(selectedTab == 1 ? Color(UIColor.label) : Color.gray)
                                .frame(maxWidth: .infinity)
                        }

                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 22))
                                .foregroundColor(Color(UIColor.label))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical, 6)
                    .background(
                        BlurView(style: .systemMaterial)
                            .opacity(0.2)
                            .background(Color(weatherViewModel.currentWeatherData?.currentWeather.first?.condition.primaryColor ?? "SunnyPrimary").opacity(0.2))
                            .edgesIgnoringSafeArea(.bottom)
                    )
                }
            }
            
        }
    }
}

// MARK: - MapView

struct MapView: View {
    var body: some View {
        ZStack {
            Color.green
            Text("Map View")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
        .ignoresSafeArea()
    }
}
