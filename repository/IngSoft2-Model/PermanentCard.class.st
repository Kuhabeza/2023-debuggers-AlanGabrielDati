Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#instVars : [
		'cardIsAbleToBeDiscarded'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'card playability' }
PermanentCard >> checkPlayedBy: aPlayerCards matches: currentTurnPlayerCards [

	(aPlayerCards equals: currentTurnPlayerCards) ifFalse: [ Error signal: 'Unable to play permanent card when its not your turn' ]
]

{ #category : #'as yet unclassified' }
PermanentCard >> discardInto: aGameEventManager [

	(cardIsAbleToBeDiscarded) ifTrue: [aGameEventManager discard: self].
]

{ #category : #initialization }
PermanentCard >> initialize [

	cardIsAbleToBeDiscarded := true.
]

{ #category : #'as yet unclassified' }
PermanentCard >> isAbleToBeDiscarded [

	cardIsAbleToBeDiscarded := true.
]

{ #category : #'as yet unclassified' }
PermanentCard >> isUnableToBeDiscarded [

	cardIsAbleToBeDiscarded := false.
]

{ #category : #'playing card' }
PermanentCard >> playIn: aGameEventManager from: aPlayerCards to: aTargetPlayer [

	self checkPlayedBy: aPlayerCards matches: (PlayerCards from: aGameEventManager currentTurn).
	aGameEventManager addPermanent: self to: (PlayerCards from: aTargetPlayer).
]
