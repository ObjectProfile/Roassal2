Class {
	#name : #GLMBrickThemer,
	#superclass : #Object,
	#traits : 'GLMBrickScrollpaneStyle + GLMBrickRubricStyle',
	#classTraits : 'GLMBrickScrollpaneStyle classTrait + GLMBrickRubricStyle classTrait',
	#instVars : [
		'modules'
	],
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-modules' }
GLMBrickThemer >> addModule: aThemerModule named: aSymbol [

	self modules at: aSymbol put: aThemerModule.
	aThemerModule themer: self.
	^ aThemerModule
]

{ #category : #brick }
GLMBrickThemer >> backgroundColor [

	^ Color transparent
]

{ #category : #brick }
GLMBrickThemer >> contentBackgroundColor [

	^ Color white
]

{ #category : #'brick-modules' }
GLMBrickThemer >> doesNotUnderstand: aMessage [

	^ self modules at: aMessage selector ifAbsent: [ super doesNotUnderstand: aMessage ]
	
]

{ #category : #'brick-modules' }
GLMBrickThemer >> modules [

	^ modules ifNil: [ modules := Dictionary new ]
]

{ #category : #'brick-modules' }
GLMBrickThemer >> registerModule: aModule to: aThemer [
	|key|
	key := thisContext sender selector.
	"Registers aModule to aThemer. It stores modules in a dictionaty where a key is a selector of my caller method. It allows to customize bricks that are not added to the application (in this case they don't have access to custom themer normaly, because owner is nil) using the same api as added one."
	^ self modules
		at: key
		ifAbsent: [ aThemer addModule: aModule named: key ]
]

{ #category : #brick }
GLMBrickThemer >> textColor [

	^ Color black
]
