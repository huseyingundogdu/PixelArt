//
//  LoadingState.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/05/2025.
//

import Foundation
import SwiftUI

enum LoadingState<T: Codable & Equatable>: Equatable {
    case none
    case loading
    case success(T)
    case error(Error)
    
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none), (.loading, .loading):
            return true
        case let (.success(lhsValue), .success(rhsValue)):
            return lhsValue == rhsValue
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

struct LoadingWrapperView<T: Codable & Equatable, Content: View, LoadingContent: View, SuccessContent: View, FailureContent: View>: View {
    
    let loadingState: LoadingState<T>
    let content: () -> Content
    let loadingContent: () -> LoadingContent
    let successContent: (T) -> SuccessContent
    let errorContent: (Error) -> FailureContent
    
    init(loadingState: LoadingState<T>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder loadingContent: @escaping () -> LoadingContent, @ViewBuilder successContent: @escaping (T) -> SuccessContent, @ViewBuilder errorContent: @escaping (Error) -> FailureContent) {
        self.loadingState = loadingState
        self.content = content
        self.loadingContent = loadingContent
        self.successContent = successContent
        self.errorContent = errorContent
    }
    
    var body: some View {
        VStack {
            content()
            
            switch loadingState {
            case .none:
                EmptyView()
            case .loading:
                loadingContent()
            case .success(let value):
                successContent(value)
            case .error(let error):
                errorContent(error)
            }
        }
    }
}

struct AsyncLoadingWrapperView<T: Codable & Equatable, LoadingView: View, SuccessView: View, FailureView: View>: View {
    
    private let load: () async throws -> T
    private let loadingView: () -> LoadingView
    private let successView: (T) -> SuccessView
    private let failureView: (Error) -> FailureView

    @State private var state: LoadingState<T> = .none

    init(
        load: @escaping () async throws -> T,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder successView: @escaping (T) -> SuccessView,
        @ViewBuilder failureView: @escaping (Error) -> FailureView
    ) {
        self.load = load
        self.loadingView = loadingView
        self.successView = successView
        self.failureView = failureView
    }

    var body: some View {
        Group {
            switch state {
            case .none, .loading:
                loadingView()
            case .success(let data):
                successView(data)
            case .error(let error):
                failureView(error)
            }
        }
        .task {
            guard case .none = state else { return }
            state = .loading
            do {
                let data = try await load()
                state = .success(data)
            } catch {
                state = .error(error)
            }
        }
    }
}
