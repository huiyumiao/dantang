//
//  MHYDetailViewController.swift
//  dantang
//
//  Created by 苗慧宇 on 02/06/2017.
//  Copyright © 2017 mhy. All rights reserved.
//

import UIKit
import SVProgressHUD
import WebKit

class MHYDetailViewController: MHYBaseViewController, UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate {
    
    var homeItem: MHYHomeItem?
    
    let webView = WKWebView()
    let progressBar = UIProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        let webView = UIWebView()
//        webView.frame = view.bounds
//        webView.scalesPageToFit = true
//        webView.dataDetectorTypes = .all
        
//        let url = URL(string: homeItem!.content_url!)
//        let request = URLRequest(url: url! as URL)
//        webView.loadRequest(request)
//        webView.delegate = self
//        view.addSubview(webView)
        
        
        webView.frame = view.bounds
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        let url = URL(string: homeItem!.content_url!)
        let request = URLRequest(url: url! as URL)
        webView.load(request)
        
        progressBar.frame = CGRect(x: 0, y: 64, width: view.width, height: 30)
        
        progressBar.tintColor = UIColor.black
        webView.addSubview(progressBar)
        view.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progressBar.setProgress(0.2, animated: true)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressBar.alpha = 1.0
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if(webView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                    self.progressBar.alpha = 0.0
                }, completion: { (bool) in
                    self.progressBar.progress = 0.0
                })
            }
        }
    }
    
    
    // MARK: - WKWebView WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - WKWebView WKUIDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        decisionHandler(.allow)
    }
    
    
    // MARK: - UIWebView Delegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show(withStatus: "正在加载...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
