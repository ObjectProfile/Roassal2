Extension { #name : #FileReference }

{ #category : #'*IntelPowerGadget' }
FileReference >> gtInspectorActionAnalyzePowerLogFile [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | 
			| result |
			result := EnergyProfiler new parseFilenamed: self fullName.
			composite selection: result ];
		icon: GLMUIThemeExtraIcons glamorousAdd;
		condition: [ self isFile and: [ self extension = 'log' ] ];
		title: 'Load as Energy Power Log'
]

{ #category : #'*IntelPowerGadget' }
FileReference >> gtInspectorActionConvertPowerLogToCSVFile [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | 
			EnergyProfiler new 
				parseFilenamed: self fullName;
				exportAsCSV: self fullName, '.csv' ];
		icon: GLMUIThemeExtraIcons glamorousAdd;
		condition: [ self isFile and: [ self extension = 'log' ] ];
		title: 'Convert Energy Power log file to CSV'
]
