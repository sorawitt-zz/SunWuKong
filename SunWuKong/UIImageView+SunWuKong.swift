//
//  UIImageView+WuKonger.swift
//  WuKonger
//
//  Created by Sorawit Trutsat on 8/20/18.
//  Copyright © 2018 Sorawit Trutsat. All rights reserved.
//

import Foundation
import FirebaseStorage

private var wkImageUrlKey: UInt8 = 0
private var wkImageRefKey: UInt8 = 0

extension UIImageView {
    
    private var wkImageUrl: URL? {
        get {
            return objc_getAssociatedObject(self, &wkImageUrlKey) as? URL
        }
        
        set {
            objc_setAssociatedObject(self, &wkImageUrlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var wkImageRef: StorageReference? {
        get {
            return objc_getAssociatedObject(self, &wkImageRefKey) as? StorageReference
        }
        set {
            objc_setAssociatedObject(self, &wkImageRefKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
    
    public func wk_setImage(with storageRef: StorageReference?, placeholder: UIImage? = nil, progress: DownloadProgress? = nil, completion: ImageDownloadCompletion? = nil) {
        wkImageRef = storageRef
        image = placeholder
        guard let storageRef2 = storageRef else {
            completion?(nil)
            return
        }
        
        SunWuKong.default.image(with: storageRef2, progress: progress) { [weak self] image in
            guard let weakSelf = self else { return }
            guard weakSelf.wkImageRef == storageRef2 else { return }
            weakSelf.image = image
            completion?(image)
            //guard let weakSelf.wkImageRef = storageRef else { return}
        }
        
        
    }
}
