//
//  ContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/02/2025.
//

import SwiftUI
import FirebaseFirestore


struct RootView: View {
    @StateObject private var appState = AppState()
    @StateObject private var networkMonitor = NetworkMonitor.shared
    
    var body: some View {
        if appState.isLoggedIn {
            MainTabbedView(appState: appState)
                .environmentObject(networkMonitor)
        } else {
            AuthFlowView(appState: appState)
        }
    }
    
}


#Preview {
    RootView()
}

/*
 aslinda o zaman sadece authorUsername icin UserDefaults olusturduk gibi bir sey oldu sanirim. Aslinda ben authorUsername i diger kullanicilara gostermek icin eklemistim Artwork e yani UI tarafinda artwork.id yi gostermek cok hos olmaz diye dusunup artwork e author username eklemistim, o zaman su sekil yapabiliriz. kullanici offlineken olusturdugu artworkleri interneti yokken zaten kimse gormeyecegi icin aslinda o noktada authorUsername anlamsiz durumu soyle yapsak kullanici online oldugunda biz local deki artworkleri remote a gonderiyoruz ya orada kullanicinin username ini alsak orada versek nasil olur yani aslinda remote islemi bizden bi de username istese kullanici online oldugu zaman artwork viemodel de userService uzerinden gelen AppUser in current objesini de alsak oradan username i auth service den de current user alabiyoruz falan filan bosluklari sen tamamla best practice burada nasil olur, yoksa dumduz hic bu kadar karisiklikla ugrasmayip dumduz UserDefaults da mi tutalim diyorsun hatta appState de dumduz user default doluysa gibi bisey yapar isloggedin i de oyle set edelim mi diyorsun ? anlat bakalim
 */

