import SwiftUI
import WebKit

struct ContentView: View {
    @State private var isLoading = true
    @State private var showError = false

    var body: some View {
        ZStack {
            WebViewContainer(isLoading: $isLoading, showError: $showError)
                .edgesIgnoringSafeArea(.bottom)

            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "2563EB")))
                        .padding(.horizontal)
                    Spacer()
                }
            }

            if showError {
                ErrorView {
                    showError = false
                    isLoading = true
                    NotificationCenter.default.post(name: .reload, object: nil)
                }
            }
        }
    }
}

// MARK: - WebView Wrapper
struct WebViewContainer: UIViewRepresentable {
    @Binding var isLoading: Bool
    @Binding var showError: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.scrollView.bounces = true
        webView.allowsBackForwardNavigationGestures = true

        // Pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.145, green: 0.388, blue: 0.922, alpha: 1)
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh(_:)), for: .valueChanged)
        webView.scrollView.refreshControl = refreshControl

        context.coordinator.webView = webView

        // Listen for reload
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.reload),
            name: .reload,
            object: nil
        )

        let url = URL(string: "https://ebp-diabetes-prediction.vercel.app")!
        webView.load(URLRequest(url: url))

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewContainer
        weak var webView: WKWebView?

        init(_ parent: WebViewContainer) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            parent.showError = false
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            webView.scrollView.refreshControl?.endRefreshing()
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            parent.showError = true
            webView.scrollView.refreshControl?.endRefreshing()
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url,
               !url.absoluteString.contains("ebp-diabetes-prediction.vercel.app"),
               navigationAction.navigationType == .linkActivated {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        @objc func handleRefresh(_ sender: UIRefreshControl) {
            webView?.reload()
        }

        @objc func reload() {
            let url = URL(string: "https://ebp-diabetes-prediction.vercel.app")!
            webView?.load(URLRequest(url: url))
        }
    }
}

// MARK: - Error View
struct ErrorView: View {
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("📡")
                .font(.system(size: 48))
            Text("인터넷 연결 없음")
                .font(.title2.weight(.semibold))
                .foregroundColor(Color(hex: "1e293b"))
            Text("네트워크 연결을 확인하고\n다시 시도해 주세요.")
                .font(.subheadline)
                .foregroundColor(Color(hex: "64748b"))
                .multilineTextAlignment(.center)
            Button(action: onRetry) {
                Text("다시 시도")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color(hex: "2563EB"))
                    .cornerRadius(10)
            }
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "f0f4f8"))
    }
}

// MARK: - Notification Extension
extension Notification.Name {
    static let reload = Notification.Name("reloadWebView")
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }
}

#Preview {
    ContentView()
}
