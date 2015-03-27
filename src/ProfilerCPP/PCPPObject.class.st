Class {
	#name : #PCPPObject,
	#superclass : #MooseEntity,
	#category : #ProfilerCPP
}

{ #category : #'as yet unclassified' }
PCPPObject class >> annotation [
	<MSEClass: #PCPPObject super: #MooseEntity>
	<package: #ProfilerCPP>
	^ self

]

{ #category : #'as yet unclassified' }
PCPPObject >> isFunction [
	^ false
]
