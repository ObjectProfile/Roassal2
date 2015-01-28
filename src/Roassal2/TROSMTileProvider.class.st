"
I am TROSMTileProvider .

I know how to dowload OSM map tiles given their URI z/x/y.png

I cache tiles in a limited LRUCache.

I cache tiles in a file system directory.

I download tiles using a limited number of HTTP clients that are being reused.

I am thread safe.
"
Class {
	#name : #TROSMTileProvider,
	#superclass : #Object,
	#instVars : [
		'httpClients',
		'cache',
		'baseUrl',
		'cacheMonitor',
		'httpClientsMonitor'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'Roassal2-OpenStreetMap'
}

{ #category : #development }
TROSMTileProvider class >> exampleTileNames [
	^ #('7/64/45.png' '7/65/41.png' '7/37/48.png' '7/65/65.png' '7/63/62.png' '7/63/41.png' '7/38/49.png' '7/64/42.png' '7/36/49.png' '7/65/62.png' '7/62/42.png' '7/62/63.png' '7/65/43.png' '7/63/43.png' '7/64/63.png' '7/64/44.png' '7/37/47.png' '7/65/64.png' '7/38/48.png' '7/63/64.png' '7/63/45.png' '7/64/41.png' '7/36/48.png' '7/64/65.png' '7/62/41.png' '7/37/49.png' '7/62/65.png' '7/65/45.png' '7/63/42.png' '7/64/62.png' '7/62/62.png' '7/65/63.png' '7/62/43.png' '7/65/42.png' '7/63/63.png' '7/36/47.png' '7/64/64.png' '7/64/43.png' '7/62/64.png' '7/65/44.png' '7/38/47.png' '7/63/65.png' '7/63/44.png')
]

{ #category : #development }
TROSMTileProvider class >> exampleTiles [
	^ self exampleTileNames collect: [ :each | self tileNamed: each ]
]

{ #category : #development }
TROSMTileProvider class >> removeExampleTilesFromCacheDirectory [
	self exampleTileNames do: [ :each |
		(self uniqueInstance cacheDirectory resolve: each) ensureDelete ]
]

{ #category : #development }
TROSMTileProvider class >> testEmptyCache [
	self uniqueInstance cleanup.
	self removeExampleTilesFromCacheDirectory.
	[ self exampleTiles ] timeToRun
]

{ #category : #development }
TROSMTileProvider class >> testEmptyCacheThreaded [
	self uniqueInstance cleanup.
	self removeExampleTilesFromCacheDirectory.
	[ 
		| semaphore |
		semaphore := Semaphore new.
		self exampleTileNames withIndexDo: [ :e :i | 
			[ 
				self tileNamed: e. 
				semaphore signal ] forkNamed: 'test-', i asString ].
		self exampleTileNames size timesRepeat: [ semaphore wait ]
 	] timeToRun
]

{ #category : #development }
TROSMTileProvider class >> testEmptyMemoryCache [
	self uniqueInstance cleanup.
	[ self exampleTiles ] timeToRun
]

{ #category : #development }
TROSMTileProvider class >> testEmptyMemoryCacheThreaded [
	self uniqueInstance cleanup.
	[ 
		| semaphore |
		semaphore := Semaphore new.
		self exampleTileNames withIndexDo: [ :e :i | 
			[ 
				self tileNamed: e. 
				semaphore signal ] forkNamed: 'test-', i asString ].
		self exampleTileNames size timesRepeat: [ semaphore wait ]
 	] timeToRun
]

{ #category : #development }
TROSMTileProvider class >> testOriginalThreaded [
	[ 
		| semaphore |
		semaphore := Semaphore new.
		self exampleTileNames withIndexDo: [ :e :i | 
			[ 
				ZnEasy getPng: 'https://a.tile.openstreetmap.org/' , e. 
				semaphore signal ] forkNamed: 'test-', i asString ].
		self exampleTileNames size timesRepeat: [ semaphore wait ]
 	] timeToRun
]

{ #category : #development }
TROSMTileProvider class >> testPlain [
	[ self exampleTiles ] timeToRun
]

{ #category : #accessing }
TROSMTileProvider class >> tileNamed: uri [
	^ self uniqueInstance tileNamed: uri
]

{ #category : #accessing }
TROSMTileProvider class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #private }
TROSMTileProvider >> acquireHttpClient [
	^ httpClientsMonitor critical: [ | resource |
		httpClientsMonitor 
			waitWhile: [ httpClients allSatisfy: [ :each | each value = #inuse ] ] 
			maxSeconds: self timeout.
		resource := httpClients detect: [ :each | each value = #free ].
		resource value: #inuse.
		resource key ]
]

{ #category : #private }
TROSMTileProvider >> acquireHttpClient: oneArgBlock [
	| client |
	client := self acquireHttpClient.
	[ ^ oneArgBlock value: client ] 
		ensure: [ self releaseHttpClient: client ]
]

{ #category : #'initialize - release' }
TROSMTileProvider >> baseUrl: url [
	baseUrl := url
]

{ #category : #accessing }
TROSMTileProvider >> cacheDirectory [
	^ 'osm-tiles' asFileReference
]

{ #category : #'initialize - release' }
TROSMTileProvider >> cleanup [
	cache removeAll
]

{ #category : #'initialize - release' }
TROSMTileProvider >> close [
	httpClients do: [ :each | each close ]
]

{ #category : #'initialize - release' }
TROSMTileProvider >> destroyCacheDirectory [
	[ self cacheDirectory deleteAll ] on: FileDoesNotExist do: [ ]
]

{ #category : #private }
TROSMTileProvider >> downloadTileNamed: uri [
	| entity |
	(self fileCacheAt: uri)
		ifNotNil: [ :bytes |
			^ (PNGReadWriter on: bytes readStream) nextImage ].
	self acquireHttpClient: [ :client | 
		entity := client get: uri; entity ].
	^ entity ifNotNil: [
		self fileCacheAt: uri put: entity contents.
		(PNGReadWriter on: entity readStream) nextImage ]
]

{ #category : #private }
TROSMTileProvider >> fileCacheAt: uri [
	| file |
	file := self cacheDirectory resolve: uri.
	^ file exists
		ifTrue: [ 
			file readStreamDo: [ :in | 
				in binary; next: file size ] ]
		ifFalse: [ nil ]
]

{ #category : #private }
TROSMTileProvider >> fileCacheAt: uri put: bytes [
	| file |
	file := self cacheDirectory resolve: uri.
	file parent ensureCreateDirectory.
	file writeStreamDo: [ :out |
		out binary; nextPutAll: bytes ]
]

{ #category : #private }
TROSMTileProvider >> httpClient [
	^ ZnClient new
		systemPolicy;
		accept: ZnMimeType imagePng; 
		ifFail: [ ^ nil ];
		timeout: self timeout;
		yourself
]

{ #category : #'initialize - release' }
TROSMTileProvider >> initialize [
	super initialize.
	baseUrl := 'http://{1}.tile.openstreetmap.org'.
	cacheMonitor := Monitor new.
	httpClientsMonitor := Monitor new.
	"Predefine the maximum number of HTTP clients to be used concurrently"
	httpClients := 'abcabc' collect: [ :each | | client |
		client := self httpClient 
			url: (baseUrl format: { each }); 
			yourself.
		client -> #free ] as: Array.
	"Keep a global, shared memory cache of 64 tiles, about 4Mb"
	(cache := LRUCache new) maximumWeight: 64
]

{ #category : #private }
TROSMTileProvider >> releaseHttpClient: client [
	httpClientsMonitor critical: [ | resource |
		resource := httpClients detect: [ :each | each key = client ].
		resource value: #free.
		httpClientsMonitor signal ]
]

{ #category : #accessing }
TROSMTileProvider >> tileNamed: uri [
	| tile |
	cacheMonitor critical: [ 
		(cache includesKey: uri)
			ifTrue: [ ^ cache at: uri ifAbsentPut: [ self error ] ] ].
	"the download should not lock up access to the cache"
	tile := self downloadTileNamed: uri.
	^ cacheMonitor critical: [ 
		cache at: uri ifAbsentPut: [ tile ] ]
	
]

{ #category : #accessing }
TROSMTileProvider >> timeout [
	^ 10
]
