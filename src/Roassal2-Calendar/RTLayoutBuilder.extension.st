Extension { #name : #RTLayoutBuilder }

{ #category : #'*Roassal2-Calendar' }
RTLayoutBuilder >> date [
	"Used by RTCalendarBuilder"
	layout := RTDateLayout new.
	^ layout
]

{ #category : #'*Roassal2-Calendar' }
RTLayoutBuilder >> month [
	"Used by RTCalendarBuilder"
	layout := RTMonthLayout new.
	^ layout
]
