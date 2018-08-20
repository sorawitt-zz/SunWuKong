//
//  SuWuKong.swift
//  SunWuKong
//
//  Created by Sorawit Trutsat on 8/20/18.
//  Copyright © 2018 Sorawit Trutsat. All rights reserved.
//

import Foundation
import FirebaseStorage

public typealias ImageDownloadCompletion = (UIImage?) -> Void

public class SunWuKong {
    public static let `default` = SunWuKong()
    
    public let cache: DiskCache
    public let downloader: Downloader
    
    /// Initialize a new instance of WuKonger.
    ///
    /// - Parameter cache: The cache to use. Uses the `default` instance if nothing is passed
    /// - Parameter downloader: The downloader to use. Users the `default` instance if nothing is passed
    public init(cache: DiskCache = .default, downloader: Downloader = .default) {
        self.cache = cache
        self.downloader = downloader
    }
    
    /// Download or retrieve an image from cache
    ///
    /// - Parameters:
    ///     - url: The URL to load an image from
    ///     - progress: An optional closure to track the download progress
    ///     - completion: The closure to call once the download is done
    public func image(with url: URL,
                      progress: DownloadProgress?,
                      completion: @escaping ImageDownloadCompletion) {
        fetchImage(with: url, progress: progress, completion: completion)
    }
    
    public func image(with storageRef: StorageReference,
                      progress: DownloadProgress?,
                      completion: @escaping ImageDownloadCompletion) {
        fetchImage(with: storageRef, progress: progress, completion: completion)
    }
    
    private func fetchImage(with storageRef: StorageReference,
                            progress: DownloadProgress?,
                            completion: ImageDownloadCompletion?) {
        let key = storageRef.fullPath
        cache.get(key: key) { data in
            guard let data = data else {
                self.downloader.download(storageRef, progress: progress, completion: { [weak self] data in
                    guard let weakSelf = self else { return }
                    guard let data = data, let image = UIImage(data: data) else {
                        completion?(nil)
                        return
                    }
                    weakSelf.cache.add(key: key, data: data)
                    completion?(image)
                })
                return
            }
            if let image = UIImage(data: data) {
                completion?(image)
            }
        }
    }
    private func fetchImage(with url: URL,
                            progress: DownloadProgress?,
                            completion: ImageDownloadCompletion?) {
        let key = url.absoluteString
        cache.get(key: key) { data in
            guard let data = data else {
                self.downloader.download(url, progress: progress, completion: { [weak self] data in
                    guard let weakSelf = self else { return }
                    guard let data = data, let image = UIImage(data: data) else {
                        completion?(nil)
                        return
                    }
                    weakSelf.cache.add(key: key, data: data)
                    completion?(image)
                })
                return
            }
            if let image = UIImage(data: data) {
                completion?(image)
            }
        }
    }
    
    /// Pre-warms the image cache. Downloads the image if needed or loads it into memory.
    ///
    /// - Parameter url: The URL to load an image from
    public func preWarmCache(for url: URL) {
        fetchImage(with: url, progress: nil, completion: nil)
    }
    
    
    
    
}

