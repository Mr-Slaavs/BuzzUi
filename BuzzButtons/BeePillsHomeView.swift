//
//  ContentView.swift
//  BuzzButtons
//
//  Created by Alexander Slavny on 7/24/25.
//

import SwiftUI

struct BeePillsHomeView: View {
    @State private var bluetoothConnected = false
    @State private var showChat = false
    @State private var showingSchedule = false
    @State private var showingSettings = false
    @State private var pillSchedules: [PillDosage] = []
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.96, blue: 0.7),  // Light yellow
                    Color(red: 1.0, green: 0.84, blue: 0.4),  // Golden yellow
                    Color(red: 1.0, green: 0.65, blue: 0.2)   // Orange
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Help Button - positioned absolutely
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showChat = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 25)
                    .padding(.top, 60)
                }
                Spacer()
            }
            
            // Main Content - unchanged positioning
            VStack(spacing: 40) {
                Spacer()
                
                // App Logo and Title
                VStack(spacing: 16) {
                    // Bee Icon
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.0, green: 0.2, blue: 0.5)) // Navy blue
                            .frame(width: 140, height: 140)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        
                        Text("💊")
                            .offset(x: -20, y: 30)
                            .font(.system(size: 70))
                            .rotationEffect(.degrees(-20))
                        
                        Text("🐝")
                            .font(.system(size: 85))
                            .offset(x: 0, y: -15)
                            .rotationEffect(.degrees(15))
                        
                        
                    }
                    
                    Text("Bee-Pills")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    
                    Text("Smart Health Done Sweet")
                        .font(.system(size: 21, weight: .medium))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                }
                
                Spacer()
                
                
                // Main Menu Buttons
                VStack(spacing: 34) {
                    // Bluetooth Connection Button
                    Button(action: {
                        bluetoothConnected.toggle()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "cable.connector.horizontal")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(bluetoothConnected ? .white : .black)
                            
                            Image(systemName: bluetoothConnected ? "bluetooth.fill" : "bluetooth")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text(bluetoothConnected ? "Connected to Bee-Pills" : "Connect to Device")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(bluetoothConnected ? .white : .black)
                            
                            Spacer()
                            
                            if bluetoothConnected {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 12, height: 12)
                            }
                            
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(bluetoothConnected ?
                                      Color(red: 0.0, green: 0.2, blue: 0.5) :
                                      Color(red: 1.0, green: 0.65, blue: 0.2))
                                .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Schedule Button
                    Button(action: {
                        showingSchedule = true
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text("Pill Schedule")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.0, green: 0.2, blue: 0.5))
                                .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // Settings Button
                    Button(action: {
                        showingSettings = true
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white)
                            
                            Text("Settings")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.0, green: 0.2, blue: 0.5))
                                .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 25)
                
                Spacer()
                
                // Footer
                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text("🐻")
                            .font(.system(size: 16))
                        Text("T-PREP 2025")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                        Text("🐻")
                            .font(.system(size: 16))
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .fullScreenCover(isPresented: $showingSchedule, onDismiss: {
            showingSchedule = false
        }) {
            PillScheduleView(pillSchedules: $pillSchedules)
        }
        .fullScreenCover(isPresented: $showChat, onDismiss: {
            showChat = false
        }) {
            BeeChatView()
        }
        .fullScreenCover(isPresented: $showingSettings, onDismiss: {
            showingSettings = false
        }) {
            SettingsView()
        }
    }
}

// Preview
struct BeePillsHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BeePillsHomeView()
    }
}
