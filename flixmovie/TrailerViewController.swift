//
//  TrailerViewController.swift
//  flixmovie
//
//  Created by Duy Tran Vinh Thai on 2/27/20.
//  Copyright © 2020 Duy Tran Vinh Thai. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate, UIWebViewDelegate{

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //var movie: [String: Any]!
    var movieVideo = [[String : Any]]()
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        backButton.contentHorizontalAlignment = .left;
        backButton.setTitle("Close", for: .normal)
        navigationBar.title = "Trailer"
        // Do any additional setup after loading the view.
        let url = URL(string: ("https://api.themoviedb.org/3/movie/" + String(id) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"))!
//        let url = URL(string: ("https://api.themoviedb.org/3/movie/454626/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"))!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movieVideo = dataDictionary["results"] as! [[String:Any]]
                let baseURL = "https://www.youtube.com/watch?v="
                let movie = self.movieVideo[1]
                let trailerPath = movie["key"] as! String
                let myURL = URL(string: (baseURL + trailerPath))
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
            }
        }
        task.resume()
        print(movieVideo)
//        let movie = movieVideo[1]
//        let trailerPath = movie["key"] as! String
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
