"
Create a simple namecloud 
"
Class {
	#name : #RTNameCloud,
	#superclass : #RTBuilder,
	#instVars : [
		'table',
		'maxHeight',
		'minHeight',
		'maxWords'
	],
	#category : #'Roassal2-Builder-NameCloud'
}

{ #category : #adding }
RTNameCloud >> addString: string [
	 string substrings do: [ :w | self addWord: w ]
]

{ #category : #adding }
RTNameCloud >> addStrings: collectionOfStrings [
	collectionOfStrings do: [ :s | self addString: s ]
]

{ #category : #adding }
RTNameCloud >> addWord: aWordAsString [
	| w |
	w := self prepareWord: aWordAsString.
	(self isValidWord: w) ifTrue: 
		[ table at: w ifAbsentPut: [ 0 ].
		  table at: w put: (table at: w) + 1 ]
]

{ #category : #examples }
RTNameCloud >> example01 [
	"
	self new example01
	"

	RTNameCloud new 
		addString: 'open

		| v shape |
		v := RTView new.
		shape := RTLabel new height: [ :assoc | assoc value ]; text: #key.
		v addAll: (shape elementsOn: table associations).
		RTFlowLayout on: v elements.
		v open';
		open
]

{ #category : #examples }
RTNameCloud >> example02 [
	"
	self new example02
	"
	| b |
	b := RTNameCloud new.
	b addStrings: (RTNameCloud methods collect: #getSource).
	b open
]

{ #category : #examples }
RTNameCloud >> example03 [
	"
	self new example03
	"
	| b |
	b := RTNameCloud new.
	RTObject withAllSubclasses do: [ :c | 
		b addStrings: (c methods collect: #getSource) ].
	b open
]

{ #category : #examples }
RTNameCloud >> example04 [
	"
	self new example04
	"
	| b |
	b := RTNameCloud new.
	b minHeight: 20.
	b maxHeight: 30.
	b addString: 'I am not that tall but I speak many languages. But I have tall legs and big feet'.
	b open
]

{ #category : #initialization }
RTNameCloud >> initialize [
	super initialize.
	table := Dictionary new.
	maxHeight := 30.
	minHeight := 5.
	maxWords := 150.
]

{ #category : #testing }
RTNameCloud >> isValidWord: word [
	^ word notEmpty and: [ (self unnecessaryWords includes: word) not ]
]

{ #category : #accessing }
RTNameCloud >> maxFrequency [
	^ table values max
]

{ #category : #accessing }
RTNameCloud >> maxHeight [
	^ maxHeight
]

{ #category : #accessing }
RTNameCloud >> maxHeight: anObject [
	maxHeight := anObject
]

{ #category : #accessing }
RTNameCloud >> minFrequency [
	^ table values min
]

{ #category : #accessing }
RTNameCloud >> minHeight [
	^ minHeight
]

{ #category : #accessing }
RTNameCloud >> minHeight: anObject [
	minHeight := anObject
]

{ #category : #utility }
RTNameCloud >> prepareWord: word [
	^ word select: #isLetter
]

{ #category : #'instance creation' }
RTNameCloud >> renderIn: aView [

	| shape es |
	shape := RTLabel new height: [ :assoc | 
		(assoc value - self minFrequency * maxHeight / (self maxFrequency - self minFrequency max: 1)) + minHeight ]; text: #key.
	es := shape elementsOn: self sortedAssociationsBounded.
	aView addAll: es.
	es @ RTPopup.
	es @ (RTMenuActivable action: #inspect).

	RTFlowLayout new
		on: es

]

{ #category : #accessing }
RTNameCloud >> sortedAssociations [

	^ table associations reverseSortedAs: #value
]

{ #category : #accessing }
RTNameCloud >> sortedAssociationsBounded [

	^ self sortedAssociations copyFrom: 1 to: (self sortedAssociations size min: maxWords)
]

{ #category : #dictionaries }
RTNameCloud >> topWords: index [
	"Return the top index words"
	^ ((self sortedAssociations copyFrom: 1 to: index) collect: #key) asArray
]

{ #category : #dictionaries }
RTNameCloud >> unnecessaryWords [
	^ #(
	'the' 'to' 'I' 'a' 'and' 'it' 'of' 'is' 'that' 'in'
	'for' 'this' 'have' 'with' 'be' 'or' 'was' 'on'
	'there' 'what' 'are' 'can' 'about' 'some' 'do' 'but' 'when' 'am' 'from' 'know' 'how' 'would' 'like' 'any' 'get' 'an' 'using' 'as' 'by' 'not' 'they' 'which' 
	
	'into' 'through' 'my' 'used' 'at' 'function'  'just' 'you' 'its' 'me' 'way' 'if' 'so' 'then' 'Im' 'use'  'anyone' 'has' 'does' 'all' 'run' 'sample' 'also' 'different' 'want' 'find' 'other'  'enough' 'So' 'something' 'one' 'been' 'could' 'How' 'trying' 'able' 'see' 'had' 'no' 'new' 'very' 'another' 'few'  'The' 'point' 'make' 'out' 'What' 'executed' 'were' 'looking' 'will' 'here'  'without'  'same' 'dont' 'But' 'started' 'Or' 'better' 'go' 'recently' 'going' 'up' 'following' 'call' 'seems' 'address' 'after'  'kind' 'only' 'add' 'machine' 'them' 'perform' 'piece' 'jump' 'where'  'under' 'really'  'possible' 'break' 'around' 'set'  'body'  'your' 'approach' 'several' 'And' 'Is' 'static' 'learning' 'may' 'value' 'time' 'looks' 'various' 'gets' 'x' 'specific' 'interested' 'named' 'more' 'over'  'pointer' 'encountered' 'certain' 'particular' 'reading' 'step' 'itself' 'Does' 'basic' 'tried' 'someone' 'increment' 'learned' 'come' 'suggest' 'having' 'dealing' 'load' 'should' 'E' 'Word' 'detailed' 'target'  'identify' 'real' 'detect' 'lot' 'because' 'case' 'Id'
	
	)
]
