//
//  AICarouselView.swift
//  CarouselView
//
//  Created by LLS on 16/6/16.
//  Copyright © 2016年 LLS. All rights reserved.
//

import UIKit

//点击事件代理
protocol CarouseViewDelegate {
    func carouseImageClicked(index:NSInteger);
}

class AICarouselView: UIView,UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: NSTimer!
    var delegate: CarouseViewDelegate!
    var width: CGFloat!
    var height: CGFloat!
    
    var images = [String]() {
        didSet {
            scrollView.contentSize = CGSizeMake(width * CGFloat(images.count), 0)
            pageControl.numberOfPages = images.count
            for index in 0..<images.count {
                let imageView = UIImageView.init(frame: CGRectMake(CGFloat(index)*width, 0, width, height))
                imageView.image = UIImage.init(named: "\(images[index])")
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                self.scrollView.addSubview(imageView)
                let button = UIButton.init(type: UIButtonType.Custom);
                button.frame = CGRectMake(CGFloat(index) * width, 0, width, height);
                button.backgroundColor = UIColor.clearColor()
                button.tag = index;
                button.addTarget(self, action: #selector(AICarouselView.carouseImageClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside);
                self.scrollView.addSubview(button);
            }
        }
    }
    
    // MARK: - init Layout

    override init(frame: CGRect) {
        super.init(frame: frame)
        width =  frame.size.width
        height = frame.size.height
        scrollView = UIScrollView.init(frame: CGRectMake(0, 0, width, height))
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.pagingEnabled = true
        scrollView.contentOffset = CGPointMake(0, 0)
        scrollView.showsHorizontalScrollIndicator = false
        pageControl = UIPageControl.init(frame: CGRectMake(0, frame.size.height - 30, frame.size.width, 30))
        self.addSubview(scrollView)
        self.addSubview(pageControl)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector:#selector(AICarouselView.changePicture), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
    }
    
    override func layoutSubviews() {
        
    }
    
    // MARK: - Delegate
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        timer.fireDate = NSDate.distantFuture();
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.performSelector(#selector(AICarouselView.timerFile), withObject: self.timer, afterDelay: 3)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage = NSInteger(scrollView.contentOffset.x / width)
    }
    
    func timerFile() {
        timer.fireDate = NSDate()
    }
    
    
    
    // MARK: - Action Methods
    func changePicture() {
        let contentX = self.scrollView.contentOffset.x;
        if contentX / width == CGFloat(self.images.count - 1) {
            self.scrollView.setContentOffset(CGPointMake(0, 0), animated: false);
            self.pageControl.currentPage = 0;
        }else {
            self.scrollView .setContentOffset(CGPointMake(contentX + width, 0), animated: true);
            self.pageControl.currentPage = Int(contentX / width) + 1;
        }
    }
    
    
    func carouseImageClicked(sender:UIButton) {
        delegate.carouseImageClicked(sender.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
