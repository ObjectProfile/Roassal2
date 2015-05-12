"
I am a class to show and hide elements by clicking one element
"
Class {
	#name : #RTShowHide,
	#superclass : #RTHighlightable,
	#category : #'Roassal2-Core'
}

{ #category : #'reset shape' }
RTShowHide class >> highlightedColor [
	^ Color transparent
]

{ #category : #actions }
RTShowHide >> doHighlight: element [
	| elements |
	"self unhighlightRecordedElements."
	elements := highlightElements rtValue: element.
	elements := elements copyWithout: nil.
	elements do: [ :eachElement | self doHighlightElement: eachElement ].
	element attributes at: self attributeIdentificator put: elements.
	self class lastHighlightedElements: elements
]

{ #category : #hooks }
RTShowHide >> initializeElement: element [
	element
		when: TRMouseClick
		do: [ :e | 
			(element attributes includesKey: #rthide) ifTrue: [ 
				self doUnhighlight: element.
				element attributes removeKey: #rthide ] 
			ifFalse: [ 
				self doHighlight: element.
				element attributes at: #rthide put: true.  ].
			
			e signalUpdate ].
	
]
