//
//  mDNS scan.swift
//  NetScanner
//
//  Created by Erik Woods on 4/23/25.
//

import Foundation
import Network
import CoreData

class NetworkScanner: NSObject, ObservableObject, NetServiceBrowserDelegate {
    private var browser = NetServiceBrowser()
    private var services: [NetService] = []

    let firstNumber: Int
    let secondNumber: Int
    @Published var discoveredNames: [String] = []

    init(firstNumber: Int, secondNumber: Int) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        super.init()
        addnumbers(first: firstNumber, second: secondNumber)
        browser.delegate = self
        browser.searchForServices(ofType: "_http._tcp.", inDomain: "") // Adjust type as needed
    }
    func addnumbers(first: Int, second: Int){
        print(first + second)
    }
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        DispatchQueue.main.async {
            let name = service.name
            if !self.discoveredNames.contains(name) {
                self.discoveredNames.append(name)
                self.saveDevice(name: name)
            }
        }
    }

    private func saveDevice(name: String) {
        let context = PersistenceController.shared.container.viewContext
        let newDevice = Device(context: context)
        newDevice.name = name
        newDevice.ipAddress = "N/A"  // You can update this if you later resolve IP
        newDevice.lastSeen = Date()

        do {
            try context.save()
            print("Saved: \(name)")
        } catch {
            print("Error saving device: \(error)")
        }
    }
}
