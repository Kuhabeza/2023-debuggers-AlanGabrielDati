Class {
	#name : #CardSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CardSquare >> effectTo: aTargetHand in: aGameEventManager [ 
	
	aGameEventManager drawCardTo: aTargetHand.
]
