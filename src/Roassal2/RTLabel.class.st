Class {
	#name : #RTLabel,
	#superclass : #RTShape,
	#instVars : [
		'text',
		'font',
		'height'
	],
	#category : #'Roassal2-Core'
}

{ #category : #configuration }
RTLabel >> defaultColor [

	^ Color black
]

{ #category : #'instance creation' }
RTLabel >> defaultText [
	^ [ :e | e model asString ]
]

{ #category : #accessing }
RTLabel >> height: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self heightElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTLabel >> heightElement: aValueOrABlock [
	height := aValueOrABlock
]

{ #category : #rendering }
RTLabel >> heightFor: element [
	^ height rtValue: element
]

{ #category : #initialization }
RTLabel >> initialize [
	super initialize.
	text := self defaultText.
	height := TRLabelShape defaultFontSize
]

{ #category : #accessing }
RTLabel >> text: aValueOrAOneArgBlock [
	"aValueOrAOneArgBlock is applied on the object model"
	self textElement: [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]

{ #category : #accessing }
RTLabel >> textElement: aStringOrABlock [

	text := aStringOrABlock
]

{ #category : #rendering }
RTLabel >> textFor: element [
	^ (text rtValue: element) asString
]

{ #category : #hooks }
RTLabel >> trachelShapeFor: anElement [
	| c txt lines n s lbl |

	c := self colorFor: anElement.
	txt := self textFor: anElement.
	txt := txt copyReplaceAll: String tab with: '    '.
	lines := txt lines.
	lines size <= 1
		ifTrue: 
			[ ^ self trachelShapeForOneLine: anElement ]
		ifFalse:
			[
			s := TRCompositeShape new.
			lines reverse do: [ :l | 
				lbl := TRLabelShape new text: l.
				s shape1: lbl.
				s offset1: lbl width / 2 @ 0.
				s offset2: 0 @ 20.
				
				n := TRCompositeShape new.
				n shape2: s.
				s := n ].
			^ s 
			 ]

]

{ #category : #'as yet unclassified' }
RTLabel >> trachelShapeForOneLine: anElement [
	|  shape |	
	shape := TRLabelShape new.
	shape text: (self textFor: anElement);
			color: (self colorFor: anElement);
			position: anElement position;
			fontSize: (self heightFor: anElement).
	^ shape
]

{ #category : #rendering }
RTLabel >> updateFor: anElement trachelShape: trachelShape [	
	| c txt lines n s |
	trachelShape isNil ifTrue: [ ^ self ].
	s := nil.
	c := self colorFor: anElement.
	txt := self textFor: anElement.
	lines := txt lines.
	lines size = 1
		ifTrue: 
			[ trachelShape 
				color: c;
				text: txt on: anElement position ]
		ifFalse:
			[
			lines allButFirst do: [ :l |  
				n := TRCompositeShape new.
				n offset2: 20.
				n shape1: l. 
				s shape2: n.
				s := n ]. 
			 ]
]

{ #category : #rendering }
RTLabel >> widthFor: anElement [
	^ TRLabelShape widthOfText: (self textFor: anElement) fontSize: (self heightFor: anElement)
]
