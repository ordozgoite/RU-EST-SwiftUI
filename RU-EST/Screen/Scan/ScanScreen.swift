//
//  ScanScreen.swift
//  RU-EST
//
//  Created by Victor Ordozgoite on 17/03/23.
//

import SwiftUI
import AudioToolbox

struct ScanScreen: View {
    
    @ObservedObject private var scanVM = ScanViewModel()
    
    var body: some View {
        ZStack {
            BarcodeScannerView(scannedCode: $scanVM.scannedCode)
                .ignoresSafeArea()
            
            ScanOverlay()
            
            if scanVM.isLoading {
                LoadingView()
                    .onAppear {
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    }
            }
            
            NavigationLink(destination: ConfirmOrderScreen(customer: scanVM.customer ?? Customer(_id: "1", name: "Unknown", barcode: "1")), isActive: $scanVM.goToNext) {
                EmptyView()
            }
        }
    }
}
