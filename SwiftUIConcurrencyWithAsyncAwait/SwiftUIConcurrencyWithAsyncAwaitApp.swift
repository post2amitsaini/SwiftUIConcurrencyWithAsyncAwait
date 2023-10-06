//
//  SwiftUIConcurrencyWithAsyncAwaitApp.swift
//  SwiftUIConcurrencyWithAsyncAwait
//
//  Created by Amit Saini on 04/10/23.
//

import SwiftUI

@main
struct SwiftUIConcurrencyWithAsyncAwaitApp: App {
    var body: some Scene {
        WindowGroup {
            TaskGroupView()
        }
    }
}
