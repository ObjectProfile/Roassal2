Extension { #name : #GtExampleMethodIcon }

{ #category : #'*Roassal2GT' }
GtExampleMethodIcon class >> fixedBase64String: aString [
	^ Form fromBinaryStream: aString base64Decoded readStream
]
