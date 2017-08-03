//
//  MHYTabbarController.swift
//  dantang
//
//  Created by 苗慧宇 on 01/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit

class MHYTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = UITabBar.appearance()
        tabBar.tintColor = MHYColor(r: 245, g: 90, b: 93, a: 1/0)
        addChildViewControllers()
    }
    
    /**
     添加子控制器
     */
    private func addChildViewControllers() {
        addChildViewController(childController: MHYDanTangViewController(), title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController(childController: MHYProductViewController(), title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController(childController: MHYCategoryViewController(), title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController(childController: MHYMineViewController(), title: "我的", imageName: "TabBar_me_boy_23x23_")
    }
    
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childController: UIViewController, title: String, imageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage.init(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        let navC = MHYNavigationViewController(rootViewController: childController)
        addChildViewController(navC)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
