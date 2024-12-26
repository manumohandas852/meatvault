//
//  ImageSliderTableViewCell.swift
//  main project meatshop
//
//  Created by irohub on 04/12/24.
//

import UIKit

class ImageSliderTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [String] = []
        var timer: Timer?
        var currentIndex = 0
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            collectionView.delegate = self
            collectionView.dataSource = self
            pageControl.currentPage = 0
            
            setupPageControlAction()
        }
        
        func configure(with images: [String]) {
            self.images = images
            pageControl.numberOfPages = images.count
            collectionView.reloadData()
            startTimer()
        }
        
        func startTimer() {
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(nextSlide), userInfo: nil, repeats: true)
        }
        
        @objc func nextSlide() {
            currentIndex = (currentIndex + 1) % images.count
            scrollToCurrentIndex()
        }
        
        private func scrollToCurrentIndex() {
            collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
        }
        
        private func setupPageControlAction() {
            pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        }
        
        @objc func pageControlTapped(_ sender: UIPageControl) {
            currentIndex = sender.currentPage
            scrollToCurrentIndex()
        }
        
        // MARK: - UICollectionViewDelegate and UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCell", for: indexPath) as! ImageSliderCell
            cell.configure(with: images[indexPath.item])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return collectionView.frame.size
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
            currentIndex = page
            pageControl.currentPage = page
        }
    }
