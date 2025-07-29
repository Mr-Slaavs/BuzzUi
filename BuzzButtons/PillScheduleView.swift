//
//  PillScheduleView.swift
//  BuzzButtons
//
//  Created by Alexander Slavny on 7/28/25.
//

import SwiftUI

struct PillDosage: Identifiable {
    let id = UUID()
    var pillName: String
    var dosage: String
    var time: Date
    var frequency: String
}

struct PillScheduleView: View {
    @Binding var pillSchedules: [PillDosage]
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingAddSchedule = false
    @State private var newPillName = ""
    @State private var newDosage = ""
    @State private var newTime = Date()
    @State private var newFrequency = "Daily"
    
    let frequencies = ["Daily", "Twice Daily", "Weekly", "As Needed"]
    
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
            
            VStack(spacing: 0) {
                // Header with Logo and Title
                HStack {
                    // Logo Button (navigates back to home)
                    Button(action: {
                        dismiss()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.0, green: 0.2, blue: 0.5))
                                .frame(width: 60, height: 60)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                            
                            Text("💊")
                                .offset(x: -8, y: 12)
                                .font(.system(size: 28))
                                .rotationEffect(.degrees(-20))
                            
                            Text("🐝")
                                .font(.system(size: 34))
                                .offset(x: 0, y: -6)
                                .rotationEffect(.degrees(15))
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        Text("Pill Schedule")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                        
                        Text("Manage Your Doses")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                    }
                    
                    Spacer()
                    
                    // Add Button
                    Button(action: {
                        showingAddSchedule = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                .padding(.bottom, 20)
                
                // Schedule List
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(pillSchedules) { schedule in
                            PillScheduleCard(schedule: schedule) {
                                // Delete action
                                if let index = pillSchedules.firstIndex(where: { $0.id == schedule.id }) {
                                    pillSchedules.remove(at: index)
                                }
                            }
                        }
                        
                        if pillSchedules.isEmpty {
                            EmptyScheduleView()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .sheet(isPresented: $showingAddSchedule) {
            AddScheduleSheet(
                pillName: $newPillName,
                dosage: $newDosage,
                time: $newTime,
                frequency: $newFrequency,
                frequencies: frequencies,
                onSave: {
                    let newSchedule = PillDosage(
                        pillName: newPillName,
                        dosage: newDosage,
                        time: newTime,
                        frequency: newFrequency
                    )
                    pillSchedules.append(newSchedule)
                    
                    // Reset form
                    newPillName = ""
                    newDosage = ""
                    newTime = Date()
                    newFrequency = "Daily"
                    
                    showingAddSchedule = false
                },
                onCancel: {
                    showingAddSchedule = false
                }
            )
        }
    }
}

struct PillScheduleCard: View {
    let schedule: PillDosage
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Time Display
            VStack(spacing: 4) {
                Text(schedule.time, style: .time)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                
                Text(schedule.frequency)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
            }
            .frame(width: 80)
            
            // Pill Info
            VStack(alignment: .leading, spacing: 6) {
                Text(schedule.pillName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                
                Text(schedule.dosage)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
            }
            
            Spacer()
            
            // Delete Button
            Button(action: onDelete) {
                Image(systemName: "trash.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.red.opacity(0.7))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

struct EmptyScheduleView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("🍯")
                .font(.system(size: 50))
            
            Text("No Pills Scheduled")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
            
            Text("Tap the + button to add your first pill schedule")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.6))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.top, 60)
    }
}

struct AddScheduleSheet: View {
    @Binding var pillName: String
    @Binding var dosage: String
    @Binding var time: Date
    @Binding var frequency: String
    let frequencies: [String]
    let onSave: () -> Void
    let onCancel: () -> Void
    
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
                        Text("🐝")
                            .font(.system(size: 40))
                        
                        Text("Add New Schedule")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    .padding(.top, 20)
                    
                    // Form
                    VStack(spacing: 20) {
                        // Pill Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Pill Name")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                            
                            TextField("Enter pill name", text: $pillName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Dosage
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Dosage")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                            
                            TextField("e.g., 500mg, 1 tablet", text: $dosage)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Time
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Time")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                            
                            DatePicker("Select time", selection: $time, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(8)
                        }
                        
                        // Frequency
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Frequency")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                            
                            Picker("Frequency", selection: $frequency) {
                                ForEach(frequencies, id: \.self) { freq in
                                    Text(freq).tag(freq)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button("Cancel") {
                            onCancel()
                        }
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        
                        Button("Save Schedule") {
                            onSave()
                        }
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.0, green: 0.2, blue: 0.5))
                        .cornerRadius(12)
                        .disabled(pillName.isEmpty || dosage.isEmpty)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Preview
struct PillScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        PillScheduleView(pillSchedules: .constant([
            PillDosage(pillName: "Vitamin D", dosage: "1000 IU", time: Date(), frequency: "Daily")
        ]))
    }
}
