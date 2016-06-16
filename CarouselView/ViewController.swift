//
//  ViewController.swift
//  CarouselView
//
//  Created by LLS on 16/6/16.
//  Copyright © 2016年 LLS. All rights reserved.
//

import UIKit
public let kscreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let kscreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController,CarouseViewDelegate {
    var carouselView: AICarouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        initBackgroudView()
    }

    private func initBackgroudView(){
        carouselView = AICarouselView.init(frame: CGRectMake(10, 100, kscreenWidth - 20, (kscreenWidth - 20)*3/8))
        carouselView.backgroundColor = UIColor.redColor()
        carouselView.images = ["1","2","3","4","5"]
        carouselView.delegate = self
        view.addSubview(carouselView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func carouseImageClicked(index: NSInteger) {
        print("点击第\(index)个")
    }

}

