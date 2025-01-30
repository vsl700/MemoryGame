Class {
	#name : 'MyMGGameElement',
	#superclass : 'BlElement',
	#instVars : [
		'game'
	],
	#category : 'My-Bloc-MemoryGame',
	#package : 'My-Bloc-MemoryGame'
}

{ #category : 'example' }
MyMGGameElement class >> openWithNumber [
	| aGameElement space |
	aGameElement := MGGameElement new
		memoryGame: MGGame withNumbers;
		yourself.
	space := BlSpace new.
	space root addChild: aGameElement.
	space root whenLayoutedDoOnce: [ space extent: aGameElement size ].
	space show
]

{ #category : 'initialization' }
MyMGGameElement >> initialize [
	super initialize.
	self background: Color veryLightGray.
	self layout: (BlGridLayout horizontal cellSpacing: 20).
	self
		constraintsDo: [ :aLayoutConstraints |
			aLayoutConstraints horizontal fitContent.
			aLayoutConstraints vertical fitContent ]
]

{ #category : 'accessing' }
MyMGGameElement >> memoryGame [
	^ game
]

{ #category : 'accessing' }
MyMGGameElement >> memoryGame: aGame [
	| aCardEventListener |
	game := aGame.
	aCardEventListener := MGCardEventListener new
		memoryGame: aGame;
		yourself.
	self layout columnCount: game gridSize.
	game availableCards do: [ :aCard |
		| cardElement |
		cardElement :=
			MGCardElement new
				card: aCard;
				addEventHandler: aCardEventListener;
				yourself.
		self addChild: cardElement ]
]
