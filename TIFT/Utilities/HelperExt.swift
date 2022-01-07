//
//  HelperExt.swift
//  TIFT
//
//  Created by Terence Williams on 1/6/22.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage {
           if #available(iOS 10.0, *) {
               let renderer = UIGraphicsImageRenderer(bounds: bounds)
               return renderer.image { rendererContext in
                   layer.render(in: rendererContext.cgContext)
               }
           } else {
               UIGraphicsBeginImageContext(self.frame.size)
               self.layer.render(in:UIGraphicsGetCurrentContext()!)
               let image = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               return UIImage(cgImage: image!.cgImage!)
           }
    }
}

//https://stackoverflow.com/a/48572117/3578546
extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 && UIDevice.current.userInterfaceIdiom != .pad{
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
