class Recipe
	@SPECIAL = 'special'
	@ITEM = 'item'

	@recipes =
		direct:
			workbench:
				ingredients:
					wood: 4
				result:
					type: @SPECIAL
					value: 'workbench'
			tree:
				ingredients:
					sapling: 1
				result:
					type: @SPECIAL
					value: 'tree'
		workbench:
			furnace:
				ingredients:
					stone: 4
				result:
					type: @ITEM
					value: 'furnace'
			'wooden axe':
				ingredients:
					wood: 4
				result:
					type: @ITEM
					value: 'wooden-axe'
			'wooden shovel':
				ingredients:
					wood: 4
				result:
					type: @ITEM
					value: 'wooden-shovel'
			'wooden pickaxe':
				ingredients:
					wood: 4
				result:
					type: @ITEM
					value: 'wooden-pickaxe'
			'stone axe':
				ingredients:
					wood: 1
					stone: 3
				result:
					type: @ITEM
					value: 'stone-axe'
			'stone shovel':
				ingredients:
					wood: 1
					stone: 3
				result:
					type: @ITEM
					value: 'stone-shovel'
			'stone pickaxe':
				ingredients:
					wood: 1
					stone: 3
				result:
					type: @ITEM
					value: 'stone-pickaxe'
			'iron axe':
				ingredients:
					wood: 1
					iron: 3
				result:
					type: @ITEM
					value: 'iron-axe'
			'iron shovel':
				ingredients:
					wood: 1
					iron: 3
				result:
					type: @ITEM
					value: 'iron-shovel'
			'iron pickaxe':
				ingredients:
					wood: 1
					iron: 3
				result:
					type: @ITEM
					value: 'iron-pickaxe'
		furnace:
			iron:
				ingredients:
					coal: 1
					'iron-ore': 1
				result:
					type: @ITEM
					value: 'iron'
				time: 30
			gold:
				ingredients:
					coal: 1
					'gold-ore': 1
				result:
					type: @ITEM
					value: gold
				time: 45

	checkRecipeIngredients:(recipe, bag)->
		for name, number of recipe.ingredients
			if !bag[name] or bag[name] < number
				return false
		true
