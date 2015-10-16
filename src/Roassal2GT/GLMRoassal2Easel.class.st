Class {
	#name : #GLMRoassal2Easel,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Roassal2GT-Glamour'
}

{ #category : #building }
GLMRoassal2Easel >> defaultScriptBindings [
	^ {#view -> RTView new}
]

{ #category : #building }
GLMRoassal2Easel >> defaultScriptDisplayIn: aPresentation [
	^ aPresentation 
		display: 'view';
		morphicAct: [:text | RTRoassalExample new open ] icon: GLMUIThemeExtraIcons glamorousExample entitled: 'Browse basic examples'
]

{ #category : #building }
GLMRoassal2Easel >> defaultTitle [
	^ 'Roassal Easel'
]

{ #category : #private }
GLMRoassal2Easel >> evaluate: script in: context for: view [
	| message |
	^ [ (Smalltalk compiler requestor: self) evaluate: script in: context to: context ]
		on: Error
		do: [ :e | 
			message := e class name , ': ' , e messageText.
			self inform: message.
			view add: (RTLabel new text: message; color: Color red; element) ]
]

{ #category : #building }
GLMRoassal2Easel >> resultIn: a [
	^ a roassal2
		title: 'View';
		painting: [ :view :bindings :script | 
					| context |
					context := GLMDoItContext with: #view -> view withAll: bindings.
					self evaluate: script in: context for: view ]
]
