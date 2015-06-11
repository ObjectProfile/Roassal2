"
A GTSpotterPrintDateAndTimeTest is a test class for testing the behavior of GTSpotterPrintDateAndTime
"
Class {
	#name : #GTSpotterPrintDateAndTimeTest,
	#superclass : #TestCase,
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #tests }
GTSpotterPrintDateAndTimeTest >> testUCTPlus1 [
	| dateAndTime string |
	dateAndTime := '2015-03-27T14:59:05.524852+01:00' asDateAndTime.
	string := GTAPrintDateAndTime yyyyMmDdAndHhMmSs: dateAndTime.
	self assert: string equals: '2015-03-27, 13:59:05'.
]
