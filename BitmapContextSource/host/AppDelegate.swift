import UIKit

extension UIColor {
    
    static func from(color: BitmapColor) -> UIColor {
        return UIColor(red: CGFloat(color.r), green: CGFloat(color.g), blue: CGFloat(color.b), alpha: CGFloat(color.a))
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

    lazy var fullScreenContext: CGContext = {
        
        guard let context = CGContext(data: nil,
                                      width: Int(view.bounds.size.width),
                                      height: Int(view.bounds.size.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: Int(view.bounds.size.width) * 4,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else { fatalError() }
        
        return context
    }()
    
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
                makeButton(name: "add pixel"),
                makeButton(name: "incr all"),
                makeButton(name: "decr all")
            ]
        )
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        
        
        mainSV = UIStackView(arrangedSubviews: [sv, liveView])
        view.addSubview(mainSV)
        mainSV.axis = .vertical

        bitmap = FakeBitmap(width: 25, height: 25)
        

        reset()
        showOnScreen()
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { t in
            
            self.tick()
            self.showOnScreen()
        }
    }
    
    @objc func buttonTapped(sender: UIButton) {
        switch sender.titleLabel?.text ?? "" {
        case "tick": tick()
        case "reset": reset()
        case "add pixel": addPixel()
        case "incr all": incrAll()
        case "decr all": decrAll()
        default: fatalError()
        }
        showOnScreen()
    }
    
    func reset() {
        bitmap.allBlack()
    }
    
    func addPixel() {
        bitmap.set(color: BitmapColor.white, coordinate: BitmapCoordinate(x: bitmap.width / 2, y: bitmap.height / 2))
        bitmap.set(color: BitmapColor.white, coordinate: BitmapCoordinate(x: (bitmap.width / 2) + 1, y: (bitmap.height / 2)))
        bitmap.set(color: BitmapColor.white, coordinate: BitmapCoordinate(x: (bitmap.width / 2) - 1, y: (bitmap.height / 2)))
    }
    
    func tick() {
        bitmap.algo1()
    }
    
    func incrAll() {
        
        bitmap.forEachCoordinate { c in
            bitmap.brighten(coordinate: c, percent: 0.1)
        }
    }
    
    func decrAll() {
        
        bitmap.forEachCoordinate { c in
            bitmap.darken(coordinate: c, percent: 0.1)
        }
    }
    
    private func showOnScreen() {
        
        // clear screen context
        let w = view.bounds.size.width
        let h = view.bounds.size.height
        fullScreenContext.clear(CGRect(x: 0, y: 0, width: w, height: h))
        
        // up scale
        let squareWidth = view.bounds.size.width / CGFloat(bitmap.width)
        let squareHeight = view.bounds.size.height / CGFloat(bitmap.height)
        
        bitmap.forEachCoordinate { coord in
            
            let xPos = Double(coord.x) * Double(squareWidth)
            let yPos = Double(coord.y) * Double(squareHeight)
            
            let c = UIColor.from(color: bitmap.getColor(at: coord))
            fullScreenContext.setFillColor(c.cgColor)
            
            // draw big pixel
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

