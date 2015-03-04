"
A RTScrollBarBuilderExamples shows some usable examples for the scroll bar.

"
Class {
	#name : #RTScrollBarBuilderExamples,
	#superclass : #RTObject,
	#category : #'Roassal2-Builder-ScrollBar'
}

{ #category : #'as yet unclassified' }
RTScrollBarBuilderExamples >> example1 [

"RTScrollBarBuilderExamples new example1"

| b b2 |
b := RTMondrian new.
	b shape rectangle 
				withBorder;
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				linearFillColor: #numberOfLinesOfCode within: RTObject withAllSubclasses.
	b nodes: RTObject withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.


b2 := RTScrollBarBuilder new.
b2 view: b view.
"specify here the elements of the view you want to see moving, here is all the elements"
b2 objects: b view elements.
b2 build.


^ b view
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilderExamples >> example2 [

"RTScrollBarBuilderExamples new example2"

| b b2 |
b := RTMondrian new.
	b shape rectangle 
				withBorder;
				width: [ :cls | cls numberOfVariables * 5];
				height: #numberOfMethods;
				linearFillColor: #numberOfLinesOfCode within: RTObject withAllSubclasses.
	b nodes: RTObject withAllSubclasses.
	b edges connectFrom: #superclass.
	b layout tree.
	b build.

b2 := RTScrollBarBuilder new.
b2 view: b view.
"specify here the elements of the view you want to see moving, here is all the elements"
b2 objects: b view elements.
b2 scrollBarType: #isPad.
b2 build.


^ b view
]

{ #category : #'as yet unclassified' }
RTScrollBarBuilderExamples >> initialize [
	super initialize 
]
