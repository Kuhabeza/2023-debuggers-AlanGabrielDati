Class {
	#name : #GameEventManager,
	#superclass : #Object,
	#instVars : [
		'cardManager',
		'movementManager',
		'turnOrder',
		'diceCup'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameEventManager class >> with: aCardManager and: aMovementManager and: aTurnOrder using: aDiceCup [

	^ (self new) initializeWith: aCardManager and: aMovementManager and: aTurnOrder using: aDiceCup.
]

{ #category : #adding }
GameEventManager >> addPermanent: aPermanentCard to: aPlayerCards [ 

	cardManager addPermanent: aPermanentCard to: aPlayerCards.
]

{ #category : #adding }
GameEventManager >> addToAllPermanentPiles: aPermanentCard [

	cardManager addToAllPermanentPiles: aPermanentCard.
]

{ #category : #'applying effects' }
GameEventManager >> applyAtomicBomb [

	movementManager applyAtomicBomb.
]

{ #category : #playing }
GameEventManager >> applyEffectToCurrentTurnPlayer [

	movementManager applyEffectTo: (Ship with: turnOrder current) in: self.
]

{ #category : #'applying effects' }
GameEventManager >> applyMoonwalk: steps to: aTargetShip [

	movementManager applyMoonwalk: steps to: aTargetShip.
]

{ #category : #'applying effects' }
GameEventManager >> cancel: aTargetCard to: aTargetPlayerCards [

	| removedPermanentCard |
	cardManager checkCancel: aTargetCard to: aTargetPlayerCards.	
	removedPermanentCard := cardManager remove: aTargetCard to: aTargetPlayerCards.
	removedPermanentCard discardInto: self.
	 
]

{ #category : #validation }
GameEventManager >> checkThat: anOwner has: aCard [ 
	
	(cardManager a: anOwner has: aCard) ifFalse: [ Error signal: 'Unable to play card when the player does not own the card' ]
]

{ #category : #validation }
GameEventManager >> checkThereIsNoWinner [

	movementManager hasAWinner ifTrue: [ Error signal: 'Unable to play, Game has already finished' ]
]

{ #category : #accessing }
GameEventManager >> currentTurn [ 
	
	^ turnOrder current.
]

{ #category : #discarding }
GameEventManager >> discard: aCard [

	cardManager addToDiscardDeck: aCard.
]

{ #category : #accessing }
GameEventManager >> discardDeckSize [

	^ cardManager discardDeckSize
]

{ #category : #'adding Cards' }
GameEventManager >> drawCardTo: aTargetHand [

	cardManager drawCardTo: aTargetHand.
]

{ #category : #initialization }
GameEventManager >> initializeWith: aCardManager and: aMovementManager and: aTurnOrder using: aDiceCup [

	cardManager := aCardManager.
	movementManager := aMovementManager.
	turnOrder := aTurnOrder.
	diceCup := aDiceCup.
]

{ #category : #playing }
GameEventManager >> moveCurrentTurnPlayer: aDiceResult [
	
	| permanentCardsModifiers |
	
	permanentCardsModifiers := cardManager usePermanentCardsFrom: (PlayerCards from: turnOrder current).
	movementManager updatePosition: (aDiceResult + permanentCardsModifiers) to: (Ship with: turnOrder current).
]

{ #category : #playing }
GameEventManager >> play: aCard from: aCardOwner to: aTarget [ 
	
	| owner |
	
	aCard isAbleToBeDiscarded.
	owner := (PlayerCards from: aCardOwner).
	self checkThat: owner has: aCard.
	aCard playIn: self from: owner to: aTarget.
	self remove: aCard from: owner.
	self updateLastCardPlayed: aCard.
]

{ #category : #playing }
GameEventManager >> playTurn [

	self checkThereIsNoWinner.
	self moveCurrentTurnPlayer: diceCup throw.
	self applyEffectToCurrentTurnPlayer.
	self updateTurn.
]

{ #category : #'applying effects' }
GameEventManager >> redoLastCardPlayedFrom: aPlayerCards to: aTargetPlayer [

	(cardManager lastCardPlayed) playIn: self from: aPlayerCards to: aTargetPlayer.
]

{ #category : #removing }
GameEventManager >> remove: aCard from: aPlayersCards [
	
	cardManager remove: aCard from: aPlayersCards.
]

{ #category : #'applying effects' }
GameEventManager >> repeatLastSquareLandedTo: aTargetShip [

	(movementManager lastSquareLanded) effectTo: aTargetShip in: self.
]

{ #category : #accessing }
GameEventManager >> shipLaps [

	^ movementManager shipLaps.
]

{ #category : #accessing }
GameEventManager >> shipPositions [
	
	^ movementManager shipPositions.
]

{ #category : #'game status' }
GameEventManager >> shipRanking [

	^ movementManager shipRanking.
]

{ #category : #'applying effects' }
GameEventManager >> sprintTo: aTargetPlayer [

	| steps |
	steps := cardManager amountOfCardsFrom: aTargetPlayer.
	movementManager updatePosition: steps to: aTargetPlayer.
]

{ #category : #playing }
GameEventManager >> updateLastCardPlayed: aCard [

	cardManager updateLastCardPlayed: aCard.
]

{ #category : #playing }
GameEventManager >> updateParsecs: parsecSteps to: aTargetShip [

	movementManager updateParsecs: parsecSteps to: aTargetShip.
]

{ #category : #playing }
GameEventManager >> updatePosition: steps to: aTargetShip [

	movementManager updatePosition: steps to: aTargetShip.
]

{ #category : #playing }
GameEventManager >> updateTurn [

	turnOrder next.
]

{ #category : #'game status' }
GameEventManager >> winner [

	^ movementManager winner.
]
