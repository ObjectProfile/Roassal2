Class {
	#name : #GLMPhlowDestination,
	#superclass : #GLMPhlowTarget,
	#instVars : [
		'port'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowDestination class >> target: anObject port: aPortObject [

	^ self new phlowObject: anObject; port: aPortObject; yourself
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMPhlowDestination >> phlowValue: anObject value: anotherObject [

	self port phlowValue: (self phlowObject phlowValue: anotherObject) value: anObject
	
]

{ #category : #accessing }
GLMPhlowDestination >> port [
	^ port
]

{ #category : #accessing }
GLMPhlowDestination >> port: anObject [
	"port can be anything"
	port := anObject
]
