class WorkbenchRecipeAction
	constructor:(@recipe, @player)->
		@name = @recipe.resultItemType

	action:()=>
		@player.consumeMany @recipe.ingredients
		@player.gatherItem
			type: @recipe.resultItemType
