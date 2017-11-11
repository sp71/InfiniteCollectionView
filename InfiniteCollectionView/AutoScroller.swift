//
//  AutoScroller.swift
//  InfiniteCollectionView
//
//  Created by Satinder Singh on 11/11/17.
//  Copyright © 2017 Satinder. All rights reserved.
//

import UIKit

class AutoScroller {

    var endPoint: CGPoint!
    var startingPoint: CGPoint!
    var scrollingPoint: CGPoint!
    var timer: Timer!
    let collectionView: UICollectionView
    let size: Int
    let modelSize: Int

    /// Setup
    ///
    /// - Parameters:
    ///   - collectionView: UICollectionView to scroll
    ///   - size: numberOfItemsInCollectionView
    ///   - modelSize: size of model
    init(collectionView: UICollectionView, size: Int, modelSize: Int) {
        self.collectionView = collectionView
        self.size = size
        self.modelSize = modelSize
    }

    func setup() {
        collectionView.scrollToItem(at: IndexPath(row: size / 2 + modelSize + 1, section: 0),
                                         at: .centeredHorizontally,
                                         animated: false)
        endPoint = CGPoint(x: collectionView.contentOffset.x, y: 0)

        let midIndexPath = IndexPath(row: size / 2, section: 0)
        collectionView.scrollToItem(at: midIndexPath, at: .centeredHorizontally, animated: false)

        startingPoint = collectionView.contentOffset
        scrollingPoint = startingPoint
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { (_) in
            self.scrollForward()
        }
    }

    func scrollForward() {
        collectionView.contentOffset = scrollingPoint
        if scrollingPoint.equalTo(endPoint) {
            timer.invalidate()
            endPoint = startingPoint
            timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { (_) in
                self.scrollBackwards()
            }
        }
        scrollingPoint = CGPoint(x: scrollingPoint.x + 1, y: scrollingPoint.y)
    }

    func scrollBackwards() {
        collectionView.contentOffset = scrollingPoint
        if scrollingPoint.equalTo(endPoint) {
            timer.invalidate()
        }
        scrollingPoint = CGPoint(x: scrollingPoint.x - 1, y: scrollingPoint.y)
    }

}
