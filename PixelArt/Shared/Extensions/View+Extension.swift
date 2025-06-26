//
//  View+Extension.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI

extension View {
    /// Presents an alert with a message when a given condition is true, using a localized string key for a title.
    /// - Parameters:
    ///   - titleKey: The key for the localized string that describes the title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - data: An optional binding of generic type T value, this data will populate the fields of an alert that will be displayed to the user.
    ///   - actionText: The key for the localized string that describes the text of alert's action button.
    ///   - action: The alert’s action given the currently available data.
    ///   - message: A ViewBuilder returning the message for the alert given the currently available data.
    func customAlert<M, T: Hashable>(
        _ titleKey: LocalizedStringKey,
        isPresented: Binding<Bool>,
        presenting data: T?,
        actionText: LocalizedStringKey,
        action: @escaping (T) -> (),
        @ViewBuilder message: @escaping (T) -> M
    ) -> some View where M: View {
        fullScreenCover(isPresented: isPresented) {
            CustomAlertView(
                titleKey,
                isPresented,
                presenting: data,
                actionTextKey: actionText,
                action: action,
                message: message
            )
            .presentationBackground(.clear)
        }
        .transaction { transaction in
            if isPresented.wrappedValue {
                // disable the default FullScreenCover animation
                transaction.disablesAnimations = true

                // add custom animation for presenting and dismissing the FullScreenCover
                transaction.animation = .linear(duration: 0.1)
            }
        }
    }

    /// Presents an alert with a message when a given condition is true, using a localized string key for a title.
    /// - Parameters:
    ///   - titleKey: The key for the localized string that describes the title of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether to present the alert.
    ///   - actionText: The key for the localized string that describes the text of alert's action button.
    ///   - action: Returning the alert’s actions.
    ///   - message: A ViewBuilder returning the message for the alert.
    func customAlert<M>(
        _ titleKey: LocalizedStringKey,
        isPresented: Binding<Bool>,
        actionText: LocalizedStringKey,
        action: @escaping () -> (),
        @ViewBuilder message: @escaping () -> M
    ) -> some View where M: View {
        fullScreenCover(isPresented: isPresented) {
            CustomAlertView(
                titleKey,
                isPresented,
                actionTextKey: actionText,
                action: action,
                message: message
            )
            .presentationBackground(.clear)
        }
        .transaction { transaction in
            if isPresented.wrappedValue {
                // disable the default FullScreenCover animation
                transaction.disablesAnimations = true

                // add custom animation for presenting and dismissing the FullScreenCover
                transaction.animation = .linear(duration: 0.1)
            }
        }
    }
    
    func overlayAlert<M: View>(
            isPresented: Binding<Bool>,
            title: String,
            confirmText: String,
            @ViewBuilder message: @escaping () -> M,
            onConfirm: @escaping () -> Void
        ) -> some View {
            self
                .overlay {
                    if isPresented.wrappedValue {
                        ZStack {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .transition(.opacity)
                            
                            OverlayAlertView(
                                title: title,
                                message: message,
                                confirmText: confirmText,
                                onConfirm: {
                                    isPresented.wrappedValue = false
                                    onConfirm()
                                },
                                onCancel: {
                                    isPresented.wrappedValue = false
                                }
                            )
                            .zIndex(10)
                        }
                        .animation(.easeInOut, value: isPresented.wrappedValue)
                    }
                }
        }
}
