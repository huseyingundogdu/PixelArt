//
//  CustomAlertView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI


struct CustomAlertView<T: Hashable, M: View>: View {
    
    @Namespace private var namespace
    
    @Binding private var isPresented: Bool
    @State private var titleKey: LocalizedStringKey
    @State private var actionTextKey: LocalizedStringKey
    
    private var data: T?
    private var actionWithValue: ((T) -> ())?
    private var messageWithValue: ((T) -> M)?
    
    private var action: (() -> ())?
    private var message: (() -> M)?
    
    // Animation
    @State private var isAnimating = false
    private let animationDuration = 0
    
    init(
        _ titleKey: LocalizedStringKey,
        _ isPresented: Binding<Bool>,
        presenting data: T?,
        actionTextKey: LocalizedStringKey,
        action: @escaping (T) -> (),
        @ViewBuilder message: @escaping (T) -> M
    ) {
        _titleKey = State(wrappedValue: titleKey)
        _actionTextKey = State(wrappedValue: actionTextKey)
        _isPresented = isPresented
        
        self.data = data
        self.action = nil
        self.message = nil
        self.actionWithValue = action
        self.messageWithValue = message
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .opacity(isPresented ? 0.6 : 0)
                .zIndex(1)
            
            if isAnimating {
                VStack {
                    VStack {
                        /// Title
                        Text(titleKey)
                            
                            .foregroundStyle(.black)
                            .padding(8)
                        
                        /// Message
                        Group {
                            if let data, let messageWithValue {
                                messageWithValue(data)
                            } else if let message {
                                message()
                            }
                        }
                        .multilineTextAlignment(.center)
                        
                        /// Buttons
                        HStack {
                            CancelButton
                            DoneButton
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .pixelBackground(paddingValue: 10)
                }
                .padding()
                .zIndex(2)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            show()
        }
    }
    
    // MARK: Buttons
    var CancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .pixelBackground(paddingValue: 10)
        }
    }
    
    var DoneButton: some View {
        Button {
            dismiss()
            
            if let data, let actionWithValue {
                actionWithValue(data)
            } else if let action {
                action()
            }
        } label: {
            Text(actionTextKey)
                
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .pixelBackground(paddingValue: 10)
        }
    }
    
    func dismiss() {
        
        isAnimating = false
        isPresented = false
    }
    
    func show() {
        
        isAnimating = true
        
    }
}

// MARK: - Overload
extension CustomAlertView where T == Never {
    
    init(
        _ titleKey: LocalizedStringKey,
        _ isPresented: Binding<Bool>,
        actionTextKey: LocalizedStringKey,
        action: @escaping () -> (),
        @ViewBuilder message: @escaping () -> M
    ) where T == Never {
        _titleKey = State(wrappedValue: titleKey)
        _actionTextKey = State(wrappedValue: actionTextKey)
        _isPresented = isPresented
        
        self.data = nil
        self.action = action
        self.message = message
        self.actionWithValue = nil
        self.messageWithValue = nil
    }
}

// MARK: - Preview
struct CustomAlertPreview: View {
    @State private var isPresented = true
    @State private var test = "Some Value"
    
    var body: some View {
        VStack {
            Button("Show Alert") {
                isPresented = true
            }
            .customAlert(
                "Alert Title",
                isPresented: $isPresented,
                presenting: test,
                actionText: "Yes, Done"
            ) { value in
                // Action...
            } message: { value in
                Text("Showing alert for \(value)… And adding a long text for preview.")
                    
            }
        }
    }
}

#Preview {
    VStack {
        CustomAlertPreview()
    }
}
