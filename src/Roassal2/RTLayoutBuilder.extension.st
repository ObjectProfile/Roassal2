Extension { #name : #RTLayoutBuilder }

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
