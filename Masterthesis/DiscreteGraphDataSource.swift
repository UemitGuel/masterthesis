
import ResearchKit

class DiscreteGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var axisText = ["", "1", "2", ""]
    
    var plotPoints =
    [
        [
            ORKValueRange(value: 0),
            ORKValueRange(value: 5),
            ORKValueRange(value: 5),
            ORKValueRange(value: 0),

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
        return axisText[pointIndex]
    }
}
