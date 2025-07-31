import SwiftUI
import UIKit

// MARK: - SwiftUI Representable Bridge
struct PixelCanvasView: UIViewRepresentable {
    // Bindings to control the canvas from SwiftUI
    @Binding var data: [String]
    let columns: Int
    let rows: Int
    @Binding var selectedColor: String
    @Binding var operation: Operation
    @Binding var clearCanvas: Bool
    @Binding var showGrid: Bool
    @Binding var resetTransform: Bool

    // Creates the custom UIKit view
    func makeUIView(context: Context) -> PixelCanvasUIView {
        let uiView = PixelCanvasUIView(
            initialData: data,
            columns: columns,
            rows: rows
        )
        uiView.delegate = context.coordinator // Set the coordinator as the delegate
        return uiView
    }

    // Updates the UIKit view when SwiftUI state changes
    func updateUIView(_ uiView: PixelCanvasUIView, context: Context) {
        uiView.selectedColor = UIColor(hex: self.selectedColor)
        uiView.operation = self.operation
        uiView.showGrid = self.showGrid

        // Sync data if it has changed from the outside
        let uiViewDataHex = uiView.data.map { $0.toHexString() }
        if uiViewDataHex != self.data {
            uiView.data = self.data.map { UIColor(hex: $0) }
            uiView.setNeedsDisplay()
        }
        
        // Handle the clear canvas command
        if self.clearCanvas {
            uiView.clear()
            // Reset the binding after clearing
            DispatchQueue.main.async {
                self.clearCanvas = false
            }
        }
        
        // Handle the reset transform command
        if self.resetTransform {
            uiView.resetTransform()
            DispatchQueue.main.async {
                self.resetTransform = false
            }
        }
    }

    // Creates the coordinator to handle delegation
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: - Coordinator
    // The Coordinator acts as a delegate for the UIKit view to communicate back to SwiftUI if needed.
    class Coordinator: NSObject, PixelCanvasUIViewDelegate, UIGestureRecognizerDelegate {
        var parent: PixelCanvasView

        init(_ parent: PixelCanvasView) {
            self.parent = parent
        }
        
        // This delegate method allows pan, pinch, and rotate gestures to work together harmoniously.
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        
        // Update the SwiftUI binding when the canvas data changes in the UIKit view
        func canvasDidChange(newData: [UIColor]) {
            let newDataHex = newData.map { $0.toHexString() }
            // To avoid redundant updates, only update if the data is actually different.
            if parent.data != newDataHex {
                DispatchQueue.main.async {
                    self.parent.data = newDataHex
                }
            }
        }
    }
}

// MARK: - Delegate Protocol
// Protocol for the UIKit view to communicate back to the coordinator
protocol PixelCanvasUIViewDelegate: AnyObject, UIGestureRecognizerDelegate {
    func canvasDidChange(newData: [UIColor])
}

// MARK: - Custom UIKit View
class PixelCanvasUIView: UIView {
    weak var delegate: PixelCanvasUIViewDelegate? {
        didSet {
            // When the delegate is set, assign it to the transform gestures
            panGesture.delegate = delegate
            pinchGesture.delegate = delegate
            rotationGesture.delegate = delegate
        }
    }

    // Canvas properties
    var data: [UIColor] {
        didSet {
            // Notify the delegate whenever the data is updated
            self.delegate?.canvasDidChange(newData: self.data)
        }
    }
    let columns: Int
    let rows: Int

    // Drawing properties
    var selectedColor: UIColor = UIColor(hex: "#00ff00")
    var operation: Operation
    var showGrid: Bool = true {
        didSet { setNeedsDisplay() } // Redraw when grid visibility changes
    }

    // Transform properties
    private var viewTransform: CGAffineTransform = .identity {
        didSet { setNeedsDisplay() } // Redraw when transform changes
    }
    private var lastDrawnIndex: Int? = nil
    private var isInitialLayout = true
    
    // Damping factors to make gestures less sensitive
    private let rotationDamping: CGFloat = 0.5
    private let scaleDamping: CGFloat = 0.5
    private let panDamping: CGFloat = 0.4
    
    // Gesture recognizers are now properties of the view
    private let drawGesture = UIPanGestureRecognizer()
    private let tapGesture = UITapGestureRecognizer()
    private let panGesture = UIPanGestureRecognizer()
    private let pinchGesture = UIPinchGestureRecognizer()
    private let rotationGesture = UIRotationGestureRecognizer()
    
    // Custom initializer to receive data from SwiftUI
    init(initialData: [String], columns: Int, rows: Int) {
        self.data = initialData.map { UIColor(hex: $0) }
        self.columns = columns
        self.rows = rows
        self.operation = .draw
        super.init(frame: .zero)
        self.backgroundColor = .gray
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Set up the initial transform once the view has its size.
        if isInitialLayout && bounds != .zero {
            setupInitialTransform()
            isInitialLayout = false
        }
    }

    // MARK: - Drawing Logic
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.setShouldAntialias(false)
        context.setAllowsAntialiasing(false)
        
        // The transform handles all pan/zoom/rotate. The drawing code is now much simpler.
        context.concatenate(viewTransform)

        // The grid is now drawn in a "normalized" coordinate space (0,0 to 16,32).
        // The transform maps this to the screen.
        
        // Draw each pixel
        for row in 0..<rows {
            for col in 0..<columns {
                let index = row * columns + col
                if index < data.count {
                    let cellRect = CGRect(x: CGFloat(col), y: CGFloat(row), width: 1.0, height: 1.0)
                    context.setFillColor(data[index].cgColor)
                    context.fill(cellRect)
                }
            }
        }

        // Draw grid lines if enabled
        if showGrid {
            let scale = sqrt(viewTransform.a * viewTransform.a + viewTransform.c * viewTransform.c)
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(1.0 / scale) // Keep line width consistent when zoomed
            
            for i in 0...rows {
                let y = CGFloat(i)
                context.move(to: CGPoint(x: 0, y: y))
                context.addLine(to: CGPoint(x: CGFloat(columns), y: y))
            }
            for i in 0...columns {
                let x = CGFloat(i)
                context.move(to: CGPoint(x: x, y: 0))
                context.addLine(to: CGPoint(x: x, y: CGFloat(rows)))
            }
            context.strokePath()
        }
    }
    
    // MARK: - Public Methods
    func clear() {
        self.data = Array(repeating: UIColor(hex: "#aaaaaa"), count: columns * rows)
        setNeedsDisplay()
    }
    
    func resetTransform() {
        setupInitialTransform()
    }
    
    private func setupInitialTransform() {
        guard bounds.width > 0, bounds.height > 0 else { return }
        
        let canvasSize = CGSize(width: columns, height: rows)
        let viewSize = bounds.size
        
        let scaleX = (viewSize.width * 0.9) / canvasSize.width
        let scaleY = (viewSize.height * 0.9) / canvasSize.height
        let initialScale = min(scaleX, scaleY)
        
        let scaledCanvasWidth = canvasSize.width * initialScale
        let scaledCanvasHeight = canvasSize.height * initialScale
        let translateX = (viewSize.width - scaledCanvasWidth) / 2
        let translateY = (viewSize.height - scaledCanvasHeight) / 2
        
        // Explicitly cast to CGFloat to resolve any type ambiguity from the calculations above.
        let scaleTransform = CGAffineTransform(scaleX: CGFloat(initialScale), y: CGFloat(initialScale))
        let translateTransform = CGAffineTransform(translationX: CGFloat(translateX), y: CGFloat(translateY))
        self.viewTransform = scaleTransform.concatenating(translateTransform)
    }

    // MARK: - Gesture Setup
    private func setupGestures() {
        // One-finger draw gesture
        drawGesture.addTarget(self, action: #selector(handleDraw(_:)))
        drawGesture.minimumNumberOfTouches = 1
        drawGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(drawGesture)
        
        // Single tap gesture for drawing on one cell
        tapGesture.addTarget(self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)

        // Two-finger pan gesture
        panGesture.addTarget(self, action: #selector(handlePan(_:)))
        panGesture.minimumNumberOfTouches = 2
        panGesture.maximumNumberOfTouches = 2
        addGestureRecognizer(panGesture)

        // Zoom gesture
        pinchGesture.addTarget(self, action: #selector(handlePinch(_:)))
        addGestureRecognizer(pinchGesture)

        // Rotate gesture
        rotationGesture.addTarget(self, action: #selector(handleRotation(_:)))
        addGestureRecognizer(rotationGesture)
    }

    // MARK: - Gesture Handlers
    
    // Helper function to convert a screen point to a grid index
    private func gridIndex(for location: CGPoint) -> Int? {
        // Convert screen location to point within the transformed, normalized grid
        let transformedPoint = location.applying(viewTransform.inverted())
        
        // Check if the touch is within the normalized grid bounds
        guard transformedPoint.x >= 0, transformedPoint.x < CGFloat(columns),
              transformedPoint.y >= 0, transformedPoint.y < CGFloat(rows) else {
            return nil
        }
        
        let col = Int(transformedPoint.x)
        let row = Int(transformedPoint.y)
        
        let index = row * columns + col
        return (index >= 0 && index < data.count) ? index : nil
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended, let index = gridIndex(for: gesture.location(in: self)) else {
            return
        }
        
        let newColor: UIColor = (operation == .erase) ? UIColor(hex: "#FFFFFF") : selectedColor
        
        if data[index] != newColor {
            var newData = self.data
            newData[index] = newColor
            self.data = newData
            setNeedsDisplay()
        }
    }

    @objc private func handleDraw(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        
        guard let index = gridIndex(for: location) else {
            lastDrawnIndex = nil
            if gesture.state == .ended || gesture.state == .cancelled {
                lastDrawnIndex = nil
            }
            return
        }
        
        if lastDrawnIndex != index || gesture.state == .began {
            
            let newColor: UIColor = (operation == .erase) ? UIColor(hex: "#FFFFFF") : selectedColor
            
            if data[index] != newColor {
                var newData = self.data // Create mutable copy
                newData[index] = newColor
                self.data = newData // Assigning triggers didSet, which calls the delegate
                setNeedsDisplay() // Redraw the view
            }
            lastDrawnIndex = index
        }
        
        if gesture.state == .ended || gesture.state == .cancelled {
            lastDrawnIndex = nil
        }
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        var translation = gesture.translation(in: self)
        
        // Apply damping to the pan gesture to make it slower and less sensitive.
        translation.x *= panDamping
        translation.y *= panDamping
        
        // To make panning intuitive after rotation, we must apply the translation
        // AFTER the existing view transform. This moves the canvas in screen-space,
        // which is what feels natural. The previous implementation had this backwards.
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        viewTransform = viewTransform.concatenating(translationTransform)
        
        gesture.setTranslation(.zero, in: self)
    }

    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        // Apply damping to the scale to make zooming less sensitive
        let scale = 1.0 + (gesture.scale - 1.0) * scaleDamping
        let location = gesture.location(in: self)
        
        // Translate to the pinch location, scale, and then translate back
        let translateToOrigin = CGAffineTransform(translationX: -location.x, y: -location.y)
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        let translateBack = CGAffineTransform(translationX: location.x, y: location.y)
        
        let newTransform = viewTransform
            .concatenating(translateToOrigin)
            .concatenating(scaleTransform)
            .concatenating(translateBack)
        
        viewTransform = newTransform
        gesture.scale = 1.0
    }

    @objc private func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        // Apply damping to the rotation to make it less sensitive
        let rotation = gesture.rotation * rotationDamping
        let location = gesture.location(in: self)
        
        // Translate to the rotation location, rotate, and then translate back
        let translateToOrigin = CGAffineTransform(translationX: -location.x, y: -location.y)
        let rotateTransform = CGAffineTransform(rotationAngle: rotation)
        let translateBack = CGAffineTransform(translationX: location.x, y: location.y)
        
        let newTransform = viewTransform
            .concatenating(translateToOrigin)
            .concatenating(rotateTransform)
            .concatenating(translateBack)

        viewTransform = newTransform
        gesture.rotation = 0
    }
}

// Helper extension to create UIColor from hex string
extension UIColor {
    convenience init(hex: String, opacity: Double = 1.0) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: CGFloat(opacity))
    }
    
    // Helper to convert back to a hex string for data binding
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
    }
}
