"
I am an handy class to build legend in a visualization
"
Class {
	#name : #RTColorLegendBuilder,
	#superclass : #RTBuilder,
	#instVars : [
		'legend'
	],
	#category : #'Roassal2-Builder-Legend'
}

{ #category : #examples }
RTColorLegendBuilder >> example01 [
	"
	self new example01
	"
	| v shape legendBuilder elements |
	v := RTView new.
	
	"We add some elements"
	shape := RTShapeBuilder new circle
					size: [ :c | 10 max: (c numberOfMethods) / 7 ];
					fillColor: Color gray;
					if: [ :cls | '*Array*' match: cls name ] fillColor: Color blue;
					if: [ :cls | '*Dictionary*' match: cls name ] fillColor: Color green;
					if: [ :cls | '*Set*' match: cls name ] fillColor: Color red;
					current.
	elements := shape elementsOn: (Collection withAllSubclasses).
	elements @ RTPopup.
	v addAll: elements.
	RTGridLayout on: v elements.
	
	"We add the legend"
	legendBuilder := RTColorLegendBuilder new view: v.
	legendBuilder name: 'array' color: Color blue.
	legendBuilder name: 'dictionary' color: Color green.
	legendBuilder name: 'set' color: Color red.
	legendBuilder render.
	
	"Open the view"
	v open
	
]

{ #category : #initialization }
RTColorLegendBuilder >> initialize [
	super initialize.
	legend := OrderedCollection new
]

{ #category : #public }
RTColorLegendBuilder >> name: aName color: aColor [
	^ self name: aName shape: (RTBox new size: 10; color: aColor)
]

{ #category : #public }
RTColorLegendBuilder >> name: aName element: anElement [
	legend add: aName -> anElement
]

{ #category : #public }
RTColorLegendBuilder >> name: aName shape: aShape [
	^ self name: aName element: aShape element
]

{ #category : #hooks }
RTColorLegendBuilder >> renderIn: aView [

	| groups bigGroup bigbigGroup |
	groups := legend collect: [ :assoc | 
		| g |
		g := RTGroup new
				add: (RTLabel elementOn: assoc key);
				add: assoc value;
				yourself.
		RTHorizontalLineLayout on: g.
		g ].
	RTHorizontalLineLayout on: groups.

	"We move all the legend above all the "
	bigGroup := RTGroup new.
	groups do: [ :g | bigGroup addAll: g ].	
	
	
	bigbigGroup := RTGroup new.
	bigbigGroup addAll: aView elements.
	
	TRConstraint move: bigGroup above: bigbigGroup.
	bigGroup translateBy: 0 @ -30.
	aView addAll: bigGroup.
]
