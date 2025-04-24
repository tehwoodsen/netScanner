//
//  DeviceManager.swift
//  NetScanner
//
//  Created by Erik Woods on 4/23/25.
//

import CoreData

class DeviceManager {
    static let shared = DeviceManager()

    func saveDevice(name: String, ipAddress: String) {
        let context = PersistenceController.shared.container.viewContext
        let device = Device(context: context)
        device.name = name
        device.ipAddress = ipAddress
        device.lastSeen = Date()

        do {
            try context.save()
        } catch {
            print("Failed to save device: \(error)")
        }
    }
}
