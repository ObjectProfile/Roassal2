Class {
	#name : #RTShowLabelWhenZoomingTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Tests'
}

{ #category : #tests }
RTShowLabelWhenZoomingTest >> testBasic [
	| b labelShapes |
	b := RTMondrian new.
	b shape box size: 30.
	b nodes: (1 to: 9).
	b layout grid.
	b view elements
		@
			(RTLabeled new
				center;
				color: Color red;
				setAsShouldBeInTheFront).
	b view @ RTShowLabelWhenZooming.
	b build.
	
	labelShapes := b view canvas shapes select: [ :s | s isKindOf: TRLabelShape ].
	self assert: (labelShapes allSatisfy: #isVisible).
	b view canvas camera focusOnCenterScaled: 0.5.
	self assert: (labelShapes allSatisfy: #isHidden).
	b view canvas camera focusOnCenterScaled: 2.
	self assert: (labelShapes allSatisfy: #isVisible).
]
