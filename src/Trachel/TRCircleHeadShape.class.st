Class {
	#name : #TRCircleHeadShape,
	#superclass : #TRAbstractLineDecoratorShape,
	#category : #'Trachel-ShapesForArrow'
}

{ #category : #visiting }
TRCircleHeadShape >> accept: aVisitor onStart: aBoolean [

	aVisitor visitCircleHeadShape: self onStart: aBoolean
]

{ #category : #hooks }
TRCircleHeadShape >> computePath [
	path := TRPlatform current computeCircleHeadPathFor: self.
	
]

{ #category : #initialization }
TRCircleHeadShape >> initialize [
	super initialize.
	open := false.
]
