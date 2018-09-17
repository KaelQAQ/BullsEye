//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Abstergo on 2018/9/15.
//  Copyright © 2018年 Abstergo. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "test",withExtension: "html"){
            if let htmlData = try? Data(contentsOf: url){
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html",
                             textEncodingName: "UTF-8",
                             baseURL: baseURL)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}

