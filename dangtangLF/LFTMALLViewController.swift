

import UIKit

class LFTMALLViewController: UIViewController {

    var webView = UIWebView()
    var product: LFProduct?
    var result: LFSearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        //自动对页面进行缩放以适应屏幕
        webView.frame = CGRectMake(0, 0, SCREENW, SCREENH)
        webView.dataDetectorTypes = .All
        if product == nil{
            
        }else{
            let url = NSURL(string: product!.purchase_url!)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
            view.addSubview(webView)
        }

    }

    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: Selector("navigationBackClick"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: Selector("shareBBItemClick"))
    }
    
    func shareBBItemClick(){
        LFActionSheet.show()
    }
    
    func navigationBackClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }

}

extension LFTMALLViewController: UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
