//
//  WebView.swift
//  XapoTest
//
//  Created by Boris Barac on 05.01.2022.
//

import Foundation
import UIKit
import SwiftUI
import WebKit

struct WebView: UIViewControllerRepresentable {
    typealias UIViewControllerType = WebViewController
    var url: URL

    func makeUIViewController(context: Context) -> WebViewController {
        return WebViewController()
    }

    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {
        uiViewController.load(url)
    }

}

class WebViewController: UIViewController, WKNavigationDelegate {

    private var webView = WKWebView(frame: CGRect.zero)
    private let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        webView.navigationDelegate = self
        webView.scrollView.bounces = false

        [webView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])

        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
    }

    func load(_ url: URL) {
        webView.load(URLRequest(url: url))
    }

    func showActivityIndicator(show: Bool) {
        show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    // MARK: - WKNavigationDelegate,
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }

}
