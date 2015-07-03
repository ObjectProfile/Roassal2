Class {
	#name : #RTHorizontalTimelineDecorator,
	#superclass : #RTAbstractLineDecorator,
	#instVars : [
		'identifiers'
	],
	#category : #'Roassal2-Builder-Timeline'
}

{ #category : #adding }
RTHorizontalTimelineDecorator >> addLineAboveIdentifier: anIdentifier [
	"anIdentifier could be any object, not only a string"

	identifiers add: anIdentifier
]

{ #category : #initialization }
RTHorizontalTimelineDecorator >> initialize [
	super initialize.
	identifiers := OrderedCollection new.
]

{ #category : #hooks }
RTHorizontalTimelineDecorator >> render [	
	| from to lineIdentifiers |
	lineIdentifiers := builder lineIdentifiers.
	identifiers do: [ :id |
		values add: (lineIdentifiers indexOf: id)
	].

	values do: [ :aValue |
		from := builder getPixelPositionOf: builder minX @ aValue.
		to := builder getPixelPositionOf: builder maxX @ aValue.
		self lineFrom: from to: to ]
		
	
]
