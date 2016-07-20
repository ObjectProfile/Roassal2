"
I am a shape describing a possibly multiline text.

If you need just a simple label, use RTLabel instead.
"
Class {
	#name : #RTText,
	#superclass : #RTShape,
	#instVars : [
		'text',
		'font',
		'fontSize'
	],
	#category : #'Roassal2-Shapes'
}

{ #category : #accessing }
RTText >> font: aValueOrOneArgBlock [
	font := self valueRetrieverOn: aValueOrOneArgBlock
]

{ #category : #accessing }
RTText >> fontFor: anElement [
	^ font rtValue: anElement
]

{ #category : #accessing }
RTText >> fontSize: aValueOrOneArgBlock [
	fontSize := self valueRetrieverOn: aValueOrOneArgBlock
]

{ #category : #accessing }
RTText >> fontSizeFor: anElement [
	^ fontSize rtValue: anElement
]

{ #category : #initialization }
RTText >> initialize [
	super initialize.
	self text: [ :model | model asString ].
	font := RTTheme current textFont.
	fontSize := RTTheme current textSize.
	color := RTTheme current textColor
]

{ #category : #accessing }
RTText >> text: aTextOrBlock [
	text := self valueRetrieverOn: aTextOrBlock
]

{ #category : #accessing }
RTText >> textFor: anElement [
	^ text rtValue: anElement
]

{ #category : #hooks }
RTText >> trachelShapeClass [
	^ TRTextShape
]

{ #category : #hooks }
RTText >> updateFor: anElement trachelShape: trachelShape [
	self logCr: anElement position.
	^ trachelShape
		text: (self textFor: anElement);
		font: (self fontFor: anElement);
		fontSize: (self fontSizeFor: anElement);
		color: (self colorFor: anElement);
		position: anElement position;
		rotateByDegrees: (self rotationFor: anElement);
		scaleBy: (self scaleFor: anElement);
		yourself
]

{ #category : #accessing }
RTText >> valueRetrieverOn: aValueOrAOneArgBlock [
	^ [ :anElement | aValueOrAOneArgBlock rtValue: anElement model ]
]
