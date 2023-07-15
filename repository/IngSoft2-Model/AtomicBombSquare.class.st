Class {
	#name : #AtomicBombSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBombSquare >> effectTo: aTargetShip in: aGameEventManager [

	aGameEventManager applyAtomicBomb.
]
