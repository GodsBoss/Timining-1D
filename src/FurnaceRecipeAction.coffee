class FurnaceRecipeAction
	constructor:(@recipe, @player, @furnace)->
		@name = @recipe.resultItemType

	action:()=>
		@player.consumeMany @recipe.ingredients
		@furnace.melt @recipe
