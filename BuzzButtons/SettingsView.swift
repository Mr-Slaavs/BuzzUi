//
//  SettingsView.swift
//  BuzzButtons
//
//  Created by Alexander Slavny on 7/29/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showChat = false
    @State private var selectedAlarmSound = "Default Buzz"
    @State private var silentModeEnabled = false
    @State private var passwordLockEnabled = false
    @State private var showCaretakerSetup = false
    
    let alarmSounds = [
        "Default Buzz",
        "Gentle Chime",
        "Classic Bell",
        "Nature Sounds",
        "Soft Piano",
        "Digital Beep",
        "Add Custom +"
    ]
    
    var body: some View {
        ZStack {
            // Background gradient - matching home screen
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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    // Back Button
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    // Settings Header
                    VStack(spacing: 4) {
                        Text("Settings")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    
                    Spacer()
                    
                    // Help Button - matching home screen
                    Button(action: {
                        showChat = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .padding(.bottom, 20)
                
                // Settings Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Alarm Sound Selector
                        SettingsCard {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                    
                                    Text("Alarm Sound")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                    
                                    Spacer()
                                }
                                
                                Menu {
                                    ForEach(alarmSounds, id: \.self) { sound in
                                        Button(sound) {
                                            selectedAlarmSound = sound
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedAlarmSound)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white.opacity(0.7))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.3), lineWidth: 1)
                                            )
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        // Silent Mode Toggle
                        SettingsCard {
                            HStack {
                                Image(systemName: silentModeEnabled ? "bell.slash.fill" : "bell.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Silent Mode")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                    
                                    Text("Disable all notification sounds")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $silentModeEnabled)
                                    .tint(Color(red: 0.0, green: 0.2, blue: 0.5))
                            }
                        }
                        
                        // Caretaker Mode Setup
                        SettingsCard {
                            Button(action: {
                                showCaretakerSetup = true
                            }) {
                                HStack {
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Caretaker Mode")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                        
                                        Text("Set up monitoring and alerts")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        // Password Lock Toggle
                        SettingsCard {
                            HStack {
                                Image(systemName: passwordLockEnabled ? "lock.fill" : "lock.open.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Password Lock")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                    
                                    Text("Secure app with passcode")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                                }
                                
                                Spacer()
                                
                                Toggle("", isOn: $passwordLockEnabled)
                                    .tint(Color(red: 0.0, green: 0.2, blue: 0.5))
                            }
                        }
                        
                        Spacer()
                            .frame(height: 1)
                        
                        // Team Credits
                        VStack(spacing: 16) {
                            Text("🐝")
                                .font(.system(size: 40))
                            
                            VStack(spacing: 8) {
                                Text("Developed by T-PREP Team")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                
                                VStack(spacing: 4) {
                                    Text("Kyle Shibao")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.8))
                                    
                                    Text("Aldrich Diniz")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.8))
                                    
                                    Text("Alexander Slavny")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.8))
                                    
                                    Text("Manuela Hernandez")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.8))
                                    
                                    Text("Miguel Coronado")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.8))
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 24)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.6))
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .sheet(isPresented: $showCaretakerSetup) {
            CaretakerSetupSheet()
        }
        .fullScreenCover(isPresented: $showChat) {
            BeeChatView()
        }
    }
}

struct SettingsCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.8))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            )
    }
}

struct CaretakerSetupSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.96, blue: 0.7),
                        Color(red: 1.0, green: 0.84, blue: 0.4),
                        Color(red: 1.0, green: 0.65, blue: 0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("👥")
                            .font(.system(size: 40))
                        
                        Text("Caretaker Mode Setup")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                        
                        Text("/\\ Under Construction /\\")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                            .padding(.top, 20)
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Close Button
                    Button("Close") {
                        dismiss()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.0, green: 0.2, blue: 0.5))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
