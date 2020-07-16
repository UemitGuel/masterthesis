
import ResearchKit

class DiscreteGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var textForX = ["-60 bis -40", "-40 bis -20", "-20 bis heute" ]
    
    var plotPoints =
    [
        [
            ORKValueRange(minimumValue: 0, maximumValue: 2),
            ORKValueRange(value: 13000),
            ORKValueRange(value: 4000)
        ],
        [
            ORKValueRange(minimumValue: -10, maximumValue: -3),
            ORKValueRange(minimumValue: 0, maximumValue: 10),
            ORKValueRange(minimumValue: 0, maximumValue: 10),
        ]
    ]
    
    // MARK: ORKGraphChartViewDataSource
    
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        return textForX[pointIndex]
    }
}

