Class {
	#name : 'MyMGCardEventListener',
	#superclass : 'BlEventListener',
	#instVars : [
		'memoryGame'
	],
	#category : 'My-Bloc-Memory',
	#package : 'My-Bloc-Memory'
}

{ #category : 'mouse handlers' }
MyMGCardEventListener >> clickEvent: anEvent [
	memoryGame chooseCard: anEvent currentTarget card
]
