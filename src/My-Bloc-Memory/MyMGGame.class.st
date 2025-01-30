Class {
	#name : 'MyMGGame',
	#superclass : 'Object',
	#instVars : [
		'availableCards',
		'chosenCards'
	],
	#category : 'My-Bloc-Memory-Model',
	#package : 'My-Bloc-Memory',
	#tag : 'Model'
}

{ #category : 'factory' }
MyMGGame class >> withNumbers [ 
	<sampleInstance>
	^ self new initializeForSymbols: '12345678'
]

{ #category : 'accessing' }
MyMGGame >> availableCards [ 
	^ availableCards 
]

{ #category : 'accessing' }
MyMGGame >> cardsCount [ 
	"Return how many cards there should be depending on grid size"
	^ self gridSize * self gridSize
]

{ #category : 'actions' }
MyMGGame >> chooseCard: aCard [
	(self chosenCards includes: aCard)
		ifTrue: [ ^ self ].
	self chosenCards add: aCard.
	aCard flip.
	self shouldCompleteStep 
		ifTrue: [ ^ self completeStep ].
	self shouldResetStep 
		ifTrue: [ self resetStep ]
]

{ #category : 'testing' }
MyMGGame >> chosenCardMatch [ 
	| firstCard |
	firstCard := self chosenCards first.
	^ self chosenCards allSatisfy: [ :aCard |
		aCard isFlipped and: [ firstCard symbol = aCard symbol ] ]
]

{ #category : 'accessing' }
MyMGGame >> chosenCards [ 
	^ chosenCards
]

{ #category : 'actions' }
MyMGGame >> completeStep [ 
	self chosenCards 
		do: [ :aCard | aCard disappear ];
		removeAll.
]

{ #category : 'accessing' }
MyMGGame >> gridSize [ 
	"Return grid size"
	^ 4
]

{ #category : 'initialization' }
MyMGGame >> initialize [ 
	super initialize.
	availableCards := OrderedCollection new.
	chosenCards := OrderedCollection new
]

{ #category : 'initialization' }
MyMGGame >> initializeForSymbols: aCollectionOfCharacters [
	aCollectionOfCharacters size = (self cardsCount / self matchesCount )
		ifFalse: [ self error: 'Amount of characters must be equal to possible all combinations' ].
		
	aCollectionOfCharacters do: [ :aSymbol |
		1 to: self matchesCount do: [ :i |
			availableCards add: (MyMGCard new symbol: aSymbol ) ] ].
	availableCards := availableCards shuffled
]

{ #category : 'testing' }
MyMGGame >> matchesCount [ 
	"How many chosen cards should match for them to disappear."
	^ 2
]

{ #category : 'initialization' }
MyMGGame >> resetStep [ 
	| lastCard |
	lastCard := self chosenCards last.
	self chosenCards 
		allButLastDo: [ :aCard | aCard flip ];
		removeAll;
		add: lastCard
]

{ #category : 'asserting' }
MyMGGame >> shouldCompleteStep [ 
	^ self chosenCards size = self matchesCount 
		and: [ self chosenCardMatch ]
]

{ #category : 'asserting' }
MyMGGame >> shouldResetStep [ 
	^ self chosenCards size > self matchesCount
]
