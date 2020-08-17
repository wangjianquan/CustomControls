//
//  BannerContentViewController.swift
//  CustomControls
//
//  Created by MacBook Pro on 2020/1/6.
//  Copyright © 2020 WJQ. All rights reserved.
//

import UIKit

class BannerContentViewController: UIViewController {

    let infiniteScrollView = InfiniteScrollView()
     // 设置每个指示器之间的间隔
//    let gap = Double(SCREEN_WIDTH)
    let count = 20

    
    fileprivate let gap = 150.0
    //对于每个指示器，设置开始时中心位置的偏移量
    fileprivate let dx = 40.0
   
    //对于每个图片 space_Y
    fileprivate let V_Space = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white;
        infiniteScrollView.frame = CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 200)
        infiniteScrollView.backgroundColor = UIColor.red
        //add the view to the canvas
        self.view.addSubview(infiniteScrollView)

        

        addVisualIndicators()
        // Do any additional setup after loading the view.
    }
    
    func addVisualIndicators() {
         //the max number of indicators
//           let count = 20
//
//           //the gap between indicators
//           let gap = 150.0
//
//           //initial offset because we're positioning from the center of each indicator's view
//           let dx = 40.0
           
           //the calculated total width of the view's contentSize
           let width = Double(count + 1) * gap + dx
           
           //create main indicators
           for x in 0...count {
               //create a center point for the new indicator
               let point = CGPoint(x: Double(x) * gap + dx, y: V_Space)
               //create a new indicator
               createIndicator("\(x)", at: point)
           }
           
           //create additional indicators
           var x : Int = 0
           
           //create an offset variable
           var offset = dx
           
           //The total width (including the last "view" of the infiniteScrollView is based on the width + screen width
           //So, the total width and count of how many "extra" indicators to add is somewhat arbitrary
           //This is why we use a while loop
           
           //while the offset is less than the view's width
           while offset < Double(infiniteScrollView.frame.size.width) {
               //create a center point whose x value starts is the total width + the current offset
               let point = CGPoint(x: width + offset, y: V_Space)

               //create the width
               createIndicator("\(x)", at: point)
               //increase the offset for the next point
               offset += gap
               //increate x to be used as the variable for the next indicator's number
               x += 1
           }
           
           //update infiniteScrollView contentSize
           infiniteScrollView.contentSize =  CGSize(width: CGFloat(width) + infiniteScrollView.frame.size.width, height: 0)
       }
    
    func createIndicator(_ text: String, at po: CGPoint) {
        print("图片名字\(text)")
        let imageView = UIImageView()
        imageView.frame = CGRect(origin: po, size: CGSize(width: infiniteScrollView.frame.width-2*CGFloat(dx), height: infiniteScrollView.frame.size.height-2*po.y))
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: text)
        // 添加到视图上
//        infiniteScrollView.addSubview(imageView)
        
        let label = UILabel()
//        label.frame = CGRect(origin: CGPoint(x: po.x, y: infiniteScrollView.frame.size.height-20-10), size: CGSize(width: SCREEN_WIDTH-20, height: 20))
//        let width = SCREEN_WIDTH-20
//        let x = po.x + width
//        label.frame = CGRect(x: x, y: infiniteScrollView.frame.size.height-20-10, width: width, height: 21)


        var rect = label.frame
        rect.origin = po
        rect.size = CGSize(width: SCREEN_WIDTH-20, height: 21)
        label.frame = rect
        
        label.backgroundColor = UIColor.randomColor
        label.layer.cornerRadius = 3
        label.text = "图片名称 \(text)"
        label.textAlignment = .center
        infiniteScrollView.addSubview(label)
        

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
