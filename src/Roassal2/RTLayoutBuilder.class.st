"
RTLayoutBuilder is a higher abstract to manage layout. Most builder use it as it significantly shorten the use of layouts.

Consider the following example:
-=-=-=-=-=-=-=-=-=-=-=-=
v := RTView new.

es := (RTBox new size: 8) elementsOn: (1 to: 100).
v addAll: es.

lb := RTLayoutBuilder new.
lb horizontalFlow.
lb setUpElements: es.

v
-=-=-=-=-=-=-=-=-=-=-=-=

Another example using conditional layout:
-=-=-=-=-=-=-=-=-=-=-=-=
b := RTMondrian new.
b nodes: self.
b edges connectToAll: [ :c | c queryAllOutgoingInvocations atTypeScope ].
b layout 
	forceWithCharge: -300;
	ifElement: #isNotConnected then: RTNullLayout new.
b
-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RTLayoutBuilder,
	#superclass : #RTObject,
	#instVars : [
		'layout',
		'actionOnEdges',
		'partitions',
		'dynamicForceBasedLayout'
	],
	#category : #'Roassal2-Builder-Common'
}

{ #category : #'*Roassal2' }
RTLayoutBuilder >> date [
	"Used by RTCalendarBuilder"
	layout := RTDateLayout new.
	^ layout
]

{ #category : #'*Roassal2' }
RTLayoutBuilder >> month [
	"Used by RTCalendarBuilder"
	layout := RTMonthLayout new.
	^ layout
]

{ #category : #'*Roassal2' }
RTLayoutBuilder >> sunburstWithArcWidth: aNumber [
	layout := RTSunburstConstantWidthLayout new.
	layout arcWidth: aNumber.
	^ layout
]

{ #category : #'*Roassal2' }
RTLayoutBuilder >> sunburstWithRadius [
	^ self sunburstWithRadius: 200.

]

{ #category : #'*Roassal2' }
RTLayoutBuilder >> sunburstWithRadius: radius [
	layout := RTSunburstExtentLayout new.
	layout extent: radius asPoint * 2.
	^ layout
]
