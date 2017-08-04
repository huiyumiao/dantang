//
//  MHYNetworkTool.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class MHYNetworkTool: NSObject {
    // 单例
    static let sharedNetworkTool = MHYNetworkTool()
    
    // MARK: - 获取首页数据
    func loadHomeInfo(id: Int, finished: @escaping (_ homeItems: [MHYHomeItem]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    
                    let data = dict["data"].dictionary
                    // 字典转模型
                    if let items = data!["items"]?.arrayObject {
                        var homeItems = [MHYHomeItem]()
                        for item in items {
                            let homeItem = MHYHomeItem(dict: item as! [String: AnyObject])
                            homeItems.append(homeItem)
                        }
                        finished(homeItems)
                    }
                }
        }
    }
    
    // MARK: - 获取首页顶部选择数据
    func loadHomeTopData(finished: @escaping (_ channels: [MHYChannel]) -> ()) {
        
        let url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showError(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    
                    let data = dict["data"].dictionary
                    if let channels = data!["channels"]?.arrayObject {
                        var finalChannels = [MHYChannel]()
                        for channel in channels {
                            let channel = MHYChannel(dict: channel as! [String: AnyObject])
                            finalChannels.append(channel)
                        }
                        finished(finalChannels)
                    }
                }
        }
    }
    
    // MARK: - 搜索界面数据
    func loadHotWords(finished: @escaping (_ words: [String]) -> ()) {
        
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/search/hot_words"
        Alamofire
            .request(url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let hot_words = data["hot_words"]?.arrayObject {
                            finished(hot_words as! [String])
                        }
                    }
                }
        }
    }
    
    // MARK: - 获取单品数据
    func loadProductData(finished:@escaping (_ products: [MHYProduct]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let items = data["items"]?.arrayObject {
                            var products = [MHYProduct]()
                            for item in items {
                                let itemDict = item as! [String : AnyObject]
                                if let itemData = itemDict["data"] {
                                    let product = MHYProduct(dict: itemData as! [String: AnyObject])
                                    products.append(product)
                                }
                            }
                            finished(products)
                        }
                    }
                }
        }
    }
    
    // MARK: - 获取单品详情数据
    func loadProductDetailData(id: Int, finished:@escaping (_ productDetail: MHYProductDetail) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v2/items/\(id)"
        Alamofire
            .request(url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionaryObject {
                        let productDetail = MHYProductDetail(dict: data as [String : AnyObject])
                        finished(productDetail)
                    }
                }
        }
    }
    
    // MARK: - 商品详情 评论
    func loadProductDetailComments(id: Int, finished:@escaping (_ comments: [MHYComment]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v2/items/\(id)/comments"
        let params = ["limit": 20,
                      "offset": 0]
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let commentsData = data["comments"]?.arrayObject {
                            var comments = [MHYComment]()
                            for item in commentsData {
                                let comment = MHYComment(dict: item as! [String: AnyObject])
                                comments.append(comment)
                            }
                            finished(comments)
                        }
                    }
                }
        }
    }
    
    // MARK: - 分类页面专题合集数据
    func loadCategoryCollectionsInfo(finished:@escaping (_ collections: [MHYTopicModel]) -> ()) {
        SVProgressHUD.show()
        
        let url = BASE_URL + "v1/collections"
        
        Alamofire
            .request(url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    
                    if let data = dict["data"].dictionary {
                        if let collectionData = data["collections"]?.arrayObject {
                            var collection = [MHYTopicModel]()
                            for item in collectionData {
                                let topic = MHYTopicModel(dict: item as! [String: AnyObject])
                                collection.append(topic)
                            }
                            finished(collection)
                        }
                    }
                }
        }
    }
    
    // MARK: - 某个专题的信息
    func loadTopicData(id: Int, finished:@escaping (_ postList: MHYPostListModel) -> ()) {
        SVProgressHUD.show(withStatus: "加载中...")
        
        let url = BASE_URL + "/v1/collections/\(id)/posts?gender=1&generation=0&limit=20&offset=0"
        
        Alamofire
            .request(url)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败")
                    return
                }
                
                if let value = response.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    
//                    var postList: MHYPostListModel!
//                    if let data = dict["data"].dictionaryObject {
//                        postList = MHYPostListModel(dict: data as [String: AnyObject])
//                    }
//                    
//                    if let data = dict["data"].dictionary {
//                        
//                        var allPost = [MHYPostModel]()
//                        if let posts = data["posts"]?.arrayObject {
//                            for item in posts {
//                                let post = MHYPostModel(dict: item as! [String: AnyObject])
//                                allPost.append(post)
//                            }
//                        }
//                        finished(postList, allPost)
//                    }
                    
                    
                    let postList = MHYPostListModel(dict: dict)
                    finished(postList!)
                }
        }
    }
}
