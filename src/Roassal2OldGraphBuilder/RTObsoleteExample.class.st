Class {
	#name : #RTObsoleteExample,
	#superclass : #RTObject,
	#category : #Roassal2OldGraphBuilder
}

{ #category : #'as yet unclassified' }
RTObsoleteExample >> exampleMonticelloScript [

| myRepository packageNames lista autores fechas horas c v popup elements builder listTags test newTag last aAuthor |
myRepository := MCCacheRepository default.
myRepository allVersionNames.
packageNames := myRepository allVersionNames select: [ :e | '*' match: e ].
"packageNames := myRepository allVersionNames. "

lista := packageNames collect: [ :packageName | 
	myRepository versionInfoFromVersionNamed: packageName. ].

autores := lista groupedBy: [ :e | e author ].  
fechas  := lista groupedBy: [ :e | e date ].  
horas := lista groupedBy: [ :e | e time hour ].	
	
c := RTComposer new.
v := c view.
c gap: 50.

popup := RTPopup text: [:assoc | assoc key asString, ', commits:', assoc value size asString].
elements := (RTEllipse elementsOn: fechas associations).
v addAll: elements @ popup.
builder := RTGlobalBuilder new.
builder
	view: v;
	normalizeX: [ :e | e key asTimeStamp asUnixTime ] 
		min: 0 
		max: 50000;
	normalizeSize: [:e | e value size ] min: 10 max: 20;
	normalizeColor: [:e | e value size ];
	alphaColor: 0.3;
	elementsToConsider: elements; 
	execute.
			
"We add a line from the left most element to the right most element"
v add: ((RTLine new color: Color lightGray) edgeFrom: v elements leftMostElement to: v elements rightMostElement).

"It make sense to only drag horizontally"
v @ RTHorizontalDraggableView.

c propagateHighlight.
c group: 'date'.

listTags := Array new: autores size.

autores doWithIndex: [ :each :i| 
	test := each groupedBy: [ :e | e date ]. 
	elements := (RTEllipse elementsOn: test associations).
	v addAll: elements @ popup.
	builder 
	   elementsToConsider: elements;
	execute. 
	
	v add: ((RTLine new color: Color lightGray) edgeFrom: elements leftMostElement to: elements rightMostElement).	
	
	newTag := 'Author' asString, i asString.
	listTags at: i put: newTag.
	c propagateHighlight.
	c group: newTag.
	
].


popup := RTPopup text: [:assoc | 'Hour: ' asString, assoc key asString, ', commits:', assoc value size asString].
elements := (RTEllipse elementsOn: horas associations).
v addAll: elements @ popup.
builder := RTGlobalBuilder new.
builder
	view: v;
	normalizeX: [ :e | e key ] 
		min: 0 
		max: 380;
	normalizeSize: [:e | e value size ] min: 10 max: 20;
	normalizeColor: [:e | e value size ];
	alphaColor: 0.3;
	elementsToConsider: elements; 
	execute.
	
	v add: ((RTLine new color: Color lightGray) edgeFrom: elements leftMostElement to: elements rightMostElement).	
	c propagateHighlight.
	c group: 'Hour'.
	



popup := RTPopup text: [:assoc | assoc author asString, ', ' , ' message size: ', assoc message size asString].
elements := (RTEllipse elementsOn: lista).
v addAll: elements @ popup.
builder := RTGlobalBuilder new.
builder
	view: v;
	normalizeX: [ :e | e timeStamp asUnixTime ] 
		min: 0 
		max: 50000;
	normalizeSize: [ :e | e message size ] min: 10 max: 20;
	normalizeColor: [ :e | e message size ];
	alphaColor: 0.3;
	elementsToConsider: elements; 
	execute.
	
	v add: ((RTLine new color: Color lightGray) edgeFrom: elements leftMostElement to: elements rightMostElement).	
	c propagateHighlight.
	c group: 'Comment'.


listTags doWithIndex: [ :e :i| 
	(i == 1)
	 ifTrue: [ 
		c move: e below: 'date'.
		last := e.
		c nameGroup: 'date' as: 'History by Date'.
		aAuthor := autores keys at: i.
		c nameGroup: e as: 'History by: ' asString,  aAuthor asString.
		 ]
	 ifFalse: [ 
		c move: e below: last.
		last := e.
		aAuthor := autores keys at: i.
		c nameGroup: e as: 'History by: ' asString, aAuthor asString.
		 ]
].
	
c move: 'Hour' below: last.
c nameGroup: 'Hour' as: 'History by Hour'.

c move: 'Comment' below: 'Hour'.
c nameGroup: 'Comment' as: 'History by Comment'.

	
"We add a small legend"
v canvas addFixedShape: (TRLabelShape new text: 'History of Changes').
TRConstraint stickAtTheBottomOfTheWindow: v canvas fixedShapes last.

^ v
]
