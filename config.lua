Config = {}

Config.Scaleitem = 'weight_scale'

Config.animtion = {
	animDict = 'amb@prop_human_bum_bin@base',
	anim = "base",
}

Config.Items = {
	{
		name = 'coke',
		label = 'Coke',
		amountneeded = 1,
		outputitems = {
			{
				label = '30oz Bag',
				requireitem = '30oz_plastic_bag',
				rewarditem = '30oz_coke'
			},
			{
				label = '60oz Bag',
				requireitem = '60oz_plastic_bag',
				rewarditem = '60oz_coke'
			},
			{
				label = '90oz Bag',
				requireitem = '90oz_plastic_bag',
				rewarditem = '90oz_coke'
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
				rewarditem = '30oz_weed'
			},
			{
				label = '60oz Bag',
				requireitem = '60oz_plastic_bag',
				rewarditem = '60oz_weed'
			},
			{
				label = '90oz Bag',
				requireitem = '90oz_plastic_bag',
				rewarditem = '90oz_weed'
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
				rewarditem = '30oz_meth'
			},
			{
				label = '60oz Bag',
				requireitem = '60oz_plastic_bag',
				rewarditem = '60oz_meth'
			},
			{
				label = '90oz Bag',
				requireitem = '90oz_plastic_bag',
				rewarditem = '90oz_meth'
			},
		}
	}
}
