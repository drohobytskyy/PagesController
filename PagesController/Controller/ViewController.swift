//
//  ViewController.swift
//  PagesController
//
//  Created by @rtur drohobytskyy on 23/01/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pagesCollectionView: UICollectionView!
    @IBOutlet weak var controlsContainerStackView: UIStackView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    private var cell_identifier: String = "pages_cell_identifier"
    
    var pages: [Page] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pages = getPages()
        setupLayout()
    }
    
    @IBAction func prevButtonAction(_ sender: Any) {
        
        let prevPage = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevPage, section: 0)
        pageControl.currentPage = prevPage
        pagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
     
        let nextPage = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextPage, section: 0)
        pageControl.currentPage = nextPage
        pagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func getPages() -> [Page] {
        return [Page(image: "music", title: "Music", description: "Listen to the best music here"),
                Page(image: "movies", title: "Movies", description: "Watch the best movies here"),
                Page(image: "books", title: "Books", description: "Read the best books here")]
    }
    
    private func setupLayout() {
        
        pagesCollectionView.isPagingEnabled = true
        pagesCollectionView.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = pages.count
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_identifier, for: indexPath) as! PageCollectionViewCell

        let page: Page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: pagesCollectionView.frame.width, height: pagesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showAlert(withTitle: "Selected option: ", withMessage: pages[indexPath.item].title)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let currentPage = x / view.frame.width
        pageControl.currentPage = Int(currentPage)
    }
    
    func showAlert(withTitle title: String, withMessage message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
}


