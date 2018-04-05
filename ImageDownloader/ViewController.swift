//
//  ViewController.swift
//  ImageDownloader
//
//  Created by synlex on 2018. 4. 5..
//  Copyright © 2018년 synlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    @IBOutlet weak var indicatiorView: UIActivityIndicatorView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var downloadTask: URLSessionDownloadTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // URLSessionDownloadDelegate - required
    // didFinish
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // url -> data -> image
        //print("location(임시 저장 주소) : \(location)")
        //let dataTemp: Data = try! Data(contentsOf: location)
        //self.imgView.image = UIImage(data: dataTemp)
        
        //indicatiorView.stopAnimating()
    }
    
    // URLSessionDownloadDelegate
    // progress
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        print("패킷용량:\(bytesWritten), 누적용량:\(totalBytesWritten), 전체용량:\(totalBytesExpectedToWrite)")
        let progress: Float = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        self.progressView.setProgress(progress, animated: true)
        
    }

    @IBAction func resumeAction(_ sender: Any) {
        downloadTask.resume()
    }
    
    @IBAction func suspendAction(_ sender: Any) {
        downloadTask.suspend()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        downloadTask.cancel()
        progressView.setProgress(0.0, animated: false)
        indicatiorView.stopAnimating()
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        
        imgView.image = nil
        indicatiorView.startAnimating()
        
        let url = "https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg"
        let sessionConfigration = URLSessionConfiguration.default

        // delegate 방식
        //let session = URLSession(configuration: sessionConfigration, delegate: self, delegateQueue: OperationQueue.main)
        
        // 끝나면(complete) delegate에서 처리
        //downloadTask = session.downloadTask(with: URL(string: url)!)
        
        
        // Closures 방식
        let session = URLSession(configuration: sessionConfigration, delegate: nil, delegateQueue: OperationQueue.main)
        
        // closure - complete : {(data, response, error) -> Void in ... })
        downloadTask = session.downloadTask(with: URL(string: url)!, completionHandler: {(returnUrl, response, error) -> Void in
            
            //print("\(returnUrl!), \(response!)")
            let dataTemp: Data = try! Data(contentsOf: returnUrl!)
            self.imgView.image = UIImage(data: dataTemp)
            
            self.indicatiorView.stopAnimating()
        })
        

        downloadTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

