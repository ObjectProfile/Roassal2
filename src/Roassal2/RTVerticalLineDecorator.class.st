"
Add vertical lines for some values

-=-=-=-=-=
	| b ds p |
	b := RTGrapher new.

	ds := RTDataSet new.
	ds points: #( 0 1 2 10).

	b add: ds.

	b minY: -3.33.

	p := RTHorizontalLineDecorator new.
	p add: 5; add: 7; add: 3.34.
	p shape line color: (Color red alpha: 0.3).
	b addDecorator: p.

	p := RTVerticalLineDecorator new.
	p add: 5.
	p shape line color: (Color blue alpha: 0.3).
	b addDecorator: p.

	b build.
	^ b view 
-=-=-=-=-=

Example with Date:
-=-=-=
	methods := RTObject withAllSubclasses flatCollect: #rtmethods.
	methods := methods reject: [ :m | m numberOfLinesOfCode > 150 ].
	oldestMethod := methods minFor: #date.

	firstMethodIn2014 := (methods select: [ :m | m date year = 2014 ]) minFor: #date.

	b := RTGrapher new.
	b extent: 300 @ 200.

	ds := RTData new.
	ds dotShape circle size: 5; color: (Color blue alpha: 0.1).
	ds interaction popup.
	ds points: methods.
	ds y: #numberOfLinesOfCode.
	ds x: [ :m | m date julianDayNumber - oldestMethod date julianDayNumber ].
	b add: ds. 

	deco := RTVerticalLineDecorator new.
	deco add: (firstMethodIn2014 date julianDayNumber - oldestMethod date julianDayNumber).
	deco shape color: Color red.
	b addDecorator: deco.

	b axisY 
		noDecimal;
		title: 'LOC'.
	
	b axisX 
		title: '';
		labelRotation: -30;
		labelConversion: [ :v | (Date julianDayNumber: v + oldestMethod date julianDayNumber) ].

	^ b
-=-=-=
"
Class {
	#name : #RTVerticalLineDecorator,
	#superclass : #RTAbstractLineDecorator,
	#category : #'Roassal2-Builder-Grapher-Decorators'
}

{ #category : #drawing }
RTVerticalLineDecorator >> render [	
	| from to |
	values do: [ :aValue |
		from := builder getPixelPositionOf: aValue @ builder minY.
		to := builder getPixelPositionOf: aValue @ builder maxY.
		self lineFrom: from to: to ]
		
	
]
