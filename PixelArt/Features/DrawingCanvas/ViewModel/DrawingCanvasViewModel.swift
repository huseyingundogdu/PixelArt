//
//  DrawingCanvasViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 25/07/2025.
//

import SwiftUI

enum Operation {
    case draw
    case erase
}

final class DrawingCanvasViewModel: ObservableObject {
    @Published var hexData: [String] = []
    @Published var selectedColor: String = "#FFFFFF"
    @Published var selectedColorFreeform: Color = .white
    @Published var selectedOperation: Operation = .draw
    @Published var isColorSheetPresenting: Bool = false
    @Published var isGridActive: Bool = true
    
    var entity: ArtworkEntity?

    init(id: String) {
        if let foundEntity = CoreDataManager.shared.fetchArtworkById(id: id) {
            self.entity = foundEntity
            self.hexData = foundEntity.data
        }
    }

    func updatePixel(at index: Int, to color: String) {
        guard let entity = entity else { return }
        guard index >= 0 && index < hexData.count else { return }

        hexData[index] = color
        entity.setValue(hexData, forKey: "data")
        entity.lastUpdated = .now
        entity.isSynced = false
        entity.syncOp = .update
        CoreDataManager.shared.save()
    }
    
}
