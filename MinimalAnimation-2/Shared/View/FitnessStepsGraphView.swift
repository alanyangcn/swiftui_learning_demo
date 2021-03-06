//
//  FitnessStepsGraphView.swift
//  MinimalAnimation-2 (iOS)
//
//  Created by 杨立鹏 on 2022/3/15.
//

import SwiftUI

struct FitnessStepsGraphView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Steps by hours")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            BarGraph(steps: steps)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.ultraThinMaterial)
        }
    }
}

struct FitnessStepsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct BarGraph: View {
    var steps: [Step]
    
    var body: some View {
       
        GraphView()
            .padding(.top, 20)
    }
    
    @ViewBuilder
    func GraphView() -> some View {
        GeometryReader { proxy in
            ZStack {
                
                VStack(spacing: 0) {
                    ForEach(getGraphLines(), id: \.self) { line in
                        HStack(spacing: 0){
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity,alignment: .bottom)
                        .offset(y: -15)
                    }
                }
                
                
                HStack  {
                    ForEach(steps.indices, id: \.self) { index in
                        
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                AnimatedBarGraph(step: steps[index], index: index)
                            }
                            .padding(.horizontal, 5)
                            .frame(height: getBarHeight(point: steps[index].value, size: proxy.size))
                            
                            Text(
                                steps[index].key
                                    .replacingOccurrences(of: " AM", with: "")
                                    .replacingOccurrences(of: " PM", with: "")
                            )
                                .font(.caption)
                                .frame(height: 25, alignment: .bottom)
                        }
                        
                        
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .center)
        }
        
        .frame(height: 190)
    }
    
    func getBarHeight(point: CGFloat, size: CGSize) -> CGFloat {
        
        let max = getMax()
        
        let height = (point / max) * (size.height - 37)
        
        return height
    }
    
    func getGraphLines() -> [CGFloat] {
        let max = getMax()
        
        var lines: [CGFloat] = []
        
        lines.append( max)
        
        for index in 1...4 {
            let progress = max / 4
            
            lines.append(max - (progress * CGFloat(index)))
        }
        
        return lines
    }
    
    func getMax() -> CGFloat {
        let max = steps.max { first, scnd in
            return scnd.value > first.value
        }?.value ?? 0
        
        return max
        
    }
}


struct AnimatedBarGraph: View {
    
    var step: Step
    var index: Int
    
    @State var showBar: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(step.color)
                .frame(height: showBar ? nil : 0, alignment: .bottom)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8).delay(Double(index) * 0.1)) {
                    showBar = true
                }
            }
        }
    }
}
