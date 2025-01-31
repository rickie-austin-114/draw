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
            context.move(to: CGPoint(x: rect.width / 2, y: 10)) // Start point
            context.addLine(to: CGPoint(x: rect.width - 10, y: rect.height / 2)) // End point
            context.addLine(to: CGPoint(x: rect.width / 2, y: rect.height - 10)) // End point
            context.addLine(to: CGPoint(x: 10, y: rect.height / 2)) // End point
            context.addLine(to: CGPoint(x: rect.width / 2, y: 10)) // End point

            context.move(to: CGPoint(x: 30, y: rect.height / 2)) // Start point
            context.addLine(to: CGPoint(x: 60, y: rect.height / 2 + 30))
            context.addLine(to: CGPoint(x: rect.width - 30, y: 30))

            
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
    @State private var showLine1 = false // State variable to toggle line visibility
    @State private var showLine2 = false // State variable to toggle line visibility
    @State private var showLine3 = false // State variable to toggle line visibility
    @State private var showLine4 = false // State variable to toggle line visibility

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
    @State private var previousImages: [Int] = []

    var body: some View {
        VStack (spacing: 0){
            HStack (spacing: 0){
                ZStack {
                    // Background color for each element
                    colors[0] // Use the corresponding color for each image
                    
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[0]), showLine: $showLine1) // Replace with your image name
                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                        .frame(height: 150) // Set a fixed height
                        .clipped()
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine1.toggle()
                        }
                }
                .padding(0)

                ZStack {
                    // Background color for each element
                    colors[1] // Use the corresponding color for each image
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[1]), showLine: $showLine2) // Replace with your image name
                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                        .frame(height: 150) // Set a fixed height
                        .clipped()
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine2.toggle()
                        }
                }
                .padding(0)

            }
            .padding(0)

            HStack (spacing: 0) {
                ZStack {
                    // Background color for each element
                    colors[2] // Use the corresponding color for each image
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[2]), showLine: $showLine3) // Replace with your image name
                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                        .frame(height: 150) // Set a fixed height
                        .clipped()
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine3.toggle()
                        }
                }
                .padding(0)

                ZStack {
                    // Background color for each element
                    colors[3] // Use the corresponding color for each image
                    
                    ImageLineViewRepresentable(image: UIImage(named: selectedImages[3]), showLine: $showLine4) // Replace with your image name
                        .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                        .frame(height: 150) // Set a fixed height
                        .clipped()
                        .border(Color.black) // Optional border for visibility
                        .onTapGesture {
                            // Toggle line visibility on tap
                            showLine4.toggle()
                        }
                    
                }
                .padding(0)

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
            .padding(0)

        }
        .padding(0)
        .onAppear {
            selectRandomImages() // Select images when the view appears
        }
    }

    
    private func selectRandomImages() {
        
        var selectedIndexArray = [0, 0, 0, 0]
        
        for i in 0..<4 {
            let randomInteger = Int.random(in: 1...7)
            if previousImages.count > i {
                if randomInteger == previousImages[i]{
                    selectedIndexArray[i] = 0
                } else {
                    selectedIndexArray[i] = randomInteger
                }
            } else {
                selectedIndexArray[i] = randomInteger
            }
            selectedImages[i] = images[selectedIndexArray[i]]
        }
    
        // Update previous images
        previousImages = selectedIndexArray
    }
}

