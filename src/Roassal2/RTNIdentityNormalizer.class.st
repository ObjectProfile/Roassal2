"
A RONIdentityNormalizer is xxxxxxxxx.

Instance Variables
	colorIndex:		<Object>
	dictionary:		<Object>

colorIndex
	- xxxxx

dictionary
	- xxxxx

"
Class {
	#name : #RTNIdentityNormalizer,
	#superclass : #RTNAbstractNormalizer,
	#instVars : [
		'dictionary',
		'colorIndex'
	],
	#category : #'Roassal2-ColorNormalizer'
}

{ #category : #'instance creation' }
RTNIdentityNormalizer class >> beginingAtBlue [
	^ self new
			setIndexTo: #blue;
			yourself
]

{ #category : #'instance creation' }
RTNIdentityNormalizer class >> beginingAtRed [
	^ self new
			setIndexTo: #red;
			yourself
]

{ #category : #'instance creation' }
RTNIdentityNormalizer class >> withCommand: aBlock [
	
	^(self new)
		command: aBlock;
		yourself
]

{ #category : #'initialize-release' }
RTNIdentityNormalizer >> colorNames [
	^ #(#black #veryVeryDarkGray #veryDarkGray #darkGray #gray #lightGray #veryLightGray #veryVeryLightGray #white #red #yellow #green #cyan #blue #magenta #brown #orange #lightRed #lightYellow #lightGreen #lightCyan #lightBlue #lightMagenta #lightBrown #lightOrange #transparent)
]

{ #category : #'initialize-release' }
RTNIdentityNormalizer >> initialize [
	
	super initialize.
	colorIndex := 0.
	dictionary := IdentityDictionary new.
	command := #yourself
]

{ #category : #private }
RTNIdentityNormalizer >> nextColor [
	
	colorIndex := colorIndex \\ self colorNames size + 1.
	^Color perform: (self colorNames at: colorIndex)
]

{ #category : #accessing }
RTNIdentityNormalizer >> rtValue: anEntity [
	
	^dictionary
		at: (command rtValue: anEntity)
		ifAbsentPut: [ self nextColor ]
]

{ #category : #private }
RTNIdentityNormalizer >> setIndexTo: colorAsSymbol [
	"colorAsSymbol has to be one of Color colorNames. 
	The method set the current index to the color given in parameter"
	
	colorIndex := (self colorNames indexOf: colorAsSymbol) - 1
]
