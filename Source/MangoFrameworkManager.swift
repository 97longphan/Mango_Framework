import UIKit

public struct MangoFrameworkManager {
    
    public static func createRedView() -> UIView {
        return RedView(frame: CGRect(x: 0, y: 0, width: 500, height: 800))
    }
}
