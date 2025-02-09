/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {
  @State var rTarget = Double.random(in: 0..<1)
  @State var gTarget = Double.random(in: 0..<1)
  @State var bTarget = Double.random(in: 0..<1)
  @State var rGuess: Double
  @State var gGuess: Double
  @State var bGuess: Double

  private func reset() {
    rTarget = Double.random(in: 0..<1)
    gTarget = Double.random(in: 0..<1)
    bTarget = Double.random(in: 0..<1)
    rGuess = 0.5
    gGuess = 0.5
    bGuess = 0.5
  }

  @State var showAlert = false
  
  func computeScore() -> Int {
    let rDiff = rGuess - rTarget
    let gDiff = gGuess - gTarget
    let bDiff = bGuess - bTarget
    let diff = sqrt((rDiff * rDiff + gDiff * gDiff + bDiff * bDiff) / 3.0)
    return lround((1.0 - diff) * 100.0)
  }
  
  var body: some View {
    NavigationView {
      VStack {
          HStack {
            VStack {
              Color(red: rTarget, green: gTarget, blue: bTarget)
              self.showAlert ? Text("R: \(Int(rTarget * 255.0))"
                + "  G: \(Int(gTarget * 255.0))"
                + "  B: \(Int(bTarget * 255.0))")
                : Text("Match this color")
            }

            VStack {
              Color(red: rGuess, green: gGuess, blue: bGuess)
              Text("R: \(Int(rGuess * 255.0))"
                + "  G: \(Int(gGuess * 255.0))"
                + "  B: \(Int(bGuess * 255.0))")
            }
          }

          Button(action: {
            self.showAlert = true
          }) { Text("Hit Me!") }
          .alert(isPresented: $showAlert) {
            Alert(title: Text("Your Score"),
              message: Text(String(computeScore())),
              dismissButton: .default(Text("OK"),
                action: { self.reset() }
            ))
          }
          .padding()

          VStack {
            ColorSliderView(value: $rGuess, textColor: .red)
            ColorSliderView(value: $gGuess, textColor: .green)
            ColorSliderView(value: $bGuess, textColor: .blue)
          }
          .padding(.horizontal)
          NavigationLink(destination: ViewControllerRepresentation()) {
            Text("Play BullsEye")
          }
          .padding(.bottom)
        }
      .navigationBarTitle("RGBullsEye")
      .background(Color(.systemBackground))
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
      .previewLayout(.fixed(width: 568, height: 320))
  }
}

struct ColorSliderView: View {
  @Binding var value: Double
  var textColor: UIColor
  
  var body: some View {
    HStack {
      Text("0")
        .foregroundColor(Color(textColor))
      
      // TODO: - Replace with fancy ColorUISlider
//      Slider(value: $value)
			ColorSlider(color: textColor, value: $value)
      
      Text("255")
        .foregroundColor(Color(textColor))
    }
  }
}
