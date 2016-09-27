//
//  ArticleViewController.swift
//  SelectionOfZhihu
//
//  Created by 杨洋 on 16/1/10.
//  Copyright © 2016年 Sheepy. All rights reserved.
//
import UIKit

//enum ScrollDirection {
//    case Up
//    case Down
//    case None
//}

class ArticleViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var urlString: String!
    
    //var oldY: CGFloat = 0
    //var newY: CGFloat = 0
    //var scrollDirection: ScrollDirection = .None
    
    func loadUrl() {
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUrl()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)//animated
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension ArticleViewController: UIWebViewDelegate {
//    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        if let url = request.URL {
//            // 拦截url
//            if url.absoluteString.containsString("login") { // 去登陆
//                self.navigationController?.pushViewController(nil(params: ["": ""]), animated: true)
//                return false
//            }
//        }
//
//        return true
//    }
    
   
    func webViewDidStartLoad(webView: UIWebView)
    {
        //开始动画
       //loadingView.startAnimating()
        //loadingView.stopAnimating()
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    {
        loadingView.stopAnimating()
    }
    func webViewDidFinishLoad(webView: UIWebView)
    {
        //[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('AppHeader')[0].style.display = 'NONE'"];
        //[webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('AppBanner')[0].style.display = 'NONE'"];
        //屏蔽广告
//        self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('AppHeader')[0].style.display = 'NONE'")
//        self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('AppBanner')[0].style.display = 'NONE'")
        //开始动画
        //loadingView.startAnimating()
        //结束动画
        //loadingView.stopAnimating()
        //屏蔽广告
        //头部广告
        self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('AppHeader')[0].style.display = 'NONE'")
        self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('AppBanner')[0].style.display = 'NONE'")
        //中间的广告
        self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('AdBanner-image needsclick')[0].style.display = 'NONE'")
        self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('AdBanner')[0].style.display = 'NONE'")

        //点赞的按钮
         self.webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('ItemActions')[0].style.display = 'NONE'")
        
        

    }
    
}
//extension ArticleViewController: UIScrollViewDelegate {
//    //判断当前是向上还是向下滑动
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        newY = scrollView.contentOffset.y
//        if newY > oldY {
//            scrollDirection = .Up
//        } else if oldY > newY {
//            scrollDirection = .Down
//        }
//        oldY = newY
//    }
//}


