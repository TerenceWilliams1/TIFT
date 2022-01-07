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
