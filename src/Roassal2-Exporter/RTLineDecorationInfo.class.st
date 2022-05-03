"
I am a simple data class for RTSVGVisitor and contain information about what line decoration belongs to which end of which line
"
Class {
	#name : #RTLineDecorationInfo,
	#superclass : #Object,
	#instVars : [
		'line',
		'decoration',
		'startOrEnd'
	],
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #'as yet unclassified' }
RTLineDecorationInfo class >> line: aTRLine decoration: aTRDecorationShape [

	^ self new
		  line: aTRLine;
		  decoration: aTRDecorationShape;
		  yourself
]

{ #category : #'as yet unclassified' }
RTLineDecorationInfo class >> line: aTRLine decorationOnStart: aTRDecorationShape [

	^ (self line: aTRLine decoration: aTRDecorationShape)
		  onStart;
		  yourself
]

{ #category : #accessing }
RTLineDecorationInfo >> decoration [

	^ decoration
]

{ #category : #accessing }
RTLineDecorationInfo >> decoration: anObject [

	decoration := anObject
]

{ #category : #initialization }
RTLineDecorationInfo >> initialize [

	super initialize.
	self onEnd
]

{ #category : #accessing }
RTLineDecorationInfo >> isOnStart [

	^ startOrEnd = #start
]

{ #category : #accessing }
RTLineDecorationInfo >> line [

	^ line
]

{ #category : #accessing }
RTLineDecorationInfo >> line: anObject [

	line := anObject
]

{ #category : #accessing }
RTLineDecorationInfo >> onEnd [

	startOrEnd := #end
]

{ #category : #accessing }
RTLineDecorationInfo >> onStart [

	startOrEnd := #start
]

{ #category : #accessing }
RTLineDecorationInfo >> startOrEnd [

	^ startOrEnd
]
