"
A GLMInteractableBrick is a subclass of GLMBrick to allow user interactions such as: mouseLeave, mouseEnter, mouseDown, mouseUp and for each state can change background color or background image, that resizes accordinately to Brick's size

Instance Variables
	announcer:		<Object>
	checkedColor:		<Object>
	checkedImage:		<Object>
	isChecked:		<Object>
	isEnabled:		<Object>
	isPressed:		<Object>
	isSelected:		<Object>
	normalColor:		<Object>
	normalImage:		<Object>
	pressedColor:		<Object>
	pressedImage:		<Object>
	selectedColor:		<Object>
	selectedImage:		<Object>

announcer
	- xxxxx

checkedColor
	- xxxxx

checkedImage
	- xxxxx

isChecked
	- xxxxx

isEnabled
	- xxxxx

isPressed
	- xxxxx

isSelected
	- xxxxx

normalColor
	- xxxxx

normalImage
	- xxxxx

pressedColor
	- xxxxx

pressedImage
	- xxxxx

selectedColor
	- xxxxx

selectedImage
	- xxxxx

"
Class {
	#name : #GLMInteractableBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'normalImage',
		'pressedImage',
		'selectedImage',
		'checkedImage',
		'announcer',
		'checkedColor',
		'normalColor',
		'pressedColor',
		'selectedColor',
		'isSelected',
		'isPressed',
		'isChecked',
		'isEnabled'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #states }
GLMInteractableBrick class >> normalColorOf: aTrick [
	^ self pressedColor: false selectedColor: false of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> normalOf: aTrick [
	^ self pressed: false selected: false of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> pressed: isPressed of: aTrick [
	^ self pressed: isPressed selected: false of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> pressed: isPressed selected: isSelected checked: isChecked of: aTrick [
	"answers sender with image, corresponding specified state"
	
	"pressed has the highest priority"
	(isPressed & aTrick pressedImage notNil)
		ifTrue: [ ^ aTrick pressedImage ].
	
	(isChecked & aTrick checkedImage notNil)
		ifTrue: [ ^ aTrick checkedImage ].
		
	(((isPressed & aTrick pressedImage isNil) | isSelected) & aTrick selectedImage notNil)
		ifTrue: [ ^ aTrick selectedImage ].
	
	^ aTrick normalImage.
]

{ #category : #states }
GLMInteractableBrick class >> pressed: isPressed selected: isSelected of: aTrick [
	^ self pressed: isPressed selected: isSelected checked: false of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> pressedColor: isPressed of: aTrick [
	^ self pressedColor: isPressed selectedColor: false of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> pressedColor: isPressed selectedColor: isSelected checkedColor: isChecked of:aTrick [
	"answers sender with image, corresponding specified state"
	
	"pressed has the highest priority"
	(isPressed & aTrick pressedColor notNil)
		ifTrue: [ ^ aTrick pressedColor ].
		
	(isChecked & aTrick checkedColor notNil)
		ifTrue: [ ^ aTrick checkedColor ].
		
	(((isPressed & aTrick pressedColor isNil) | isSelected) & aTrick selectedColor notNil)
		ifTrue: [ ^ aTrick selectedColor ].

	
	^ aTrick normalColor.
]

{ #category : #states }
GLMInteractableBrick class >> pressedColor: isPressed selectedColor: isSelected of: aTrick [
	^ self pressedColor: isPressed selectedColor: isSelected checkedColor: false of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> selected: isSelected of: aTrick [
	^ self pressed: false selected: isSelected of: aTrick
]

{ #category : #states }
GLMInteractableBrick class >> selectedColor: isSelected of: aTrick [
	^ self pressedColor: false selectedColor: isSelected of: aTrick
]

{ #category : #actions }
GLMInteractableBrick >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #actions }
GLMInteractableBrick >> check [
	self isChecked ifFalse: [
		isChecked := true.
		self changed.
	]
]

{ #category : #accessing }
GLMInteractableBrick >> checkedColor [
	^ checkedColor
]

{ #category : #accessing }
GLMInteractableBrick >> checkedColor: anObject [
	checkedColor := anObject
]

{ #category : #accessing }
GLMInteractableBrick >> checkedImage [
	^ checkedImage
]

{ #category : #accessing }
GLMInteractableBrick >> checkedImage: anObject [
	checkedImage := anObject
]

{ #category : #actions }
GLMInteractableBrick >> click: evt [
	^ false
]

{ #category : #accessing }
GLMInteractableBrick >> currentColor [
	^ self state pressedColor: (self isPressed) selectedColor: (self isSelected) checkedColor: (self isChecked) of: self
]

{ #category : #accessing }
GLMInteractableBrick >> currentImage [
	^ self state pressed: (self isPressed) selected: (self isSelected) checked: (self isChecked) of: self
]

{ #category : #actions }
GLMInteractableBrick >> depress [
	self isPressed ifTrue: [
		isPressed := false.
		self changed.
		^ true
	].

	^ false
]

{ #category : #actions }
GLMInteractableBrick >> deselect [
	self isSelected ifTrue: [
		isSelected := false.
		self changed.
	]
]

{ #category : #actions }
GLMInteractableBrick >> disable [
	isEnabled := false.
]

{ #category : #actions }
GLMInteractableBrick >> enable [
	
	isEnabled := true.
]

{ #category : #'mouse events' }
GLMInteractableBrick >> handlesMouseDown: evt [
	
	^ self isEnabled
		ifTrue: [ true ]
		ifFalse: [ super handlesMouseDown: evt ]
	
]

{ #category : #'mouse events' }
GLMInteractableBrick >> handlesMouseOver: evt [
	^ self isEnabled
		ifTrue: [ true ]
		ifFalse: [ super handlesMouseDown: evt ]
]

{ #category : #initialization }
GLMInteractableBrick >> initialize [
	super initialize.
	
	isChecked := false.
	isPressed := false.
	isSelected := false.
	
	self renderer: GLMInteractableBrickRenderer new.
	
	self disable.
]

{ #category : #actions }
GLMInteractableBrick >> isChecked [
	^ isChecked.
]

{ #category : #actions }
GLMInteractableBrick >> isEnabled [
	^ isEnabled
]

{ #category : #testing }
GLMInteractableBrick >> isFocused [

	^ false
]

{ #category : #actions }
GLMInteractableBrick >> isPressed [
	^ isPressed.
]

{ #category : #actions }
GLMInteractableBrick >> isSelected [
	^ isSelected.
]

{ #category : #'mouse events' }
GLMInteractableBrick >> mouseDown: evt [
	super mouseDown: evt.
	^ self press.
]

{ #category : #'mouse events' }
GLMInteractableBrick >> mouseEnter: evt [
	super mouseEnter: evt.
	^ self select
]

{ #category : #'mouse events' }
GLMInteractableBrick >> mouseLeave: evt [
	super mouseLeave: evt.
	^ self deselect
]

{ #category : #'mouse events' }
GLMInteractableBrick >> mouseUp: evt [
	super mouseUp: evt.
	(self bounds containsPoint: evt position) & (self isPressed) ifTrue: [
		self depress.
		^ self click: evt
	] ifFalse: [
		self deselect.
		^ self depress.
	]
]

{ #category : #accessing }
GLMInteractableBrick >> normalColor [
	^ normalColor
]

{ #category : #accessing }
GLMInteractableBrick >> normalColor: anObject [
	normalColor := anObject
]

{ #category : #accessing }
GLMInteractableBrick >> normalImage [
	^ normalImage
]

{ #category : #accessing }
GLMInteractableBrick >> normalImage: anObject [
	normalImage := anObject
]

{ #category : #actions }
GLMInteractableBrick >> press [
	self isPressed ifFalse: [
		isPressed := true.
		self changed.
	].

	^ false
]

{ #category : #accessing }
GLMInteractableBrick >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
GLMInteractableBrick >> pressedColor: anObject [
	pressedColor := anObject
]

{ #category : #accessing }
GLMInteractableBrick >> pressedImage [
	^ pressedImage
]

{ #category : #accessing }
GLMInteractableBrick >> pressedImage: anObject [
	pressedImage := anObject
]

{ #category : #actions }
GLMInteractableBrick >> select [
	self isSelected ifFalse: [ 
		isSelected := true.
		self changed.
	]
]

{ #category : #accessing }
GLMInteractableBrick >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
GLMInteractableBrick >> selectedColor: anObject [
	selectedColor := anObject
]

{ #category : #accessing }
GLMInteractableBrick >> selectedImage [
	^ selectedImage
]

{ #category : #accessing }
GLMInteractableBrick >> selectedImage: anObject [
	selectedImage := anObject
]

{ #category : #accessing }
GLMInteractableBrick >> state [

	^ self class
]

{ #category : #actions }
GLMInteractableBrick >> uncheck [
	self isChecked ifTrue: [
		isChecked := false.
		self changed.
	]
]
