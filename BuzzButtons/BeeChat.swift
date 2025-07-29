//
//  BeeChatView.swift
//  BuzzButtons
//
//  Created by Alexander Slavny on 7/29/25.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct BeeChatView: View {
    @State private var messages: [ChatMessage] = []
    @State private var currentMessage = ""
    @State private var isTyping = false
    @Environment(\.dismiss) private var dismiss
    
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
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    // Chat Header with Bee
                    HStack(spacing: 8) {
                        Text("🐝")
                            .font(.system(size: 28))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Bee Chat")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                            
                            Text("AI Assistant")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                        }
                    }
                    
                    Spacer()
                    
                    // Space for consistent layout with home screen
                    Spacer()
                        .frame(width: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 15)
                
                // Chat Messages Area
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            if messages.isEmpty {
                                // Welcome Message
                                VStack(spacing: 20) {
                                    Spacer()
                                        .frame(height: 100)
                                    
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: 0.0, green: 0.2, blue: 0.5))
                                            .frame(width: 80, height: 80)
                                            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
                                        
                                        Text("🐝")
                                            .font(.system(size: 45))
                                    }
                                    
                                    VStack(spacing: 8) {
                                        Text("Hello! I'm your Bee Chat assistant!")
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                                        
                                        Text("Ask me anything about your health, medications, or general questions.")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.7))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 30)
                                    }
                                    
                                    Spacer()
                                }
                            }
                            
                            ForEach(messages) { message in
                                ChatBubbleView(message: message)
                                    .id(message.id)
                            }
                            
                            if isTyping {
                                TypingIndicatorView()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                    .onChange(of: messages.count) {
                        if let lastMessage = messages.last {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input Area
                VStack(spacing: 0) {
                    Divider()
                        .background(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.2))
                    
                    HStack(spacing: 12) {
                        TextField("Ask me anything...", text: $currentMessage)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.8))
                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                            )
                        
                        Button(action: sendMessage) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .fill(currentMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
                                              Color.gray : Color(red: 0.0, green: 0.2, blue: 0.5))
                                        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(currentMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(red: 1.0, green: 0.96, blue: 0.7).opacity(0.9))
                }
            }
        }
        .onAppear {
            // Initialize with welcome message if needed
        }
    }
    
    private func sendMessage() {
        let messageContent = currentMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !messageContent.isEmpty else { return }
        
        // Add user message
        let userMessage = ChatMessage(content: messageContent, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        // Clear input
        currentMessage = ""
        
        // Show typing indicator
        isTyping = true
        
        // Simulate AI response delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = false
            let botResponse = ChatMessage(content: "This Feature is coming soon...", isUser: false, timestamp: Date())
            messages.append(botResponse)
        }
    }
}

struct ChatBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color(red: 0.0, green: 0.2, blue: 0.5))
                        )
                    
                    Text(formatTime(message.timestamp))
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.6))
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: .trailing)
            } else {
                HStack(alignment: .top, spacing: 8) {
                    Text("🐝")
                        .font(.system(size: 20))
                        .offset(y: 2)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(message.content)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(Color.white.opacity(0.9))
                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                            )
                        
                        Text(formatTime(message.timestamp))
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.6))
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                }
                
                Spacer()
            }
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TypingIndicatorView: View {
    @State private var animating = false
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 8) {
                Text("🐝")
                    .font(.system(size: 20))
                    .offset(y: 2)
                
                HStack(spacing: 4) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color(red: 0.0, green: 0.2, blue: 0.5).opacity(0.6))
                            .frame(width: 8, height: 8)
                            .scaleEffect(animating ? 1.2 : 0.8)
                            .animation(
                                .easeInOut(duration: 0.6)
                                .repeatForever()
                                .delay(Double(index) * 0.2),
                                value: animating
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                )
            }
            
            Spacer()
        }
        .onAppear {
            animating = true
        }
    }
}

// Preview
struct BeeChatView_Previews: PreviewProvider {
    static var previews: some View {
        BeeChatView()
    }
}
