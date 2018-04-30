import UIKit

extension UIColor {
    
    static func from(color: Color) -> UIColor {
        return UIColor(red: CGFloat(color.red) / CGFloat(255), green: CGFloat(color.green) / CGFloat(255), blue: CGFloat(color.blue) / CGFloat(255), alpha: 1)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DemoViewController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
        return true
    }
}


class DemoViewController: UIViewController {
    
    let liveView = LiveView(frame: .zero)
    
    var bitmap: Bitmap!
    
    var fullScreenBitmap: Bitmap!
    var fullScreenContext: CGContext!
    
    let w = 20
    let h = 20
    
    var mainSV: UIStackView!
    
    func makeButton(name: String) -> UIButton {
        
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        // controls
        let sv = UIStackView(
            arrangedSubviews: [
                makeButton(name: "tick"),
                makeButton(name: "reset"),
                makeButton(name: "add pixel")
            ]
        )
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        
        
        mainSV = UIStackView(arrangedSubviews: [sv, liveView])
        view.addSubview(mainSV)
        mainSV.axis = .vertical
//        sv.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        bitmap = FakeBitmap(width: 10, height: 10)
        
        fullScreenContext = CGContext(data: nil,
                                      width: Int(view.bounds.size.width),
                                      height: Int(view.bounds.size.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: Int(view.bounds.size.width) * 4,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        fullScreenBitmap = CoreGraphicsBitmap(context: fullScreenContext)
        
    }
    
    @objc func buttonTapped(sender: UIButton) {
        
        switch sender.titleLabel?.text ?? "" {
        case "tick":
            print("tick")
        case "reset":
            reset()
        case "add pixel":
            addPixel()
            
        default: fatalError()
        }
        
        
        showOnScreen()
    }
    
    func reset() {
        
        bitmap.allWhite()
    }
    
    func addPixel() {
        
        bitmap.set(color: Color.red, coordinate: Coordinate(x: bitmap.width / 2, y: bitmap.height / 2))
    }
    
    private func showOnScreen() {
        
        let w = view.bounds.size.width
        let h = view.bounds.size.height
        
        fullScreenContext.clear(CGRect(x: 0, y: 0, width: w, height: h))
        
        let squareWidth = view.bounds.size.width / CGFloat(bitmap.width)
        let squareHeight = view.bounds.size.height / CGFloat(bitmap.height)
        
        bitmap.forEachCoordinate { coord in
            
            let xPos = Double(coord.x) * Double(squareWidth)
            let yPos = Double(coord.y) * Double(squareHeight)
            
            let c = UIColor.from(color: bitmap.getColor(at: coord))
            fullScreenContext.setFillColor(c.cgColor)
            
            fullScreenContext.fill(CGRect(x: CGFloat(xPos), y: CGFloat(yPos), width: squareWidth, height: squareHeight))
        }
        
        updateSnapshot()
    }
    
    
    
    
    func updateSnapshot() {
        
        let image = UIImage(cgImage: fullScreenContext.makeImage()!)
        liveView.imageView.contentMode = .redraw
        liveView.imageView.image = image
    }
    
    override func viewDidLayoutSubviews() { mainSV.frame = view.bounds }
}










class LiveView: UIView {
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    override func layoutSubviews() { imageView.frame = bounds }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
