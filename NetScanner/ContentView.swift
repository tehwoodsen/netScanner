//
//  ContentView.swift
//  NetScanner
//
//  Created by Erik Woods on 4/23/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(
        entity: Device.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Device.lastSeen, ascending: false)]
    ) var devices: FetchedResults<Device>

    @ObservedObject var scanner = NetworkScanner(firstNumber: 5, secondNumber: 4)

    var body: some View {
        NavigationView {
            VStack {
                Text("Scanning for devices via mDNS...")
                    .padding(.bottom)

                List(devices, id: \.self) { device in
                    VStack(alignment: .leading) {
                        Text(device.name ?? "Unknown Device")
                            .font(.headline)
                        Text(device.ipAddress ?? "No IP")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Network Devices")
            }
        }
        .onAppear {
            print("ContentView appeared and scanner started")
        };Section(header: Text("Discovered This Session")) {
            List(scanner.discoveredNames, id: \.self) { name in
                Text(name)
                    .foregroundColor(.blue)
            }
        }
    }
}


