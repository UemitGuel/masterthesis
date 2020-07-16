//
//  LineGraphDataSource.swift
//  Masterthesis
//
//  Created by Ümit Gül on 16.07.20.
//  Copyright © 2020 Ümit Gül. All rights reserved.
//

import ResearchKit

class LineGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var plotPoints =
    [
        [
            ORKValueRange(value: 8000),
            ORKValueRange(value: 13000),
            ORKValueRange(value: 4000)
        ],
        [
            ORKValueRange(value: 10000),
            ORKValueRange(value: 10000),
            ORKValueRange(value: 10000),
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
    
    func maximumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 14000
    }
    
    func minimumValue(for graphChartView: ORKGraphChartView) -> Double {
        return 0
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        return "\(pointIndex + 1)"
    }
}
