//
//  ViewController.swift
//  Foodly
//
//  Created by Vadim Samoilov on 6.02.22.
//

import UIKit

class ViewController: UIViewController {

    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .systemPink
        
       return pageControl
    } ()
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        scrollView.delegate = self
        view.addSubview(pageControl)
        view.addSubview(scrollView)
  }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current)*view.frame.size.width, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height-100, width: view.frame.size.width-20, height: 70)
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-100)
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
        
    }
    
    private func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.size.width*3, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        let images = ["bowl", "motorcycle", "pizza"]
        
        for x in 0..<3 {
//            let page = UIView(frame: CGRect(x: CGFloat(x)*view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            let page = UIImageView(image: UIImage(named: images[x]))
            page.frame = CGRect(x: CGFloat(x)*view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height)
            scrollView.addSubview(page)
            
        }
        
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x)/Float(scrollView.frame.size.width)))
    }
}
