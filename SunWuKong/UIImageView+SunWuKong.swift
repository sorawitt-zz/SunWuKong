//
//  UIImageView+WuKonger.swift
//  WuKonger
//
//  Created by Sorawit Trutsat on 8/20/18.
//  Copyright © 2018 Sorawit Trutsat. All rights reserved.
//

import Foundation

private var wkImageUrlKey: UInt8 = 0

extension UIImageView {
    
    private var wkImageUrl: URL? {
        get {
            return objc_getAssociatedObject(self, &wkImageUrlKey) as? URL
        }
        
        set {
            objc_setAssociatedObject(self, &wkImageUrlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func wk_setImage(with url: URL?, placeholder: UIImage? = nil, progress: DownloadProgress? = nil, completion: ImageDownloadCompletion? = nil) {
        wkImageUrl = url
        image = placeholder
        guard let url = url else {
            completion?(nil)
            return
        }
        SunWuKong.default.image(with: url, progress: progress) { [weak self] image in
            guard let weakSelf = self else { return }
            guard weakSelf.wkImageUrl == url else { return }
            weakSelf.image = image
            completion?(image)
        }
    }
}
