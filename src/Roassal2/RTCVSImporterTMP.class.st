Class {
	#name : #RTCVSImporterTMP,
	#superclass : #Object,
	#instVars : [
		'blockToExecute'
	],
	#category : #'Roassal2-Plugins'
}

{ #category : #accessing }
RTCVSImporterTMP >> blockToExecute [
	^ blockToExecute
]

{ #category : #accessing }
RTCVSImporterTMP >> blockToExecute: oneArgBlock [
	"Set the block to execute for each line of the CSV"
	blockToExecute := oneArgBlock
]

{ #category : #examples }
RTCVSImporterTMP >> example01 [
	<script: 'MCCVSImporter new example01'>
	
	| c |
	c := 0.
	self blockToExecute: [ :line | c := c + 1 ].
	self importFile.
	self inform: 'There are ', c asString, ' entries' 
]

{ #category : #'importing-filters' }
RTCVSImporterTMP >> importFile [

	"Open a file browser, and load the selected CSV file. Execute blockToExecute for each line that is read"
	| fileName stream lines time n1 n2 weight |
	fileName := UIManager default chooseFullFileNameMatching: #('*.csv') label: 'Pick a CSV file'.
	fileName ifNil: [ self inform: 'Not loaded'. ^ self ].
	stream := fileName asFileReference readStream.
	
	lines := stream contents lines.
	self assert: [ (lines first lines first occurrencesOf: Character tab) = 3 ] description: 'Wrong CSV structure'.

	lines allButFirst do: [ :l |
		| ss |
		ss := l substrings: String tab.
		ss size = 3 ifTrue: [ ss := { ss first . ss second . 'Unknown' . ss third } ].
		time := ss first asInteger.
		n1 := ss second.
		n2 := ss third.
		weight := Float readFrom: ss fourth.
		weight > 0 ifTrue: [
					blockToExecute value: { time . n2 . n1 . weight . '' } ]
	].
]

{ #category : #initialization }
RTCVSImporterTMP >> initialize [
	super initialize.
	blockToExecute := [ :line | "nothing for now" ]
]
