Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SpeedUpSquare >> effectTo: aTargetShip in: aGameEventManager [

	aGameEventManager updatePosition: 4 to: aTargetShip.
]
