import Foundation
import UIKit
import SnapKit

public protocol ProgressViewable: UIView {
    func startAnimating()
    func stopAnimating()
    var isAnimating: Bool { get }
}

public final class ProgressHUD: UIView {
    private static let sharedView: ProgressHUD = {
        let frame: CGRect = UIApplication.shared.delegate?.window??.bounds ?? UIScreen.main.bounds
        let view = ProgressHUD(frame: frame)
        return view
    }()

    private lazy var backgroundView = UIView()
    private lazy var hudView: ProgressViewable = LoadingView()
    private var maxSupportedWindowLevel: UIWindow.Level = .alert + 2
    private(set) var isShowing = false
    private(set) var isEnabled = false
    public static func isVisible() -> Bool {
        return ProgressHUD.sharedView.isShowing
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureHudView()
        backgroundView = createBackgroundView()
        layoutIfNeeded()
        alpha = 0
    }

    required init?(coder _: NSCoder) {
        fatalError("")
    }

    private func createBackgroundView() -> UIView {
        let bgView = UIView(frame: bounds)
        bgView.backgroundColor = .init(white: 0, alpha: 0)
        insertSubview(bgView, belowSubview: hudView)
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return bgView
    }

    private func configureHudView() {
        addSubview(hudView)
        hudView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
    }

    public static func show() {
        ProgressHUD.sharedView.show()
    }

    private func show() {
        isShowing = true
        frontWindow?.addSubview(self)
        frontWindow?.endEditing(true)
        if !hudView.isAnimating {
            hudView.startAnimating()
        }
        UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
            self?.alpha = 1
        }, completion: nil)
    }

    public static func hide() {
        ProgressHUD.sharedView.hide()
    }

    private func hide() {
        isShowing = false
        hudView.stopAnimating()
        UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] _ in
            // In case view's in the background, check "completed" will not work as expected
            guard let self = self else { return }
            // make sure it's still hidden
            if !self.isShowing {
                self.removeFromSuperview()
            }
        })
    }

    private var frontWindow: UIWindow? {
        let frontToBackWindows = UIApplication.shared.windows.reversed()
        for window in frontToBackWindows {
            let windownOnMainScreen = window.screen == UIScreen.main
            let windowIsVisible = !window.isHidden && window.alpha > 0
            let windowLevelSupported = (window.windowLevel >= .normal && window.windowLevel <= maxSupportedWindowLevel)
            let windowKeyWindow = window.isKeyWindow
            if windownOnMainScreen, windowIsVisible, windowLevelSupported, windowKeyWindow {
                return window
            }
        }
        return nil
    }
}

extension ProgressHUD: ProgressHUDLoadable {
    public static func setLoading(_ executing: Bool) {
        if executing != ProgressHUD.isVisible() {
            if executing {
                ProgressHUD.show()
            } else {
                ProgressHUD.hide()
            }
        }
    }
}

public protocol ProgressHUDLoadable {
    static func setLoading(_ isLoading: Bool)
}

extension UIActivityIndicatorView: ProgressViewable {}

private class LoadingView: UIView, ProgressViewable {
    func startAnimating() {
        spinner.startAnimating()
    }

    func stopAnimating() {
        spinner.stopAnimating()
    }

    var isAnimating: Bool { spinner.isAnimating }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubView()
    }

    lazy var box = UIView()
    lazy var spinner = UIActivityIndicatorView(style: .whiteLarge)

    private func setupSubView() {
        box.backgroundColor = .gray
        box.alpha = 0.7
        box.clipsToBounds = true
        box.layer.cornerRadius = 10

        box.addSubview(self.spinner)
        addSubview(box)
        spinner.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.width.height.equalTo(80)
        }

        box.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

