"
I am a class that simply forward to the discord channel
"
Class {
	#name : #RTChatWithUs,
	#superclass : #RTObject,
	#category : #'Roassal2-MorphSpecific-Menu'
}

{ #category : #'world menu' }
RTChatWithUs class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Live chat')
			order: 0.002; 
			parent: #Roassal;
			label: 'Live chat';
			icon: (Smalltalk ui icons iconNamed: #smallLanguageIcon);
			action: [ WebBrowser openOn: 'https://discord.gg/bAuNJMP'  ]
]

{ #category : #'instance creation' }
RTChatWithUs >> open [
	"
	self new open
	"
	| v labels |
	v := RTView new.
	labels := RTGroup new.
	labels
		add:
			(RTLabel
				elementOn: 'Problems and bugs can be reported on:').
				

	labels
		add:
			((RTLabel new color: Color veryVeryDarkGray)
				elementOn: 'https://github.com/moosetechnology/Moose/issues').
				
	labels
		add:
			(RTLabel
				elementOn: 'After inserting the bug, please send an email to ').
	labels
		add:
			(RTLabel
				elementOn: 'the moose mailing list or to the Slack #roassal channel').


				
	v add: labels.
	RTVerticalLineLayout on: labels.


	"Adding animation"
	self addAnimationTo: v.
	v openInWindowSized: 600 @ 400 titled: 'Roassal Visualization Engine'
]
