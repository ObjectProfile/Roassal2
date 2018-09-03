Extension { #name : #RTExampleSelection }

{ #category : #'*Roassal2ScriptOfTheDay' }
RTExampleSelection >> discordAction: aGLMPharoScriptPresentation [
	<playgroundExtension>

	aGLMPharoScriptPresentation
		 act: [ :text :page |
				self publishOnDiscordScript: text text asString
				]
			icon: RTChatWithUs discord
			entitled: 'Discord'

]

{ #category : #'*Roassal2ScriptOfTheDay' }
RTExampleSelection >> publishOnDiscord [
	self publishOnDiscordScript: self playgroundSourceCode
]

{ #category : #'*Roassal2ScriptOfTheDay' }
RTExampleSelection >> publishOnDiscordScript: aScript [
	| aTitle |
	aTitle := UIManager default request: 'Enter a short title for the script' initialAnswer: 'A title'.
	self publishOnDiscordScript: aScript withTitle: aTitle
]

{ #category : #'*Roassal2ScriptOfTheDay' }
RTExampleSelection >> publishOnDiscordScript: aScript withTitle: aTitle [
	| view idealExtent message |
	aTitle ifNil: [ ^ self	"Do nothing" ].
	message := 'Script of the day: *' , aTitle , '*' , String cr
		, 'More information about Roassal on http://AgileVisualization.com'
		, String cr , '```Smalltalk' , String cr , aScript , String cr
		, '```'.
	view := (OpalCompiler new
		source: aScript;
		evaluate)
		build;
		view.
	view canvas camera focusOnCenter.
	idealExtent := view elements encompassingRectangle extent.
	DSWebhookClient new
		url:
			'https://discordapp.com/api/webhooks/423098538084270081/YqkIWvxWthFmUGnMDyqtOztpb1ugEPV_YHaCq14O7tae3LlFVhODi6sxC9GSkb77DMpR';
		message: message;
		username: 'Roassal Script of the Day';
		avatarUrl: 'http://objectprofile.com/img/Roassal.png';
		fileName: 'scriptOfTheDay.png'
			morph:
			(TRMorph new
				canvas: view canvas;
				extent: idealExtent);
		send
]
