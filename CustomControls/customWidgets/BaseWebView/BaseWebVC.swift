//
//  BaseWebVC.swift
//  CustomControls
//
//  Created by MacBook Pro on 2021/1/11.
//  Copyright © 2021 WJQ. All rights reserved.
//

import UIKit
import WebKit

class BaseWebVC: UIViewController{

    var URLString: String?
    var HTMLString: String?
    var share: Bool = false
    
    
    //MARK: 懒加载
    fileprivate lazy var backBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(named: "BaseWebVC.bundle/BaseWebBack"), style: .plain, target: self, action: #selector(goBackTapped(_:)))
        item.width = 50
        return item
    }()
    
    fileprivate lazy var forwardBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(named: "BaseWebVC.bundle/BaseWebNext"), style: .plain, target: self, action: #selector(goForwardTapped(_:)))
        item.width = 50
        return item
    }()
    
    fileprivate lazy var refreshBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadTapped(_:)))
        return item
    }()
    
    fileprivate lazy var stopBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(stopTapped(_:)))
        return item
    }()
    
    fileprivate lazy var actionBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionButtonTapped(_:)))
        return item
    }()
    
    fileprivate lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.allowsInlineMediaPlayback = true
        config.allowsAirPlayForMediaPlayback = false
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.backgroundColor = .white
        return webView
    }()
    
    fileprivate lazy var progressView: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 2)
        progress.tintColor = .blue
        return progress
    }()
    
    fileprivate lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: .zero)
        toolBar.tintColor = .darkGray
        return toolBar
    }()
    
    fileprivate var didFinishLoad: Bool?

    
    deinit {
        webView.stopLoading()
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.navigationDelegate = nil
        webView.uiDelegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.toolBar)
        self.webView.addSubview(self.progressView)
        self.view.addSubview(self.webView)

        if let urlStr = URLString {
            if let URL = URL(string: urlStr) {
                let request = URLRequest(url: URL)
                webView.load(request)
            }
        }else if let HTMLStr = HTMLString {
            webView.loadHTMLString(HTMLStr, baseURL: nil)
        }
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        self.updateToolbarItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var bottom = 0
        if (UIApplication.shared.statusBarFrame.size.height > 20) {
            bottom = 34;
        }
        self.toolBar.frame = CGRect(x: 0, y: self.view.frame.size.height - 44 - CGFloat(bottom), width: self.view.frame.size.width, height: 44)
        self.webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - self.toolBar.frame.size.height - CGFloat(bottom))
    }
    
    private func updateToolbarItems() {
        self.backBarButtonItem.isEnabled = self.webView.canGoBack;
        self.forwardBarButtonItem.isEnabled = self.webView.canGoForward;
        let refreshStopBarButtonItem: UIBarButtonItem = self.webView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        var items = [fixedSpace,self.backBarButtonItem,
                     fixedSpace,self.forwardBarButtonItem,
                     flexibleSpace,refreshStopBarButtonItem]
        
        if share == true {
            items = [fixedSpace, self.backBarButtonItem,
                     flexibleSpace, self.forwardBarButtonItem,
                     flexibleSpace, refreshStopBarButtonItem,
                     flexibleSpace, self.actionBarButtonItem,
                     fixedSpace]
        }
        
        if let navigationController = self.navigationController {
            self.toolBar.barStyle = navigationController.navigationBar.barStyle;
            self.toolBar.tintColor = navigationController.navigationBar.tintColor;
        }
        self.toolBar.items = items;
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" && object as! NSObject == webView {
            self.progressView.alpha = 1.0
            self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: { () -> Void in
                    self.progressView.alpha = 0.0
                }, completion: { (finished:Bool) -> Void in
                    self.progressView.setProgress(0.0, animated: true)
                })
            }
        }else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
}

extension BaseWebVC {
    @objc fileprivate func goBackTapped(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc fileprivate func goForwardTapped(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc fileprivate func reloadTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @objc fileprivate func stopTapped(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        updateToolbarItems()
    }
    
    @objc fileprivate func actionButtonTapped(_ sender: UIBarButtonItem) {
        if let url = self.webView.url {
            if url.absoluteString.hasPrefix("file:///") {
                let dc = UIDocumentInteractionController(url: url)
                dc.presentOptionsMenu(from: self.view.bounds, in: self.view, animated: true)
            }else{
                let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: [BaseWebActivitySafari() ,BaseWebActivityChrome()])
                present(activityVC, animated: true, completion: nil)
            }
        }
    }
    
}

extension BaseWebVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        updateToolbarItems()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinishLoad = true
        if URLString != nil {
            webView.evaluateJavaScript("document.title") { (object, error) in
                if let obj = object as? String {
                    self.navigationItem.title = obj
                }
            }
        }
        updateToolbarItems()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        updateToolbarItems()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}

extension BaseWebVC: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { (UIAlertAction) in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (UIAlertAction) in
            completionHandler(false)
        }))
        
        alert.addAction(UIAlertAction(title: "确认", style: .default, handler: { (UIAlertAction) in
            completionHandler(true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alert = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = defaultText
        }
        
        alert.addAction(UIAlertAction(title: "完成", style: .default, handler: { (UIAlertAction) in
            completionHandler(alert.textFields?.first?.text);
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


