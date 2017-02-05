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
     获取首页数据
     */
    func loadHomeInfo(id: Int, finished:(homeItems: [LFHomeItem])->()){
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                        "generation": 1,
                        "limit": 20,
                        "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else{
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
                    let data = dict["data"].dictionary
                    //字典转成模型
                    if let items = data!["items"]?.arrayObject{
                        var homeItems = [LFHomeItem]()
                        for item in items{
                            let homeItem = LFHomeItem(dict: item as! [String: AnyObject])
                            homeItems.append(homeItem)
                        }
                        finished(homeItems: homeItems)
                    }
                }
        }
    }
    
    /**
     获取首页顶部选择数据
     */
    func loadHomeTopData(finished:(lf_channels: [LFChannel])->()){
        let  url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                        "generation": 1]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else{
                    SVProgressHUD.showErrorWithStatus("加载失败...")
                    return
                }
                if let value = response.result.value{
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfoWithStatus(message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    let data = dict["data"].dictionary
                    if let channels = data!["channels"]?.arrayObject{
                        var lf_channels = [LFChannel]()
                        for channel in channels{
                            let lf_channel = LFChannel(dict: channel as! [String: AnyObject])
                            lf_channels.append(lf_channel)
                        }
                        finished(lf_channels: lf_channels)
                    }
                }
        }
    }
    /**
     搜索界面数据
     */
    func loadHotWords(finished:(words: [String])->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/search/hot_words"
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
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
                if let data = dict["data"].dictionary {
                    if let hot_words = data["hot_words"]?.arrayObject{
                        finished(words: hot_words as! [String])
                    }
                }
            }
        }
    }
 
    /**
     根据搜索条件进行搜索
     */
    func loadSearchResult(keyword: String,sort: String,finished:(results: [LFSearchResult])->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v1/search/item"
        let params = ["keyword": keyword,
                        "limit": 20,
                        "offset": 0,
                        "sort": sort]
        Alamofire
            .request(.GET, url, parameters: params as? [String : AnyObject])
            .responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
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
                    if let items = data["items"]?.arrayObject{
                        var results = [LFSearchResult]()
                        for item in items{
                            let result = LFSearchResult(dict: item as! [String: AnyObject])
                            results.append(result)
                        }
                        finished(results: results)
                    }
                }
            }
        }
    }
    /**
     获取单品数据
     */
    func loadProductData(finished: (products: [LFProduct])->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                        "generation": 1,
                        "limit": 20,
                        "offset": 0]
        Alamofire.request(.GET, url, parameters: params ).responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
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
                    if let items = data["items"]?.arrayObject{
                        var products = [LFProduct]()
                        for item in items{
                            if let itemData = item["data"]{
                                let product = LFProduct(dict: itemData as! [String:AnyObject])
                                products.append(product)
                            }
                        }
                        finished(products: products)
                    }
                }
            }
        }
    }
    /**
     获取单品详情数据
     */
    func loadProductDetailData(id: Int, finished:(productDetail: LFProductDetail)->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v2/items/\(id)"
        Alamofire
            .request(.GET, url)
            .responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
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
                if let data = dict["data"].dictionaryObject{
                    let productDetail = LFProductDetail(dict: data)
                    finished(productDetail: productDetail)
                }
            }
        }
    }
    /**
     商品详情 评论
     */
    func loadProductDetailComments(id: Int,finished: (comments: [LFComment])->()){
        SVProgressHUD.showWithStatus("正在加载...")
        let url = BASE_URL + "v2/items/\(id)/comments"
        let params = ["limit": 20,
                        "offset": 0]
        Alamofire
            .request(.GET, url, parameters: params)
            .responseJSON { (response) -> Void in
            guard response.result.isSuccess else{
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
                    if let commentsData = data["comments"]?.arrayObject{
                        var comments = [LFComment]()
                        for item in commentsData{
                            let comment = LFComment(dict: item as! [String: AnyObject])
                            comments.append(comment)
                        }
                        finished(comments: comments)
                    }
                }
            }
        }
    }
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
