Class {
	#name : #CardManager,
	#superclass : #Object,
	#instVars : [
		'lastCardPlayed',
		'playerCards',
		'drawDeck',
		'discardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardManager class >> with: somePlayersNames using: aDeck [

	^ (self new) initializeWith: somePlayersNames using: aDeck.

	
]

{ #category : #'card playability' }
CardManager >> a: aCardOwner has: aCard [
	
	| ownerHand |
	
	ownerHand := (playerCards detect: [:aPlayerCards | aPlayerCards equals: aCardOwner]).
	^ ownerHand hasInHand: aCard.
	
]

{ #category : #'adding Cards' }
CardManager >> addPermanent: aPermanentCard to: aTargetPlayerCards [

	| targetCards |
	
	targetCards := playerCards detect: [:aPlayerCards | aPlayerCards equals: aTargetPlayerCards].
	targetCards addToPermanentPile: aPermanentCard.
]

{ #category : #'adding Cards' }
CardManager >> addToAllPermanentPiles: aPermanentCard [
	
	playerCards do: [ :aPlayerCards | aPlayerCards addToPermanentPile: aPermanentCard ].
]

{ #category : #adding }
CardManager >> addToDiscardDeck: aCard [

	discardDeck add: aCard.
]

{ #category : #'card playability' }
CardManager >> checkCancel: aPermanentCardToCancel to: aTargetPlayerCards [

	(((playerCards detect: [:aPlayerCards | aPlayerCards equals: aTargetPlayerCards]) permanents) anySatisfy: [ :aCard | 
		 aCard equals: aPermanentCardToCancel ]) ifFalse: [ 
		Error signal: 'Unable to cancel the permanent card because there is no such card in effect' ]
]

{ #category : #'adding Cards' }
CardManager >> drawCardTo: aTargetPlayerCards [

	| targetCards |
	drawDeck isEmpty ifTrue: [ self shuffleDiscardDeckIntoDrawDeck ].
	drawDeck isEmpty ifFalse: [ 
		targetCards := playerCards detect: [ :aPlayerCards | 
			               aPlayerCards equals: aTargetPlayerCards ].
		targetCards addCard: drawDeck draw ]
]

{ #category : #initialization }
CardManager >> initializeWith: somePlayersNames using: aDeck [
	
	drawDeck := aDeck.
	discardDeck := Deck with: OrderedCollection new.
	lastCardPlayed := NonPlayableCard new.
	playerCards := OrderedCollection new.
	playerCards := somePlayersNames collect: [ :aPlayerName | 
		               | aPlayerCards |
		               aPlayerCards := PlayerCards from: aPlayerName.
		               aPlayerCards addCard: drawDeck draw.
		               aPlayerCards addCard: drawDeck draw ].
]

{ #category : #accessing }
CardManager >> lastCardPlayed [
	
	^ lastCardPlayed.
]

{ #category : #'removing cards' }
CardManager >> remove: aCard from: aTargetPlayerCards [
	
	| targetCards |
	
	targetCards := playerCards detect: [:aPlayerCards | aPlayerCards equals: aTargetPlayerCards].
	targetCards removeFromHand: aCard.
]

{ #category : #'removing cards' }
CardManager >> remove: aPermanentCardToCancel to: aTargetPlayerCards [
	
	| targetCards |
	
	targetCards := playerCards detect: [:aPlayerCards | aPlayerCards equals: aTargetPlayerCards].
	targetCards removePermanent: aPermanentCardToCancel.
	self addToDiscardDeck: aPermanentCardToCancel.
]

{ #category : #'as yet unclassified' }
CardManager >> shuffleDiscardDeckIntoDrawDeck [

	drawDeck := discardDeck shuffle.
	discardDeck := Deck with: OrderedCollection new.
]

{ #category : #'card effects' }
CardManager >> updateLastCardPlayed: aCard [
			
	lastCardPlayed := aCard.
]

{ #category : #'card effects' }
CardManager >> usePermanentCardsFrom: aTargetPlayerCards [
	
	| targetHand |
	
	targetHand := playerCards detect: [:aPlayerCards | aPlayerCards equals: aTargetPlayerCards].
	^ targetHand usePermanents.
]
