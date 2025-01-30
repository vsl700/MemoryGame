Class {
	#name : 'MyMGCard',
	#superclass : 'Object',
	#classVars : [
		'announcer',
		'flipped',
		'symbol'
	],
	#category : 'My-Bloc-Memory-Model',
	#package : 'My-Bloc-Memory',
	#tag : 'Model'
}

{ #category : 'accessing' }
MyMGCard >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'actions' }
MyMGCard >> disappear [ 
	self notifyDisappear 
]

{ #category : 'actions' }
MyMGCard >> flip [
	flipped := flipped not.
	self notifyFlipped
]

{ #category : 'initialization' }
MyMGCard >> initialize [
	super initialize.
	flipped := false
]

{ #category : 'testing' }
MyMGCard >> isFlipped [ 
	^ flipped
]

{ #category : 'notifying' }
MyMGCard >> notifyDisappear [ 
	self announcer announce: MyMGCardDisappearAnnouncement new
]

{ #category : 'notifying' }
MyMGCard >> notifyFlipped [
	self announcer announce: MyMGCardFlippedAnnouncement new
]

{ #category : 'printing' }
MyMGCard >> printOn: aStream [
	aStream
		nextPutAll: 'Card';
		nextPut: Character space;
		nextPut: $(;
		nextPut: self symbol;
		nextPut: $)
]

{ #category : 'printing' }
MyMGCard >> symbol [
	^ symbol
]

{ #category : 'accessing' }
MyMGCard >> symbol: aCharacter [
	symbol := aCharacter
]
