class SpriteMap
	@sprites =
		dirt:
			x: 0
			y: 0
			w: 16
			h: 16
		grass:
			x: 16
			y: 0
			w: 16
			h: 16
		tree3:
			x: 32
			y: 0
			w: 16
			h: 16
		bush0:
			x: 48
			y: 0
			w: 16
			h: 16
		bush1:
			x: 64
			y: 0
			w: 16
			h: 16
		bush2:
			x: 80
			y: 0
			w: 16
			h: 16
		bush3:
			x: 96
			y: 0
			w: 16
			h: 16
		'dirt-flat':
			x: 112
			y: 0
			w: 16
			h: 16
		tree1:
			x: 128
			y: 0
			w: 16
			h: 16
		tree2:
			x: 144
			y: 0
			w: 16
			h: 16
		'dirt-border-left':
			x: 160
			y: 0
			w: 16
			h: 16
		'dirt-border-right':
			x: 176
			y: 0
			w: 16
			h: 16
		'dirt-border-both':
			x: 192
			y: 0
			w: 16
			h: 16
		rock:
			x:0
			y: 16
			w: 16
			h: 16
		'rock-coal':
			x: 16
			y: 16
			w: 16
			h: 16
		'rock-iron':
			x: 32
			y: 16
			w: 16
			h: 16
		'rock-gold':
			x: 48
			y: 16
			w: 16
			h: 16
		'rock-diamond':
			x: 64
			y: 16
			w: 16
			h: 16
		'rock-flat':
			x: 80
			y: 16
			w: 16
			h: 16
		'rock-border-left':
			x: 96
			y: 16
			w: 16
			h: 16
		'rock-border-right':
			x: 112
			y: 16
			w: 16
			h: 16
		'rock-border-both':
			x: 128
			y: 16
			w: 16
			h: 16
		'item-rock':
			x: 0
			y: 32
			w: 8
			h: 8
		'item-coal':
			x: 8
			y: 32
			w: 8
			h: 8
		'item-gold-ore':
			x: 16
			y: 32
			w: 8
			h: 8
		'item-paper':
			x: 24
			y: 32
			w: 8
			h: 8
		'item-gold':
			x: 32
			y: 32
			w: 8
			h: 8
		'item-sapling':
			x: 40
			y: 32
			w: 8
			h: 8
		'item-apple':
			x: 0
			y: 40
			w: 8
			h: 8
		'item-iron-ore':
			x: 8
			y: 40
			w: 8
			h: 8
		'item-diamond':
			x: 16
			y: 40
			w: 8
			h: 8
		'item-wood':
			x: 24
			y: 40
			w: 8
			h: 8
		'item-iron':
			x: 32
			y: 40
			w: 8
			h: 8
		'recipe-wooden-axe':
			x: 80
			y: 32
			w: 16
			h: 16
		'recipe-wooden-shovel':
			x: 96
			y: 32
			w: 16
			h: 16
		'recipe-wooden-pickaxe':
			x: 112
			y: 32
			w: 16
			h: 16
		'recipe-stone-axe':
			x: 128
			y: 32
			w: 16
			h: 16
		'recipe-stone-shovel':
			x: 144
			y: 32
			w: 16
			h: 16
		'recipe-stone-pickaxe':
			x: 160
			y: 32
			w: 16
			h: 16
		'recipe-iron-axe':
			x: 176
			y: 32
			w: 16
			h: 16
		'recipe-iron-shovel':
			x: 192
			y: 32
			w: 16
			h: 16
		'recipe-iron-pickaxe':
			x: 208
			y: 32
			w: 16
			h: 16
		heart4:
			x: 0
			y: 48
			w: 8
			h: 8
		heart3:
			x: 0
			y: 56
			w: 8
			h: 8
		heart2:
			x: 8
			y: 56
			w: 8
			h: 8
		heart1:
			x: 8
			y: 48
			w: 8
			h: 8
		heart0:
			x: 16
			y: 48
			w: 8
			h: 8
		saturation0:
			x: 24
			y: 48
			w: 8
			h: 8
		saturation1:
			x: 24
			y: 56
			w: 8
			h: 8
		saturation2:
			x: 16
			y: 56
			w: 8
			h: 8
		clock0:
			x: 32
			y: 48
			w: 8
			h: 8
		clock1:
			x: 32
			y: 56
			w: 8
			h: 8
		clock2:
			x: 40
			y: 48
			w: 8
			h: 8
		clock3:
			x: 40
			y: 56
			w: 8
			h: 8
		clock4:
			x: 48
			y: 48
			w: 8
			h: 8
		clock5:
			x: 48
			y: 56
			w: 8
			h: 8
		clock6:
			x: 56
			y: 48
			w: 8
			h: 8
		clock7:
			x: 56
			y: 56
			w: 8
			h: 8
		workbench:
			x: 0
			y: 64
			w: 16
			h: 16
		furnace:
			x: 16
			y: 64
			w: 16
			h: 16
		furnace_0:
			x: 32
			y: 64
			w: 16
			h: 16
		furnace_1:
			x: 48
			y: 64
			w: 16
			h: 16
		furnace_2:
			x: 64
			y: 64
			w: 16
			h: 16
		furnace_3:
			x: 80
			y: 64
			w: 16
			h: 16
		'player-a-right_0':
			x: 0
			y: 80
			w: 16
			h: 16
		'player-a-right_1':
			x: 0
			y: 96
			w: 16
			h: 16
		'player-a-left_0':
			x: 16
			y: 80
			w: 16
			h: 16
		'player-a-left_1':
			x: 16
			y: 96
			w: 16
			h: 16
		'player-b-right_0':
			x: 32
			y: 80
			w: 16
			h: 16
		'player-b-right_1':
			x: 32
			y: 96
			w: 16
			h: 16
		'player-b-left_0':
			x: 48
			y: 80
			w: 16
			h: 16
		'player-b-left_1':
			x: 48
			y: 96
			w: 16
			h: 16
		'zombie-right_0':
			x: 64
			y: 80
			w: 16
			h: 16
		'zombie-right_1':
			x: 64
			y: 96
			w: 16
			h: 16
		'zombie-left_0':
			x: 80
			y: 80
			w: 16
			h: 16
		'zombie-left_1':
			x: 80
			y: 96
			w: 16
			h: 16
		'axe-wood-left':
			x: 96
			y: 80
			w: 16
			h: 16
		'axe-wood-right':
			x: 96
			y: 96
			w: 16
			h: 16
		'shovel-wood-left':
			x: 112
			y: 80
			w: 16
			h: 16
		'shovel-wood-right':
			x: 112
			y: 96
			w: 16
			h: 16
		'pickaxe-wood-left':
			x: 128
			y: 80
			w: 16
			h: 16
		'pickaxe-wood-right':
			x: 128
			y: 96
			w: 16
			h: 16
		'axe-stone-left':
			x: 144
			y: 80
			w: 16
			h: 16
		'axe-stone-right':
			x: 144
			y: 96
			w: 16
			h: 16
		'shovel-stone-left':
			x: 160
			y: 80
			w: 16
			h: 16
		'shovel-stone-right':
			x: 160
			y: 96
			w: 16
			h: 16
		'pickaxe-stone-left':
			x: 176
			y: 80
			w: 16
			h: 16
		'pickaxe-stone-right':
			x: 176
			y: 96
			w: 16
			h: 16
		'axe-iron-left':
			x: 192
			y: 80
			w: 16
			h: 16
		'axe-iron-right':
			x: 192
			y: 96
			w: 16
			h: 16
		'shovel-iron-left':
			x: 208
			y: 80
			w: 16
			h: 16
		'shovel-iron-right':
			x: 208
			y: 96
			w: 16
			h: 16
		'pickaxe-iron-left':
			x: 224
			y: 80
			w: 16
			h: 16
		'pickaxe-iron-right':
			x: 224
			y: 96
			w: 16
			h: 16
		'hit-effect-left':
			x: 240
			y: 80
			w: 16
			h: 16
		'hit-effect-right':
			x: 240
			y: 96
			w: 16
			h: 16
		'menu-start':
			x: 480
			y: 0
			w: 32
			h: 32
		'menu-again':
			x: 480
			y: 32
			w: 32
			h: 32
		'menu-pause':
			x: 480
			y: 64
			w: 32
			h: 32
		'menu-empty':
			x: 480
			y: 96
			w: 32
			h: 32
		'a':
			x: 0
			y: 112
			w: 8
			h: 8
		'b':
			x: 8
			y: 112
			w: 8
			h: 8
		'c':
			x: 16
			y: 112
			w: 8
			h: 8
		'd':
			x: 24
			y: 112
			w: 8
			h: 8
		'e':
			x: 32
			y: 112
			w: 8
			h: 8
		'f':
			x: 40
			y: 112
			w: 8
			h: 8
		'g':
			x: 48
			y: 112
			w: 8
			h: 8
		'h':
			x: 56
			y: 112
			w: 8
			h: 8
		'i':
			x: 64
			y: 112
			w: 8
			h: 8
		'j':
			x: 72
			y: 112
			w: 8
			h: 8
		'k':
			x: 80
			y: 112
			w: 8
			h: 8
		'l':
			x: 88
			y: 112
			w: 8
			h: 8
		'm':
			x: 96
			y: 112
			w: 8
			h: 8
		'n':
			x: 104
			y: 112
			w: 8
			h: 8
		'o':
			x: 112
			y: 112
			w: 8
			h: 8
		'p':
			x: 120
			y: 112
			w: 8
			h: 8
		'q':
			x: 128
			y: 112
			w: 8
			h: 8
		'r':
			x: 136
			y: 112
			w: 8
			h: 8
		's':
			x: 144
			y: 112
			w: 8
			h: 8
		't':
			x: 152
			y: 112
			w: 8
			h: 8
		'u':
			x: 160
			y: 112
			w: 8
			h: 8
		'v':
			x: 168
			y: 112
			w: 8
			h: 8
		'w':
			x: 176
			y: 112
			w: 8
			h: 8
		'x':
			x: 184
			y: 112
			w: 8
			h: 8
		'y':
			x: 192
			y: 112
			w: 8192
			h: 8
		'z':
			x: 200
			y: 112
			w: 8
			h: 8
		'1':
			x: 0
			y: 120
			w: 8
			h: 8
		'2':
			x: 8
			y: 120
			w: 8
			h: 8
		'3':
			x: 16
			y: 120
			w: 8
			h: 8
		'4':
			x: 24
			y: 120
			w: 8
			h: 8
		'5':
			x: 32
			y: 120
			w: 8
			h: 8
		'6':
			x: 40
			y: 120
			w: 8
			h: 8
		'7':
			x: 48
			y: 120
			w: 8
			h: 8
		'8':
			x: 56
			y: 120
			w: 8
			h: 8
		'9':
			x: 64
			y: 120
			w: 8
			h: 8
		'0':
			x: 72
			y: 120
			w: 8
			h: 8
		'fog-left':
			x: 0
			y: 128
			w: 16
			h: 16
		'fog-right':
			x: 16
			y: 128
			w: 16
			h: 16
		'fog-full':
			x: 32
			y: 128
			w: 16
			h: 16
		'exit':
			x: 0
			y: 144
			w: 16
			h: 16

	getSpriteInfo:(name)->
		SpriteMap.sprites[name]
