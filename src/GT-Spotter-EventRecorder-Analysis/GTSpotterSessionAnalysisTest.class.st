"
A GTSpotterDiveInLevelCommandTest is a test class for testing the behavior of GTSpotterDiveInLevelCommand
"
Class {
	#name : #GTSpotterSessionAnalysisTest,
	#superclass : #TestCase,
	#instVars : [
		'analysis'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session1 [
	^ GTASessionExamples session1
]

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session2 [
	^ GTASessionExamples session2
]

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session3 [
	^ GTASessionExamples session3
]

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session4 [
	^ GTASessionExamples session4
]

{ #category : #running }
GTSpotterSessionAnalysisTest >> setUp [
	super setUp.
	analysis := GTASessionAnalysis new.
	
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testCategoriesSession2 [
	| session |
	analysis session: self session2.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 11.
	self assert: (session at: 4) categoryEvent equals: (session at: 5).
	self assert: (session at: 5) elementSelectionEvents size equals: 3.
	self assert: (session at: 5) elementSelectionEvents first equals: (session at: 4).
	self assert: (session at: 5) elementSelectionEvents second equals: (session at: 7).
	self assert: (session at: 5) elementSelectionEvents third equals: (session at: 8).
	self assert: (session at: 9) categoryEvent equals: (session at: 10).
	self assert: (session at: 10) elementSelectionEvents size equals: 1.
	self assert: (session at: 10) elementSelectionEvents first equals: (session at: 9).

]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testCategoriesSession4 [
	| session |
	analysis session: self session4.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 20.
	self assert: (session at: 4) categoryEvent equals: (session at: 5).
	self assert: (session at: 7) categoryEvent equals: (session at: 5).
	self assert: (session at: 8) categoryEvent equals: (session at: 9).
	self assert: (session at: 12) categoryEvent equals: (session at: 9).
	self assert: (session at: 13) categoryEvent equals: (session at: 14).
	self assert: (session at: 16) categoryEvent equals: (session at: 14).
	self assert: (session at: 17) categoryEvent equals: (session at: 14).
	self assert: (session at: 18) categoryEvent equals: (session at: 14).
	self assert: (session at: 19) categoryEvent equals: (session at: 14).

	self assert: (session at: 5) elementSelectionEvents size equals: 2.
	self assert: (session at: 9) elementSelectionEvents size equals: 2.
	self assert: (session at: 14) elementSelectionEvents size equals: 5.

	self assert: (session at: 5) elementSelectionEvents first equals: (session at: 4).
	self assert: (session at: 5) elementSelectionEvents second equals: (session at: 7).

	self assert: (session at: 9) elementSelectionEvents first equals: (session at: 8).
	self assert: (session at: 9) elementSelectionEvents second equals: (session at: 12).

	self assert: (session at: 14) elementSelectionEvents first equals: (session at: 13).
	self assert: (session at: 14) elementSelectionEvents second equals: (session at: 16).
	self assert: (session at: 14) elementSelectionEvents third equals: (session at: 17).
	self assert: (session at: 14) elementSelectionEvents fourth equals: (session at: 18).
	self assert: (session at: 14) elementSelectionEvents fifth equals: (session at: 19).

]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testMissStepsSession1 [
	| session |
	analysis session: self session1.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 27.
	self assert: session numberOfMissSteps equals: 1.
	self assert: (session at: 6) isMissStep.
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testMissStepsSession2 [
	| session |
	analysis session: self session2.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 11.
	self assert: session numberOfMissSteps equals: 0.
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testMissStepsSession3 [
	| session |
	analysis session: self session3.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 20.
	self assert: (session at: 9) isMissStep.
	self deny: (session at: 16) isMissStep.
	self assert: session numberOfMissSteps equals: 1.
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testRootsSession1 [
	| roots |
	analysis session: self session1.
	analysis execute.
	roots := analysis session roots.
	self assert: roots size equals: 11.
	self assert: (roots at: 6) children size equals: 4.
	self assert: (roots at: 1) children size equals: 0.
	self assert: (roots at: 7) children size equals: 8.
	self assert: ((roots at: 7) children at: 4) children size equals: 4.

]
