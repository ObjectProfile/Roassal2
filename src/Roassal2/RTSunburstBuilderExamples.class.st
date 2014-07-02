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
	| b n nc1 nc2 nc3 nc4 nc5 nc6 nc7 nc8|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	
	n:= RTNode new.
	nc1:= RTNode new.
	nc2:= RTNode new.
	nc3:= RTNode new.
	nc4:=RTNode new.
	nc5:=RTNode new.
	nc6:=RTNode new.
	nc7:=RTNode new.
	nc8:=RTNode new.
	n addChild: nc1.
	n addChild: nc2.
	n addChild: nc3.
	n addChild: nc4.
	nc2 addChild: nc5.
	nc5 addChild: nc6.
	nc5 addChild: nc7.
	nc5 addChild: nc8.
	n accept: b visitor.
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
	b visitor interactions add: RTSBFadeInteraction.
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
RTSunburstBuilderExamples >> basic11WithGradient [
	"
	self new basic11WithGradient
	"	
	| b |
	b := RTSunburstBuilder new.
	b angularSpacing: 2.
	b radialSpacing: 2.
	b shape current colorElement: [ :e | (RTNColorLinearNormalizer
			inContext: (1 to: 8)
			lowColor: (Color r:0.8 g:0.8 b:1)
			highColor: (Color r:0 g:0 b:0.3)) rtValue: (e attributes at: #sbDepth) ].
	b 
		explore: RTObject using: #subclasses.
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

	b shape current 
				color: [ :m | m children notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
 	b visitor weight: [ :m | m tally ].
	b explore: (MessageTally new
     spyEvery: 1
     on: [ ROMondrianExample new miniMap ];
     yourself) using: #children.
	b view @ RTDraggableView.
	b open.
	b view canvas focusOnCenterScaled.
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic2 [
	"
	self new basic2
	"
	| b n nc1 nc2 nc3 nc4 nc5 nc6 nc7 nc8 nc9 nc10 nc11|
	
	n:= RTNode new.
	nc1:= RTNode new.
	nc2:= RTNode new.
	nc3:= RTNode new.
	nc4:=RTNode new.
	nc5:=RTNode new.
	nc6:=RTNode new.
	nc7:=RTNode new.
	nc8:=RTNode new.
	nc9:=RTNode new.
	nc10:=RTNode new.
	nc11:=RTNode new.
	nc1 weight: 6.
	nc3 weight: 3.
	nc7 weight: 3.
	n addChild: nc1.
	n addChild: nc2.
	n addChild: nc3.
	nc2 addChild: nc4.
	nc2 addChild: nc5.
	nc5 addChild: nc6.
	nc5 addChild: nc7.
	nc5 addChild: nc8.
	nc1 addChild: nc9.
	nc1 addChild: nc10.
	nc1 addChild: nc11.
	b := RTSunburstBuilder new.
	b shape current 
				colorElement: [ :el | Color grayScale256: ((el attributeAt: #sbDepth ifAbsent: [ 0 ]) * 60) ].

	n accept: b visitor.
	"b visitor arcs do: [ :el |  el trachelShape color: (Color gray256: ((el attributeAt: #sbDepth ifAbsent: [ 0 ]) * 60)) ]."
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
				colorElement: [ :el | Color grayScale256: ((el attributeAt: #sbDepth ifAbsent: [ 0 ]) * 30) ].

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
	b shape current 
				colorElement: [ :el | (el attributes at: #sbChildren) notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

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
	b visitor radialSpacing:10.
	b shape current 
				colorElement: [ :el | (el attributes at: #sbChildren) notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

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
	b visitor radialSpacing:5.
	b shape current 
				colorElement: [ :el | (el attributes at: #sbChildren) notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

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
				colorElement: [ :el | (el attributes at: #sbChildren) notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

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
	b radialSpacing:15.
	b shape current 
				colorElement: [ :el | (el attributes at: #sbChildren) notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

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
	b radialSpacing: 5.
	b angularSpacing: 1.

	b shape current 
				color: [ :cls | cls subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
	
	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b open
]
