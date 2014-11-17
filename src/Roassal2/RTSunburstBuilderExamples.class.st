Class {
	#name : #RTSunburstBuilderExamples,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #examples }
RTSunburstBuilderExamples >> basic0 [
	"
	self new basic0
	"
	| b n nc1 nc2 nc3 nc4 nc5|
	b := RTSunburstBuilder new.
	n:= RTNode new.
	nc1:= RTNode new.
	nc2:= RTNode new.
	nc3:= RTNode new.
	nc4:=RTNode new.
	nc5:=RTNode new.
	n addChild: nc1.
	n addChild: nc2.
	n addChild: nc3.
	nc2 addChild: nc4.
	nc2 addChild: nc5.
	n accept: b visitor.
	b view @ RTDraggableView.
	b open.
	
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic1 [
	"
	self new basic1
	"
	| b|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic10 [
	"
	self new basic10
	"	
	| b data |
	data := { 'Chile' -> { 'Santiago' . 'Iquique' } . 'France' -> { 'Paris' . 'Nice' } }.
	b := RTSunburstBuilder new.

	b 
		explore: data 
		using: [ :o | 
			o class == Association 
				ifTrue: [ o value ] 
				ifFalse: [ o isString 
									ifTrue: [ #() ] 
									ifFalse:  [ o ] ] ].
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic11 [
	"
	self new basic11
	"	
	| b data |
	data := { 'Chile' -> { 'Santiago' . 'Iquique' } . 'France' -> { 'Paris' . 'Nice' } }.
	b := RTSunburstBuilder new.
	b interactions add: RTSBFadeInteraction new.
	b 
		explore: data 
		using: [ :o | 
			o class == Association 
				ifTrue: [ o value ] 
				ifFalse: [ o isString 
									ifTrue: [ #() ] 
									ifFalse:  [ o ] ] ].
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic12 [
	"
	self new basic12
	"	
	| b |
	b := RTSunburstBuilder new.
	b radialSpacing: 5.
	
	b interactions add: RTSBFadeInteraction new.
	b shape current 
				color: [ :m | m children notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
 	b weight: [ :m | m tally ].
	b explore: (MessageTally new
     spyEvery: 1
     on: [ Nautilus open ];
     yourself) using: #children.
	b view @ RTDraggableView.
	b open.
	b view canvas focusOnCenterScaled.
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic13 [
	"
	self new basic13
	"	
	| b |
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b radialSpacing: 1.
	
	b interactions add: RTSBFadeInteraction new.
	b shape current 
				color: [ :m | m children notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
 	b weight: [ :m | m tally ].
	b explore: (MessageTally new
     spyEvery: 1
     on: [ Nautilus open ];
     yourself) using: #children.
	b view @ RTDraggableView.
	b open.
	b view canvas focusOnCenterScaled.
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic14 [
	"
	self new basic14
	"
	| b|
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic15 [
	"
	self new basic15
	"
	| b|
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b strategy hasCenter: false.
	b radialSpacing: 0.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic2 [
	"
	self new basic2
	"
	| b|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b strategy hasCenter: false.
	b radialSpacing: 0.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic3 [
	"
	self new basic3
	"	
	| b |
	b := RTSunburstBuilder new.
	b shape current 
				colorElement: [ :el | Color grayScale256: ((el attributeAt: #depth ifAbsent: [ 0 ]) * 30) ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic4 [
	"
	self new basic4
	"	
	| b |
	b := RTSunburstBuilder new.
	b shape colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic5 [
	"
	self new basic5
	"	
	| b |
	b := RTSunburstBuilder new.
	b strategy radialSpacing:10.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic6 [
	"
	self new basic6
	"	
	| b |
	b := RTSunburstBuilder new.
	b strategy radialSpacing:5.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: Object using: #subclasses.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic7 [
	"
	self new basic7
	"	
	| b |
	b := RTSunburstBuilder new.
	b angularSpacing: 1.
	b radialSpacing: 3.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic8 [
	"
	self new basic8
	"	
	| b |
	b := RTSunburstBuilder new.
	b radialSpacing: 15.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic9 [
	"
	self new basic9
	"	
	| b |
	b := RTSunburstBuilder new.
	b radialSpacing: 0.
	b angularSpacing: 1.
	b strategy hasCenter: false.
	b shape current 
				color: [ :cls | cls subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
	
	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]
