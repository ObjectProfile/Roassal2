"
A RTGradientColoredLine is an alpha gradient colored shape between the two first values of colorArray with precision.

Instance Variables
	precision :		<Object>

"
Class {
	#name : #RTGradientColoredLine,
	#superclass : #RTMultiColoredLine,
	#instVars : [
		'precision'
	],
	#category : #'Roassal2-Core'
}

{ #category : #'as yet unclassified' }
RTGradientColoredLine >> gradientColorShape [
	| diff  gradientColorArray |

	diff := (colorArray second alpha - colorArray first alpha).
	gradientColorArray := Array with: (colorArray first).

	(2 to: (precision - 1)) do: [ :i | gradientColorArray := gradientColorArray copyWith: ((gradientColorArray atWrap: i - 1) alpha: ( (colorArray first) alpha + ((i - 1) * diff / (precision - 1)) )) ]. 

	gradientColorArray := gradientColorArray copyWith: (colorArray last).
	colorArray := gradientColorArray.
	
	self colorShape.
]

{ #category : #initialization }
RTGradientColoredLine >> initialize [
	super initialize.
	precision := 1.
]

{ #category : #accessing }
RTGradientColoredLine >> precision [
	^ precision
]

{ #category : #accessing }
RTGradientColoredLine >> precision: anInteger [
	^ precision := anInteger
]
