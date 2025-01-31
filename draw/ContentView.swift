import SwiftUI
import UIKit

// Custom UIView to draw an image and a line
class ImageLineView: UIView {
    var image: UIImage?
    var showLine: Bool = true // Property to control line visibility
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), let image = image else { return }

        // Draw the image
        image.draw(in: rect)

        if showLine {
            // Set the line color and line width
            context.setStrokeColor(UIColor.red.cgColor)
            context.setLineWidth(5.0)

            // Draw a line
            context.move(to: CGPoint(x: 20, y: 20)) // Start point
            context.addLine(to: CGPoint(x: rect.width - 20, y: rect.height - 20)) // End point

            // Stroke the path
            context.strokePath()
        }
    }
}


// UIViewRepresentable to use ImageLineView in SwiftUI
struct ImageLineViewRepresentable: UIViewRepresentable {
    var image: UIImage?
    @Binding var showLine: Bool // Binding to control line visibility

    func makeUIView(context: Context) -> ImageLineView {
        let imageLineView = ImageLineView()
        imageLineView.image = image
        return imageLineView
    }

    func updateUIView(_ uiView: ImageLineView, context: Context) {
        uiView.image = image
        uiView.showLine = showLine // Update line visibility
        uiView.setNeedsDisplay()
    }
}

// Main SwiftUI View
struct ContentView: View {
    @State private var showLine1 = true // State variable to toggle line visibility
    @State private var showLine2 = true // State variable to toggle line visibility
    @State private var showLine3 = true // State variable to toggle line visibility
    @State private var showLine4 = true // State variable to toggle line visibility

    let images = [
        "image1",
        "image2",
        "image3",
        "image4",
        "image5",
        "image6",
        "image7",
        "image8"
    ]
    
    let colors: [Color] = [
        .red, .green, .blue, .orange,
        .purple, .yellow, .pink, .gray
    ]
    
    @State private var selectedImages: [String] = ["image1", "image2", "image3", "image4"]
    @State private var previousImages: [String] = []

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    // Background color for each element
                    colors[0] // Use the corresponding color for each image
                        .cornerRadius(10) // Optional: round the corners
                    
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[0]), showLine: $showLine1) // Replace with your image name
                        .frame(width: 150, height: 150) // Set desired frame size
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine1.toggle()
                        }
                }
                ZStack {
                    // Background color for each element
                    colors[1] // Use the corresponding color for each image
                        .cornerRadius(10) // Optional: round the corners
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[1]), showLine: $showLine2) // Replace with your image name
                        .frame(width: 150, height: 150) // Set desired frame size
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine2.toggle()
                        }
                }
            }
            HStack {
                ZStack {
                    // Background color for each element
                    colors[2] // Use the corresponding color for each image
                        .cornerRadius(10) // Optional: round the corners
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[2]), showLine: $showLine3) // Replace with your image name
                        .frame(width: 150, height: 150) // Set desired frame size
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine3.toggle()
                        }
                }
                ZStack {
                    // Background color for each element
                    colors[3] // Use the corresponding color for each image
                        .cornerRadius(10) // Optional: round the corners
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[3]), showLine: $showLine4) // Replace with your image name
                        .frame(width: 150, height: 150) // Set desired frame size
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine4.toggle()
                        }
                }
            }
            Button(action: {
                selectRandomImages()
            }) {
                Text("Reselect Images")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    private func selectRandomImages() {
        // Filter out previous images to ensure no repeats
        let availableImages = images.filter { !previousImages.contains($0) }
        
        // If we don't have enough images to select, reset previous images
        if availableImages.count < 4 {
            previousImages = selectedImages
        }
        
        // Select 4 random images from the available images
        selectedImages = Array(availableImages.shuffled().prefix(4))
        
        // Update previous images
        previousImages = selectedImages
    }
}

