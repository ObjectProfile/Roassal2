"
I am a builder to create calendars with Roassal
"
Class {
	#name : #RTCalendarBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'dates',
		'dayShape',
		'daySelector',
		'monthShape',
		'yearShape',
		'dayLayout',
		'monthLayout',
		'yearLayout',
		'dayLabelShape'
	],
	#category : #'Roassal2-Calendar'
}

{ #category : #hooks }
RTCalendarBuilder >> createView [
	^ super createView @ RTDraggableView.
]

{ #category : #accessing }
RTCalendarBuilder >> dates [
	^ dates
]

{ #category : #accessing }
RTCalendarBuilder >> dates: anObject [
	dates := anObject
]

{ #category : #accessing }
RTCalendarBuilder >> dayLabelShape [
	^ dayLabelShape
]

{ #category : #accessing }
RTCalendarBuilder >> dayLayout [
	^ dayLayout
]

{ #category : #accessing }
RTCalendarBuilder >> daySelector [
	^ daySelector
]

{ #category : #accessing }
RTCalendarBuilder >> daySelector: anObject [
	daySelector := anObject
]

{ #category : #accessing }
RTCalendarBuilder >> dayShape [
	^ dayShape
]

{ #category : #accessing }
RTCalendarBuilder >> dayShape: aShapeBuilder [
	dayShape := aShapeBuilder
]

{ #category : #'accessing - computed' }
RTCalendarBuilder >> daysIndex: aCollection [
	^ (aCollection collect: [ :d | d weekdayIndex ]) asSet asSortedCollection.
]

{ #category : #'accessing - computed' }
RTCalendarBuilder >> getDateStructure [
	| aDates firstDay currentMonth currentYear days months years |
	aDates := self getDays."All the dates".
	
	firstDay := aDates first.
	currentMonth := firstDay asMonth.
	currentYear := currentMonth asYear.
	
	years := OrderedCollection new.
	months := OrderedCollection new.
	days := OrderedCollection new.
	
	days add: firstDay.
	months add: currentMonth->days.
	years add: currentYear->months.
	aDates allButFirstDo: [ :date | | temp |
		temp := date asYear.
		temp = currentYear 
			ifFalse: [ 
				currentYear := temp.
				months := OrderedCollection new.
				years add: currentYear->months. ].
		temp := date asMonth.
		temp = currentMonth 
			ifTrue: [ days add: date ]
			ifFalse: [ 
				currentMonth := temp.
				days := OrderedCollection new.
				days add: date.
				months add: currentMonth->days ]
		].
	
	^ years
]

{ #category : #'accessing - computed' }
RTCalendarBuilder >> getDays [
	| timespan days current limit |
	timespan := self daySelector rtValue: self dates.
	
	(timespan isKindOf: OrderedCollection) ifTrue: [ ^ timespan asSortedCollection ].
	
	days := OrderedCollection new.
	current := timespan start asDate.
	limit := timespan end asDate.
	
	[ current <= limit ] whileTrue: [ 
		days add: current.
		current := current next ].
	
	^ days
]

{ #category : #initialization }
RTCalendarBuilder >> initialize [
	super initialize.
	dayShape := RTShapeBuilder new.
	dayShape label text: [:date | date dayOfMonth ].
	
	dayLabelShape := RTShapeBuilder new.
	dayLabelShape rectangle size: 0.
	
	self daySelector: #yourself.
	
	monthShape := RTShapeBuilder new.
	monthShape composite: [ :s | 
		s add: (RTLabel new text: [ :d | d name ]).
		s add: (RTBox new color: Color transparent; borderColor: Color gray) ].
	
	yearShape := RTShapeBuilder new.
	yearShape rectangle color: Color transparent.
	
	dayLayout := RTLayoutBuilder new.
	dayLayout date.
	monthLayout := RTLayoutBuilder new.
	monthLayout grid gapSize: 10.
	yearLayout := RTLayoutBuilder new.
	yearLayout grid gapSize: 10.
	

]

{ #category : #accessing }
RTCalendarBuilder >> monthLayout [
	^ monthLayout 
]

{ #category : #hooks }
RTCalendarBuilder >> renderIn: aView [
	| dateStructure years |
	
	dateStructure := self getDateStructure.
	years := OrderedCollection new.
	dateStructure do: [ :asso1 | 
		| year months |
		year := yearShape elementOn: asso1 key.
		view add: year.
		years add: year.
		
		months := OrderedCollection new.
		asso1 value do: [ :asso2 | 
			| month days dayLabels | 
			month := monthShape elementOn: asso2 key.
			view add: month.
			months add: month.
			dayLabels := dayLabelShape elementsOn: (self daysIndex: asso2 value).
			view addAll: dayLabels.
			
			days := dayShape elementsOn: asso2 value.
			view addAll: days.
			dayLayout layout on: dayLabels, days.
			RTNest new on: month nest: dayLabels,days.
			 ]. 
		monthLayout layout on: months.
		RTNest new on: year nest: months. ].
	yearLayout layout on: years.

	
	
]

{ #category : #public }
RTCalendarBuilder >> showDayNames [
	self dayLabelShape label text: [ :index | 
		| name |
		name := Week nameOfDay: index.
		name first asString, name second asString ].
]

{ #category : #accessing }
RTCalendarBuilder >> yearLayout [
	^ yearLayout
]

{ #category : #accessing }
RTCalendarBuilder >> yearShape [
	^ yearShape
]

{ #category : #accessing }
RTCalendarBuilder >> yearShape: aShapeBuilder [
	yearShape := aShapeBuilder
]
