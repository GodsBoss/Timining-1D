class Recipe

	@recipeData =
		workbench:
			furnace:
				ingredients:
					rock: 9
				result:
					value: 'furnace'
			'wooden axe':
				ingredients:
					wood: 4
				result:
					value: 'wooden-axe'
			'wooden shovel':
				ingredients:
					wood: 4
				result:
					value: 'wooden-shovel'
			'wooden pickaxe':
				ingredients:
					wood: 4
				result:
					value: 'wooden-pickaxe'
			'stone axe':
				ingredients:
					wood: 1
					rock: 3
				result:
					value: 'stone-axe'
			'stone shovel':
				ingredients:
					wood: 1
					rock: 3
				result:
					value: 'stone-shovel'
			'stone pickaxe':
				ingredients:
					wood: 1
					rock: 3
				result:
					value: 'stone-pickaxe'
			'iron axe':
				ingredients:
					wood: 1
					iron: 3
				result:
					value: 'iron-axe'
			'iron shovel':
				ingredients:
					wood: 1
					iron: 3
				result:
					value: 'iron-shovel'
			'iron pickaxe':
				ingredients:
					wood: 1
					iron: 3
				result:
					value: 'iron-pickaxe'
		furnace:
			iron:
				ingredients:
					coal: 1
					'iron-ore': 1
				result:
					value: 'iron'
				time: 25
			gold:
				ingredients:
					coal: 1
					'gold-ore': 1
				result:
					value: 'gold'
				time: 45

	@recipes =
		workbench: {}
		furnace: {}

	for name, value of @recipeData.workbench
		@recipes.workbench[name] = new Recipe name, value.ingredients, value.result.value

	for name, value of @recipeData.furnace
		@recipes.furnace[name] = new Recipe name, value.ingredients, value.result.value, value.time

	constructor:(@name, @ingredients, @resultItemType, @burnTime = 0)->

	ingredientsContainedIn:(bag)->
		for name, number of @ingredients
			if !bag[name] or bag[name] < number
				return false
		true
