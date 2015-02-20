Class {
	#name : #RTSunburstBuilderExamples,
	#superclass : #RTAbstractExample,
	#category : #'Roassal2-Builder-Sunburst'
}

{ #category : #examples }
RTSunburstBuilderExamples >> basic1 [
	"
	self new basic1
	"
	| b|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b view @ RTDraggableView.
	b build.
	^ b view 
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic10 [
	"
	self new basic10
	"	
	| b data |
	data := Array 
		with: 'Chile' -> (Array with: 'Santiago' with: 'Iquique' )
		with: 'France' -> (Array with: 'Paris' with: 'Nice').
	b := RTSunburstBuilder new.

	b 
		explore: data 
		using: [ :o | 
			o class == Association 
				ifTrue: [ o value ] 
				ifFalse: [ o isString 
									ifTrue: [ #() ] 
									ifFalse:  [ o ] ] ].
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic11 [
	"
	self new basic11
	"	
	| b data |
	data := Array 
		with: 'Chile' -> (Array with: 'Santiago' with: 'Iquique' )
		with: 'France' -> (Array with: 'Paris' with: 'Nice').
	b := RTSunburstBuilder new.
	b interactions add: RTSBFadeInteraction new.
	b 
		explore: data 
		using: [ :o | 
			o class == Association 
				ifTrue: [ o value ] 
				ifFalse: [ o isString 
									ifTrue: [ #() ] 
									ifFalse:  [ o ] ] ].
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic12 [
	"
	self new basic12
	"	
	| b |
	b := RTSunburstBuilder new.
	b radialSpacing: 5.
	
	b interactions add: RTSBFadeInteraction new.
	b shape current 
				color: [ :m | m children notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
 	b weight: [ :m | m tally ].
	b explore: (MessageTally new
     spyEvery: 1
     on: [ Nautilus open ];
     yourself) using: #children.
	b view @ RTDraggableView.
	b open.
	b view canvas focusOnCenterScaled.
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic13 [
	"
	self new basic13
	"	
	| b |
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b radialSpacing: 1.
	
	b interactions add: RTSBFadeInteraction new.
	b shape current 
				color: [ :m | m children notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
 	b weight: [ :m | m tally ].
	b explore: (MessageTally new
     spyEvery: 1
     on: [ Nautilus open ];
     yourself) using: #children.
	b view @ RTDraggableView.
	b open.
	b view canvas focusOnCenterScaled.
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic14 [
	"
	self new basic14
	"
	| b|
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic15 [
	"
	self new basic15
	"
	| b|
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b strategy hasCenter: false.
	b radialSpacing: 0.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic2 [
	"
	self new basic2
	"
	| b|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b strategy hasCenter: false.
	b radialSpacing: 0.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic3 [
	"
	self new basic3
	"	
	| b |
	b := RTSunburstBuilder new.
	b shape current 
				colorElement: [ :el | Color grayScale256: ((el attributeAt: #depth ifAbsent: [ 0 ]) * 30) ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic4 [
	"
	self new basic4
	"	
	| b |
	b := RTSunburstBuilder new.
	b shape colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic5 [
	"
	self new basic5
	"	
	| b |
	b := RTSunburstBuilder new.
	b strategy radialSpacing:10.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic6 [
	"
	self new basic6
	"	
	| b |
	b := RTSunburstBuilder new.
	b strategy radialSpacing:5.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: Object using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic7 [
	"
	self new basic7
	"	
	| b |
	b := RTSunburstBuilder new.
	b angularSpacing: 1.
	b radialSpacing: 3.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic8 [
	"
	self new basic8
	"	
	| b |
	b := RTSunburstBuilder new.
	b radialSpacing: 15.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #examples }
RTSunburstBuilderExamples >> basic9 [
	"
	self new basic9
	"	
	| b |
	b := RTSunburstBuilder new.
	b radialSpacing: 0.
	b angularSpacing: 1.
	b strategy hasCenter: false.
	b shape current 
				color: [ :cls | cls subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].
	
	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic1 [
| b|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b view @ RTDraggableView.
	b build.
	^ b view 
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic10 [
| b data |
	data := Array 
		with: 'Chile' -> (Array with: 'Santiago' with: 'Iquique' )
		with: 'France' -> (Array with: 'Paris' with: 'Nice').
	b := RTSunburstBuilder new.

	b 
		explore: data 
		using: [ :o | 
			o class == Association 
				ifTrue: [ o value ] 
				ifFalse: [ o isString 
									ifTrue: [ #() ] 
									ifFalse:  [ o ] ] ].
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic10Icon [
	^ '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
/yA8x38BsksFStfXt2UAAAAASUVORK5CYII='
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic15 [
| b|
	b := RTSunburstBuilder new.
	b strategy: RTSunburstExtentStrategy new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b strategy hasCenter: false.
	b radialSpacing: 0.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic15Icon [
	^ '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
/R/osR6NausFcgAAAABJRU5ErkJggg=='
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic1Icon [
	^ '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
AAAAAElFTkSuQmCC'
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic2 [
| b|
	b := RTSunburstBuilder new.
	b shape color: [ :e | Color random ].
	b explore: 1 using: [ :n | n< 4 ifTrue: [ Array with: n + 1 with: n + 2 ] ifFalse: [ #( ) ] ].
	b strategy hasCenter: false.
	b radialSpacing: 0.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic2Icon [
	^ 'iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAE/ElEQVR4XuXce0yVdRwGcFer
+Yey/qvs5j+6acvLtCy6HAXhGOThCIzkHOxkDAGRcpyjCVjqJoRmK0cBR0HXbIZt7mhIma1l
S4liNU4irqBNoQvGgXPyhHQY5/vGrzzF6sD5/d7zcs573ufZnr/f7f3s+17Oe36/aZKEHzVl
Gv4pwAfBDz4IPgh+8EHwQfCDD4IPgh98EHwQ/OCD4AcfBB8EP/gg+CD4wQfBB8EPPgg+CH7w
QfCDD4IPgh98EHwQ/OCDGG5rItPs07Ql6RzVl3bQ0crvpNbmXwgfJEpZHdc0afdvbKcvTsUm
kCZBxvfN553kHfQRPohKQAItS22h/p+uEz6ISkACrcxpI3wQFYEE6jzbT/ggKgJhffW5rwkf
REUgrLbEzwkfREUgrOvnfUzkJ8IHUQlI+oKTdLfHhg/Ck76BPjry4RHJfuIAFewpoBRrKhUa
kmhzxjrapC8j84JyKXdJPYWDcas7X2Jd/NsuwgcJkq7eLtp9eDfpN6+SgrXQkBi0xca1ZFm0
jxsn/f5/MQJd5X2d8EFupP37dsoqf3pCiFAg42tZumNSmPQH/o8RaKPvS4IG8fv9VLLfGhJC
BOTvrqTM+2pJBCNQl99LkCAdP3RwQ4iD3Gjitn9QMuY3hcRgXXatAg+krbNNGEMWyFhzl1uI
ZzLGt3nkW4IBkYshF4Q1c6tBCGSGuwgD5EL3BdkY4YCwGsvThFCO+lpJ0yD+sVficDDCBWFd
/FkeN8osj1XbILZqW9RBWOMGi7hRLo+6SJMgzi6nbAydqYZWmhz0cFIvLYrvpzRjKz25wi4V
Z5lIDsiaMv5Ll3XomDZBsl82iYLQE+kf0fwH3dJkfWRFD61LLRKGuevHYm4UzYF093YLYSTl
F4eE+G8z0hxCKGv2ruUG8fgj8/k3YiCVb79CU4kRaELCJ0IovCAVw6e0BSJymZKLEegzadu5
UZaeyeWakvW/H9IOCPsJnRdkeeYHYYOw8oKk1OVwgUx3F2gHhH3P4AVRAoP1qcRaUvqypRmQ
Ooeda0J02TWkFMiSx/rwQSYK+9LHdTM3n1AMROSyBQey2mbgAonX9+CDROIgz752C1n23SyF
6paZOWS9ySwp1beWubiqpkQE5IW6e7hAXno8Gx8kEgepPpnFBVKoXyjhg0QgjvO7JB6QjXvv
UGxCquYcJHyQCdJ66RjXhLCW3mtWBKVO18MF0mh2Y/6VlBdkQ8mssEF23l7FPR1fHRySIEF4
b+ysLxqTZaNsm7GBG4PVN+THnJAz31Rzg7CWPKQXRimdmU923a/cIA3JA9jLEURAWIs2zeVG
2XlnldBksF5qGsYGOX5uB4mi/PX0lbKQtsYFf2msmnNgbCp6hDFq4l34K6hE3tonq+jJD9Yr
LT58EJbOK59GHcRR4FHtws+o/FHO3myhaIHUPurCX4UbLBXv6igaINd+HsUHURpFLsbViyP4
GweEyp73kmmqQdgTlffqaExsr6GKBTvnL75DUwXiKPTE1CY0qlnS5hu5TpWNCaQUCLt5X27x
xdyOQKpb9Nk32EVvOIwkF6RBP0Cd7w/H7N5Zql4WfdZZTw2n8ygUyPE8N7Ffbf/w+mN+EzP8
Lf7wQfCDD4IPgh98EHwQ/OCD4IPgBx8EHwQ/+CD4wQfBB8EPPgg+CH7wQfBB8IMPgg+CH3wQ
/OCD4IPgBx8EHwQ/+CCazp9vg9e7EIMLNwAAAABJRU5ErkJggg=='
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic3 [
| b |
	b := RTSunburstBuilder new.
	b shape current 
				colorElement: [ :el | Color grayScale256: ((el attributeAt: #depth ifAbsent: [ 0 ]) * 30) ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic3Icon [
	^ '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'
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic4 [
| b |
	b := RTSunburstBuilder new.
	b shape colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic4Icon [
	^ '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
TkSuQmCC'
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic5 [
| b |
	b := RTSunburstBuilder new.
	b strategy radialSpacing:10.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic5Icon [
	^ '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'
]

{ #category : #sources }
RTSunburstBuilderExamples >> examplebasic7 [
| b |
	b := RTSunburstBuilder new.
	b angularSpacing: 1.
	b radialSpacing: 3.
	b shape current 
				colorElement: [ :el | el model subclasses notEmpty ifTrue: [ Color orange ] ifFalse: [ Color red ] ].

	b explore: RTObject using: #subclasses.
	b view @ RTDraggableView.
	b build.
	^ b view
]

{ #category : #icons }
RTSunburstBuilderExamples >> examplebasic7Icon [
	^ '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'
]

{ #category : #examples }
RTSunburstBuilderExamples >> label [
	^ 'Sunburst'
]
