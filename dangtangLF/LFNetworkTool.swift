//
//  LFNetworkTool.swift
//  dangtangLF
//
//  Created by jim on 17/1/16.
//  Copyright © 2017年 jim. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class LFNetworkTool: NSObject {

    //单例
    static let shareNetworkTool = LFNetworkTool()
 
    /**
     分类界面 顶部 专题合集
     */
    func loadCategoryCollection(limit: Int,finished:(collections: [LFCollection])->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/collections"
        let params = ["limit": limit,
                        "offset": 0]
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
                SVProgressHUD.showErrorWithStatus("加载失败")
                return
            }
            if let value = response.result.value{
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else{
                    SVProgressHUD.showInfoWithStatus(message)
                    return
                }
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary{
                    if let collectionData = data["collections"]?.arrayObject{
                        var collections = [LFCollection]()
                        for item in collectionData{
                            let collection = LFCollection(dict: item as! [String: AnyObject])
                            collections.append(collection)
                        }
                        finished(collections: collections)
                    }
                }
            }
            
        }
    }
     
     
    /**
     顶部 专题合集 -> 专题列表
     */
    func loadCollectionPosts(id: Int, finished:(posts: [LFCollectionPost])->()){
        SVProgressHUD.showWithStatus("正在加载。。。")
        let url = BASE_URL + "v1/collections/\(id)/posts"
        let params = ["gender":1,
                        "generation":1,
                        "limit":20,
                        "offset":0]
        //网络请求
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) -> Void in
            //守护 --> guard语句判断其后的表达式布尔值为false时，才会执行之后代码块里的代码，如果为true，则跳过整个guard语句
            guard response.result.isSuccess else{
                SVProgressHUD.showErrorWithStatus("加载失败。。。")
                return
            }
            if let value = response.result.value{
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else{
                    SVProgressHUD.showInfoWithStatus(message)
                    return
                }
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary{
                    if let postsData = data["posts"]?.arrayObject{
                        var posts = [LFCollectionPost]()
                        for item in postsData{
                            let post = LFCollectionPost(dict: item as! [String: AnyObject])
                            posts.append(post)
                        }
                        finished(posts: posts)
                    }
                }
            }
        }
    }
     
     
    /**
    *  分类界面 风格，品味
    */
    
    func loadCategoryGroup(finished:(outGroups:[AnyObject])->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/channel_groups/all"
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            if let value = response.result.value{
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else{
                    SVProgressHUD.showInfoWithStatus(message)
                    return
                }
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary{
                    if let channel_groups = data["channel_groups"]?.arrayObject{
                        //outGroups 存储两个 inGrounds数组，inGroups存储 LFGroup 对象
                        //outGroups 是一个二维数组
                        var outGroups = [AnyObject]()
                        for channel_group in channel_groups{
                            var inGroups = [LFGroup]()
                            let channels = channel_group["channels"] as! [AnyObject]
                            for channel in channels{
                                let group = LFGroup(dict: channel as! [String: AnyObject])
                                inGroups.append(group)
                            }
                            outGroups.append(inGroups)
                        }
                        finished(outGroups: outGroups)
                        
                    }
                    
            }
        }
    }
}
    
    /**
    *  底部 风格品类 -> 列表
    */
    func loadStylesOrCategoryInfo(id: Int, finished:(item: [LFCollectionPost])->()){
        SVProgressHUD.showWithStatus("正在加载。。。")
        let url  = BASE_URL + "v1/channels/\(id)/items"
        let params = ["limit":20,"offset":0]
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
                SVProgressHUD.showErrorWithStatus("加载失败...")
                return
            }
            if let value = response.result.value{
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else{
                    SVProgressHUD.showErrorWithStatus(message)
                    return
                }
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary{
                    if let itemsData = data["items"]?.arrayObject{
                        var items = [LFCollectionPost]()
                        for item in itemsData{
                            let post = LFCollectionPost(dict: item as! [String: AnyObject])
                            items.append(post)
                        }
                        finished(item: items)
                    }
                }
            }
        }
    }
}
