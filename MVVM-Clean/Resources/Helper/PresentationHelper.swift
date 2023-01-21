//
//  PresentationHelper.swift
//  MVVM-Clean
//
//  Created by MBS on 19/01/2023.
//

import Foundation
import UIKit


struct PresentationHelper {
    
    ///to avoid reloading all the data
    static func calculateIndexPathsToReload(from newCount: Int, oldCount: Int, section: Int ) -> [IndexPath] {
        let newDataCount = newCount - oldCount
        let startIndex = newCount - newDataCount
        let endIndex = startIndex + newDataCount
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: section) }
    }

}
