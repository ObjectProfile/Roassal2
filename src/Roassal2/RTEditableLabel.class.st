Class {
	#name : #RTEditableLabel,
	#superclass : #RTLabel,
	#instVars : [
		'fieldArea'
	],
	#category : #'Roassal2-Core'
}

{ #category : #rendering }
RTEditableLabel >> hideTextMorphFor: anElement [
	| p  base |
	fieldArea ifNotNil: [ | txt |
		txt := fieldArea text asString.
		self updateTextFor: anElement with: txt. 
		fieldArea class = RubTextFieldArea ifTrue: [ 
			anElement trachelShape text: txt.
			 ]
		ifFalse: [ | lines aColor fontSize shape |
			lines := txt lines.
			aColor := self colorFor: anElement.
			fontSize := self heightFor: anElement.
			fontName := self fontNameFor: anElement.
			shape := anElement trachelShape.
			p := shape position.
			base := shape shapes first.
			shape remove; setShapes: OrderedCollection new.
			
			lines doWithIndex: [ :l :index | | lbl |
				lbl := TRLabelShape new text: l.
				lbl color: aColor; fontSize: fontSize; fontName: fontName.
				shape addShape: lbl ].
			shape verticalAndLeft.
			anElement view canvas addShape: shape.
			shape translateBy: p.
			shape announcer: base announcer.
		 ].
		
		anElement signalUpdate.
		fieldArea delete ]
]

{ #category : #rendering }
RTEditableLabel >> showTextMorphFor: anElement [
	| shape rect  trachelShape str posBlock clazz |
	shape := anElement shape.
	rect := anElement encompassingRectangle.
	anElement trachelShape class = TRCompositeShape ifTrue: [ 
		trachelShape := anElement trachelShape shapes first.
		clazz := RubEditingArea ]
	ifFalse: [ 
		trachelShape := anElement trachelShape.
		clazz := RubTextFieldArea ].
	
	str := shape textFor: anElement.
	fieldArea := clazz new 
		extent: rect extent*1.2;
		takeKeyboardFocus;
		updateTextWith: str;
		font: trachelShape font;
		onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];	
		openInWorld.
	fieldArea editor selectAt: str size+1.
	Transcript show: fieldArea extent; show: ', '; show: rect extent; cr.
	posBlock := [fieldArea position: anElement view canvas morph bounds origin+ (anElement view canvas camera fromSpaceToPixel: anElement position) - (fieldArea extent /2)].
	posBlock value.
	fieldArea announcer subscribe: RubTextChanged send: #value to: [ 
		posBlock value ].
	
]

{ #category : #rendering }
RTEditableLabel >> textFor: anElement [
	(anElement attributes includesKey: #text) ifFalse: [ 
		anElement attributes at: #text put: (super textFor: anElement) ].
	
	^ anElement attributes at: #text.
]

{ #category : #rendering }
RTEditableLabel >> trachelShapeFor: anElement [
	|  shape |
	
	shape := super trachelShapeFor: anElement.
	anElement when: TRMouseDoubleClick do: [ :evt | 
		self showTextMorphFor: anElement ].
	anElement when: TRMouseLeave do: [ :evt |
		self hideTextMorphFor: anElement. ].
	^ shape
]

{ #category : #rendering }
RTEditableLabel >> updateTextFor: element with: aText [
	element attributes at: #text put: aText
]
