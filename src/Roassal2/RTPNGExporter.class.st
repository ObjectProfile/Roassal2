"
A RTPNGExporter export the view or builder provided as argument as a PNG file
"
Class {
	#name : #RTPNGExporter,
	#superclass : #RTObject,
	#instVars : [
		'view',
		'fileName'
	],
	#category : #'Roassal2-Exporter-PNG'
}

{ #category : #accessing }
RTPNGExporter >> builder [
	"Return a view or a builder that has been previous assigned"
	^ view
]

{ #category : #accessing }
RTPNGExporter >> builder: aViewOrABuilder [
	view := aViewOrABuilder
]

{ #category : #util }
RTPNGExporter >> cameraPositionNegated [
	^ self encompassingRectangle center negated
]

{ #category : #util }
RTPNGExporter >> cameraScale [
	^ self trachelCanvas camera scale asFloat
]

{ #category : #util }
RTPNGExporter >> createFormCanvas [
	"Return a new form"
	| form |
	form := FormCanvas extent: self viewExtent.
	form fillRectangle: self encompassingRectangle color: self trachelCanvas color.
	^ form
]

{ #category : #util }
RTPNGExporter >> createSurface [
	^ AthensCairoSurface extent: self viewExtent
]

{ #category : #util }
RTPNGExporter >> encompassingRectangle [
	^ self trachelCanvas encompassingRectangle
]

{ #category : #public }
RTPNGExporter >> exportToFile [
	| trachelCanvas surface  |
	trachelCanvas := self trachelCanvas.
	surface := self createSurface.
	surface
		drawDuring: [ :cs | 
			"Probably not necessary since we have just created a surface"
			surface clear.
			cs pathTransform
				translateBy: self viewHalfExtent;
				scaleBy: self cameraScale;
				translateBy: self cameraPositionNegated.
			trachelCanvas shapes do: [ :trachelShape | trachelShape drawOn: cs ].
			cs pathTransform loadIdentity scaleBy: 1.001.
			"trachelCanvas fixedShapes do: [ :trachelShape | trachelShape drawOn: cs ]" ].
	surface writeToPng: self fileName
]

{ #category : #accessing }
RTPNGExporter >> fileName [
	^ fileName
]

{ #category : #accessing }
RTPNGExporter >> fileName: aFilenameAsString [
	fileName := aFilenameAsString
]

{ #category : #initialization }
RTPNGExporter >> getIFrameDefFromView: aView label: aLabelAsString directory: aDirectory [
	"This method is useful when invoked from within Pillar"
	
	| pngFileName writeStream |
	pngFileName := (aDirectory / aLabelAsString, 'png') pathString.
	writeStream := pngFileName asFileReference writeStream.
	RTPNGExporter new builder: aView; fileName: pngFileName; exportToFile.
	^ '<img src="', pngFileName, '" 
		name="', aLabelAsString, '" ></img>' 
]

{ #category : #initialization }
RTPNGExporter >> initialize [
	super initialize.
	self setDefaultFileName
]

{ #category : #initialization }
RTPNGExporter >> insert: aView named: aName inPillarStream: aStream [
	self insert: aView named: aName inPillarStream: aStream directory: self defaultDirectory 
]

{ #category : #initialization }
RTPNGExporter >> insert: aView named: aName inPillarStream: aStream directory: aDirectory [
	| s |
	s := self getIFrameDefFromView: aView label: aName directory: aDirectory.
	aStream nextPutAll: '{{{ <BR>', s, ' }}}'
]

{ #category : #initialization }
RTPNGExporter >> setDefaultFileName [
	self fileName: 'roassal.png'
]

{ #category : #util }
RTPNGExporter >> trachelCanvas [
	^ self builder view canvas
]

{ #category : #util }
RTPNGExporter >> viewExtent [
	^ self encompassingRectangle extent asIntegerPoint + (5 @ 5)
]

{ #category : #util }
RTPNGExporter >> viewHalfExtent [
	^ (self viewExtent / 2) asFloatPoint
]
