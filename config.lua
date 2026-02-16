Config = {}

Config.Scaleitem = 'weight_scale'

Config.animation = {
	animDict = 'amb@prop_human_bum_bin@base',
	anim = 'base',
}

-- Backward compatibility for older config key.
Config.animtion = Config.animation

Config.Inventory = 'ox_inventory' -- ox_inventory | qb-inventory

Config.Items = {
	{
		name = 'coke',
		label = 'Coke',
		amountneeded = 1,
		outputitems = {
			{
				label = '30oz Bag',
				requireitem = '30oz_plastic_bag',
				rewarditem = {
					{
						name = '30oz_coke',
						amount = 1
					}
				}
			},
			{
				label = '60oz Bag',
				requireitem = '60oz_plastic_bag',
				rewarditem = {
					{
						name = '60oz_coke',
						amount = 1
					}
				}
			},
			{
				label = '90oz Bag',
				requireitem = '90oz_plastic_bag',
				rewarditem = {
					{
						name = '90oz_coke',
						amount = 1
					}
				}
			},
		}
	},
	{
		name = 'weed',
		label = 'Weed',
		amountneeded = 1,
		outputitems = {
			{
				label = '30oz Bag',
				requireitem = '30oz_plastic_bag',
				rewarditem = {
					{
						name = '30oz_weed',
						amount = 1
					}
				}
			},
			{
				label = '60oz Bag',
				requireitem = '60oz_plastic_bag',
				rewarditem = {
					{
						name = '60oz_weed',
						amount = 1
					}
				}
			},
			{
				label = '90oz Bag',
				requireitem = '90oz_plastic_bag',
				rewarditem = {
					{
						name = '90oz_weed',
						amount = 1
					}
				}
			},
		}
	},
	{
		name = 'meth',
		label = 'Meth',
		amountneeded = 1,
		outputitems = {
			{
				label = '30oz Bag',
				requireitem = '30oz_plastic_bag',
				rewarditem = {
					{
						name = '30oz_meth',
						amount = 1
					}
				}
			},
			{
				label = '60oz Bag',
				requireitem = '60oz_plastic_bag',
				rewarditem = {
					{
						name = '60oz_meth',
						amount = 1
					}
				}
			},
			{
				label = '90oz Bag',
				requireitem = '90oz_plastic_bag',
				rewarditem = {
					{
						name = '90oz_meth',
						amount = 1
					}
				}
			},
		}
	}
}
