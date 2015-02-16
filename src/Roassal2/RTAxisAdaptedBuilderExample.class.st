Class {
	#name : #RTAxisAdaptedBuilderExample,
	#superclass : #RTAbstractExample,
	#instVars : [
		'objects',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'margin',
		'xAxisConfiguration',
		'yAxisConfiguration'
	],
	#category : #'Roassal2-Builder-AxisAdapted'
}

{ #category : #examples }
RTAxisAdaptedBuilderExample >> example1 [

	"RTAxisAdaptedBuilderExample new example1"
| view coll n ob b |
view := RTView new.

coll:= {50. 60. 80. 100. 85. 10. 35}.

n := RTMultiLinearColorForIdentity new objects: (coll).

coll do: [ :r | view add: ((RTBox new color: [ :value | n rtValue: r]; size: r) elementOn: r )].

RTFlowLayout new applyOn: view elements.
view elements do: [ :e | e @ (RTPopup text: [:el | el])].


ob := view elements.



b := RTAxisAdaptedBuilder new.
b view: view.
b margin: 20.
b objects: ob.
b build.
b view inspect 

]

{ #category : #examples }
RTAxisAdaptedBuilderExample >> example2 [

	"RTAxisAdaptedBuilderExample new example2"
| view coll n ob b |
view := RTView new.

coll:=Array with: (Rectangle origin: (500@500) corner: (610@620)) with: (Rectangle origin: (555@554) corner: (711@722)).

n := RTMultiLinearColorForIdentity new objects: (coll).

coll do: [ :r | view add: ((RTBox new color: [ :value | n rtValue: r]; width: r width ; height: r height) elementOn: r )].


view elements do: [ :e | e translateTo: e model center; @ (RTPopup text: [:el | el center])].

view.

ob := view elements.

b := RTAxisAdaptedBuilder new.
b view: view.
b margin: 20.
b objects: ob.
b build.
b view inspect

]
