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
    fileprivate let gap = 150.0
    //对于每个指示器，设置开始时中心位置的偏移量
    fileprivate let dx = 40.0
   
    //对于每个图片 space_Y
    fileprivate let V_Space = 10.0
    
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
        // 设置指示器的最大数
        let images = ["h1.jpg","h2.jpg","h3.jpg","h4.jpg","h5.png"]

        // 初始化指示器的偏移量，因为我们要把指示器放在居中的位置
        let width = Double(images.count + 1) * gap + dx

        // 创建主要的指示器
        for x in 0..<images.count {
            // 给新的指示器创建中心点
//            let point = CGPoint(x: Double(x) * gap + dx, y: V_Space)
            let item_X = Double(x) * (Double(infiniteScrollView.frame.width)-2*dx + gap)+dx
            let point = CGPoint(x: item_X, y: V_Space)
            let str = images[x]
            createIndicator(str, at: point)
//            createIndicator("\(x)", at: point)
        }
        // 创建额外的指示器
        var x : Int = 0
        // 创建偏移量
        var offset = dx
       
        // 总宽度（包括无限滚动视图里最后一个 view，基于 width + screen width）
        // 所以，总宽度，和一个有多少个额外的指示器，在一定程度上是随机的
        // 这也是为什么我们要使用 while 循环
        // 当偏移量小于 view 的宽度时
        while offset < Double(infiniteScrollView.frame.size.width) {
            // 创建中心点，x 坐标值为 width + the current offset
//            let point = Point(width + offset, canvas.center.y)
//            let y = infiniteScrollView.centerY

            let point = CGPoint(x: width + offset, y: V_Space)
            
           
            createIndicator("\(x)", at: point)

            // 对下一个点增加偏移量
            offset += gap
            // 增加 x 坐标值，作为下一个指示器的数值
            x += 1
            
//            // 创建宽度
            let str = images[x]
            createIndicator(str, at: point)
        }

        // 更新 infiniteScrollView 的 contentSize
        let content_width = Double(images.count + 1) * (gap + dx) + Double(infiniteScrollView.frame.width)-2*dx
//(Double(infiniteScrollView.frame.width)-2*dx + gap)+dx

        infiniteScrollView.contentSize = CGSize(width: CGFloat(content_width) + infiniteScrollView.frame.size.width, height: 0)

    }
    
    func createIndicator(_ text: String, at po: CGPoint) {
        print("图片名字\(text)")
        let imageView = UIImageView()
        imageView.frame = CGRect(origin: po, size: CGSize(width: infiniteScrollView.frame.width-2*CGFloat(dx), height: infiniteScrollView.frame.size.height-2*po.y))
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: text)
        // 添加到视图上
        infiniteScrollView.addSubview(imageView)
        
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: po.x, y: infiniteScrollView.frame.size.height-20-10), size: CGSize(width: SCREEN_WIDTH-20, height: 20))
        let width = SCREEN_WIDTH-20
        let x = po.x + width
        label.frame = CGRect(x: x, y: infiniteScrollView.frame.size.height-20-10, width: width, height: 21)
//        let label = UILabel()
//        CGRect rect = label.frame
        
//        label.point = CGPoint(x: po.x, y: 100)
//        label.frame.size = CGSize(width: 120, height: 21)
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
