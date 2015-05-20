Class {
	#name : #RTCursorFollower,
	#superclass : #RTAbstractGrapherDecorator,
	#instVars : [
		'lineH',
		'canvas',
		'lineV',
		'labelH',
		'labelV',
		'labelXTextConvertion',
		'labelYTextConvertion'
	],
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #testing }
RTCursorFollower >> convertPointForGraph: p [
	^ p x @ p y negated
]

{ #category : #createLinesAndLabels }
RTCursorFollower >> createLinesAndLabelsIfNecessary [
	lineH
		ifNil: [ 
			lineH := TRLineShape new.
			canvas := builder view canvas.
			canvas addShape: lineH.
			lineV := TRLineShape new.
			canvas addShape: lineV.
			
			labelH := TRLabelShape new.
			canvas addShape: labelH.
			labelV := TRLabelShape new.
			canvas addShape: labelV.]
]

{ #category : #drawing }
RTCursorFollower >> getLabelXValueFor: pp [
	^ (labelXTextConvertion rtValue: pp x) asString
]

{ #category : #drawing }
RTCursorFollower >> getLabelYValueFor: pp [
	^ (labelYTextConvertion rtValue: pp y negated) asString
]

{ #category : #drawing }
RTCursorFollower >> getPositionFromPixel: p [
	^ builder getPositionFromPixelPosition: (self convertPointForGraph: p)
]

{ #category : #'as yet unclassified' }
RTCursorFollower >> initialize [
	super initialize.
	labelXTextConvertion := [ :v | v round: 2 ].
	labelYTextConvertion := [ :v | v round: 2 ]
]

{ #category : #testing }
RTCursorFollower >> isPointOverTheBuilder: p [
	| pp |
	pp := self convertPointForGraph: p.
	^ pp >= (0 @ 0) and: [ pp <= builder extent ]
]

{ #category : #createLinesAndLabels }
RTCursorFollower >> removeLinesAndLabelsIfNecessary [
	lineH notNil
		ifTrue: [ 
			lineH remove.
			lineV remove.
			labelH remove.
			labelV remove.
			self updateCanvas.
			lineH := nil.
			lineV := nil.
			labelH := nil.
			labelV := nil ]
]

{ #category : #drawing }
RTCursorFollower >> render [
	| p pp |
	builder view
		when: TRMouseMove
		do: [ :evt | 
			p := evt positionFromCamera.
			(self isPointOverTheBuilder: p)
				ifTrue: [ 
					self createLinesAndLabelsIfNecessary.
					lineH from: 0 @ p y to: builder extent x @ p y.
					lineV from: p x @ 0 to: p x @ builder extent y negated.
					pp := self getPositionFromPixel: p.
					labelV text: (self getLabelXValueFor: pp).
					labelV translateTo: p x @ builder extent y negated.
					labelH text: (self getLabelYValueFor: pp).
					labelH translateTo: builder extent x @ p y.
					self updateCanvas ]
				ifFalse: [ self removeLinesAndLabelsIfNecessary ] ]
]

{ #category : #createLinesAndLabels }
RTCursorFollower >> updateCanvas [
	canvas signalUpdate
]
