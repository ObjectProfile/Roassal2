Class {
	#name : #RTSpectrographExample,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-Spectrograph'
}

{ #category : #'as yet unclassified' }
RTSpectrographExample >> example01 [

	| b |
	b := RTSpectrograph new.
	b objects: #(1 2 3 4 5).
	b lineBlock: [ :v | (1 to: v) ].
	b highlight: #odd.
	b open
]

{ #category : #'as yet unclassified' }
RTSpectrographExample >> example02 [

	| b |
	b := RTSpectrograph new.
	b objects: (RTShape withAllSubclasses reverseSortedAs: #numberOfMethods).
	b interaction popupText: [ :cm | cm methodClass name, '>>', cm selector ].
	b lineBlock: [ :cls | cls methods ].
	
	b open
]

{ #category : #'as yet unclassified' }
RTSpectrographExample >> example03 [

	| b |
	b := RTSpectrograph new.
	b objects: (RTShape withAllSubclasses reverseSortedAs: [ :c | c methods size ]).
	b interaction popupText: [ :cm | cm methodClass name, '>>', cm selector ].
	b lineBlock: [ :cls | cls methods ].
	
	b open
]

{ #category : #'as yet unclassified' }
RTSpectrographExample >> example04 [

	| b now |
	now := DateAndTime now.
	b := RTSpectrograph new.
	b objects: (RTShape withAllSubclasses reverseSortedAs: #livingInDays).
	b highlight: [ :cls :livingDay | cls gotMethodOnDay: livingDay ].
	b highlight: [ :cls :livingDay | cls name endsWith: 'Layout' ] color: Color lightGreen.
	
	b popupText: [ :cls :age | cls name, '  ', age printString , ' days old'].
	b lineBlock: [ :cls | 0 to: cls livingInDays ].
	
	b open
]

{ #category : #'as yet unclassified' }
RTSpectrographExample >> example05 [

	| b now |
	now := DateAndTime now.
	b := RTSpectrograph new.
	b objects: ((RTObject withAllSubclasses , TRObject withAllSubclasses) reverseSortedAs: #livingInDays).

	
	b highlight: [ :cls :livingDay | cls inheritsFrom: TRObject ] color: Color lightGreen.
	b highlight: [ :cls :livingDay | cls gotMethodOnDay: livingDay ].
	
	b popupText: [ :cls :age | cls name, '  ', age printString , ' days old'].
	b lineBlock: [ :cls | 0 to: cls livingInDays ].
	
	b open
]
