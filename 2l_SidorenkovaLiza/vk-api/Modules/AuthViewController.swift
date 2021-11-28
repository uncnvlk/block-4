//
//  AuthViewController.swift
//  2l_SidorenkovaLiza
//
//  Created by Elizaveta Sidorenkova on 24.10.2021.
//

import UIKit
import WebKit
//import Firebase

class AuthViewController: UIViewController, WKNavigationDelegate {

//    let ref = Database.database().reference(withPath: "Users")
  
    @IBOutlet weak var webView: WKWebView! {
    didSet{
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       authorizeToVKAPI()
    }
    
    func authorizeToVKAPI(){
        var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "oauth.vk.com"
                urlComponents.path = "/authorize"
                urlComponents.queryItems = [
                    URLQueryItem(name: "client_id", value: "7983960"),
                    URLQueryItem(name: "display", value: "mobile"),
                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
//                    URLQueryItem(name: "scope", value: "262150"),
                    URLQueryItem(name: "scope", value: "wall, friends, groups"),
                    URLQueryItem(name: "response_type", value: "token"),
                    URLQueryItem(name: "v", value: "5.81")
                ]
                
                let request = URLRequest(url: urlComponents.url!)
                
                webView.load(request)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
                decisionHandler(.allow)
                return
            }
        
            print(url)
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
            }
            
        guard let token = params["access_token"], let userId = params["user_id"] else {return}
            
            print(token)
        
//        let firebaseUser = FirebaseUser(id: userId)
//        self.ref.setValue(firebaseUser.toAnyObject())
        
        Session.shared.token = token
        Session.shared.userID = userId
            
            performSegue(withIdentifier: "showDubugMenu", sender: nil) 
            
            decisionHandler(.cancel)
        }
}
