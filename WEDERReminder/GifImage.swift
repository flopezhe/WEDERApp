//
//  GifImage.swift
//  WEDERReminder
//
//  Created by Farid Lopez on 5/27/25.
//

import Foundation
import SwiftUI
import WebKit

enum URLType {
  case name(String)
  case url(URL)

  var url: URL? {
    switch self {
      case .name(let name):
        return Bundle.main.url(forResource: name, withExtension: "gif")
      case .url(let remoteURL):
        return remoteURL
    }
  }
}

struct GifImage: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.isOpaque = false
        webView.backgroundColor = .clear

        container.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: container.topAnchor),
            webView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])

        // In order to get GIF to go full screen we need to do some hmtl/css manually
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let gifData = try? Data(contentsOf: url),
           let base64String = gifData.base64EncodedString(options: .lineLength64Characters) as String? {

            let htmlString = """
            <html>
            <head>
            <style>
            body, html {
                margin: 0; padding: 0; overflow: hidden; background: transparent;
                height: 100%; width: 100%;
                display: flex; justify-content: center; align-items: center;
            }
            img {
                width: 100vw;
                height: 100vh;
                object-fit: cover;
            }
            </style>
            </head>
            <body>
            <img src="data:image/gif;base64,\(base64String)" />
            </body>
            </html>
            """

            webView.loadHTMLString(htmlString, baseURL: nil)
        }

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Left empty on purpose, not needed for my purposes.
    }
    
}


