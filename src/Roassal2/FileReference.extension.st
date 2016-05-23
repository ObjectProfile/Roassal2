Extension { #name : #FileReference }

{ #category : #'*Roassal2-Plugins' }
FileReference >> grapherVisualizationFromFileName: aFileName [
	"Ask the users which columns to visualize. Return a grapher instance"
	| g tab title columnsAsString d |
	tab := RTTabTable new input: aFileName asFileReference contents usingDelimiter: #,.
	title := 'The file has ', tab numberOfColumns asString, String cr, 'Which columns do you want to plot?'.
	columnsAsString := UIManager default request: title initialAnswer: '1 2 3'.
	(columnsAsString isNil or: [ columnsAsString isEmpty ]) ifTrue: [ ^ RTView new ].
	
	tab removeFirstRow.
	g := RTGrapher new.
	columnsAsString substrings do: [ :s |
		d := RTData new.
		d points: ((tab valuesOfColumn: s asInteger) collect: [ :ss | Float readFrom: ss ]).
		g add: d.
	].
	^ g
]

{ #category : #'*Roassal2-Plugins' }
FileReference >> gtInspectorActionVisualizeCSVFile [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | 
			| result |
			result := self grapherVisualizationFromFileName: self fullName.
			composite selection: result 
			 ];
		icon: GLMUIThemeExtraIcons glamorousGreenCircle;
		condition: [ self isFile and: [ self extension = 'csv' ] ];
		title: 'Visualize data'
]
