////
////  ImageAndCache.swift
////  Moviomatic
////
////  Created by Piyush Agrawal on 21/04/22.
////
//
//import UIKit
//
//final class LazyImageView: UIImageView {
//    
//    static private let imageCache = NSCache<NSString, AnyObject>()
//    func loadImage(fromURL imageURL: URL) {
//        
//        if let cachedImage = LazyImageView.imageCache.object(forKey: imageURL.absoluteString as NSString) as? UIImage {
//            self.image = cachedImage.decodedImage()
//            return
//        }
//        self.image = UIImage(named: "noimage")
//        DispatchQueue.global().async { [weak self] in
//            if let imageData = try? Data(contentsOf: imageURL) {
//                if let image = UIImage(data: imageData) {
//                    DispatchQueue.main.async {[weak self] in
//                        LazyImageView.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
//                        self?.image = image.decodedImage()
//                    }
//                }
//            }
//        }
//    }
//}
//
//extension UIImage {
//    
//    func decodedImage() -> UIImage {
//        guard let cgImage = cgImage else { return self }
//        let size = CGSize(width: cgImage.width, height: cgImage.height)
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
//        guard let decodedImage = context?.makeImage() else { return self }
//        return UIImage(cgImage: decodedImage)
//    }
//}
