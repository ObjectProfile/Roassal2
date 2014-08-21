"
A RTExampleBrowser is the main class to browse examples of Roassal
"
Class {
	#name : #RTExampleBrowser,
	#superclass : #RTObject,
	#classInstVars : [
		'icon'
	],
	#category : 'Roassal2-ExampleBrowser'
}

{ #category : #menu }
RTExampleBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>

	(aBuilder item: #'Roassal Examples')
		order: 0.1; 
		parent: #Roassal;
		label: 'Roassal examples';
		icon: self roassalWithTransparentIcon;
		action:[ self new open ]
]

{ #category : #logo }
RTExampleBrowser class >> roassalWithTransparentIcon [
	"Private - Generated method"
	^ icon ifNil: [ icon := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: self roassalWithTransparentIconContents readStream) ].
]

{ #category : #logo }
RTExampleBrowser class >> roassalWithTransparentIconContents [
	"Private - Method generated with the content of the file C:\Users\azazael\Documents\smalltalk\inti\moose\roassalWithTransparent.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAAAoAAAASCAYAAABit09LAAABLElEQVR4XmP4//8/w38iMFGK
aK1wWo/Z/8Tgiv86UhP+a0vX/9eRbvuvLbnyv57U1P8zek2givoFgArmAvFSoKKS/1N7pf5P
6xX7P7XHCaj4zv/EiEKIQh2pLqCgNxCHACX+/58xkQtuk7bkGaB4JYQztVfh//nzjECBnP/a
Umf+z+oTAooZ/teTbgA6J+//qaPSCDeePsYJFGwFmj7jv4F0E1DDrP9W8oX/Tx0TRfeMzn8d
yTVAT3j/15WqBiq8+j80lBnT11N7goHuOf1/2kTu//Nni/031egCalz1//Rx9v9XTjEiKwS6
T/ICmH3lCsP/7CQHoKlf/ieGRP/PCndCKNSRnAzE+1ACWk/GAyh28r+udAFC0EwvDBheYYRj
ZsEC5v+nTjENwtQDAHm03ZBoT2X8AAAAAElFTkSuQmCC'
]

{ #category : #utility }
RTExampleBrowser >> lineUpAndAnimate: aView [
	"Structure a view with a proper layout and animation"
	RTVerticalLineLayout on: aView elements.
	aView elements doWithIndex: [ :each :index | 
		| p |
		p := each position.
		each translateBy: (index * 50) @ 0.
		aView addAnimation: (RTLinearMove to: p during: 0.4 on: each) ].
	

]

{ #category : #'instance creation' }
RTExampleBrowser >> listExamplesOn: v [
	RTAbstractExample subclasses do: [ :c | c new installOn: v ]
]

{ #category : #'instance creation' }
RTExampleBrowser >> open [
	| v |
	v := RTView new.
	v @ RTDraggableView.
	self listExamplesOn: v.
	self lineUpAndAnimate: v.
	self show: v.
	self positionCameraOn: v
]

{ #category : #'instance creation' }
RTExampleBrowser >> positionCameraOn: v [
	| p |
	"We set the camera position where it fits to. We need to do this since there is an animation"
	p := v canvas camera position.	
	v canvas camera translateTo: 50 @ p y
]

{ #category : #'instance creation' }
RTExampleBrowser >> show: v [
	v openInWindowSized: 500 @ 500 titled: 'Roassal'
]
