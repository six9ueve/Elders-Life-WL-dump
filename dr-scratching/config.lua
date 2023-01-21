Config = {}
Config.Locale = 'en'

 -- You don't have to sum to sum the chances of all of the prices to 100. The totel will be decided based on the
 -- <chance of one price>/<total of all prices>. e.g. Price: 'Common' has a chance of '50' and the total of all chances is 100, so 50/100 (50%)
 -- chance of packing common. You may add as many prices as you want. Follow the preset logic.
 Config.Prices = {
  Nothing = {
    chance = 40,
    message = '~c~Désolé le ticket est perdant...~s~',
    price = {
      price_money = 0,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Common = {
    chance = 30,
    message = '~g~Vous avez gagné un autre ticket à gratter?',
    price = {
      price_money = 0,
      item = {
        price_is_item = true,
        item_name = 'coffre',
        item_label = 'Ticket à gratter',
        item_amount = 1
      }
    }
  },
  Common = {
    chance = 30,
    message = '~g~Vous avez gagné un autre ticket à gratter?',
    price = {
      price_money = 0,
      item = {
        price_is_item = true,
        item_name = 'coffre',
        item_label = 'Ticket à gratter',
        item_amount = 1
      }
    }
  },
  Rare1222= {
    chance = 25,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$50~s~!',
    price = {
      price_money = 50,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Rare122 = {
    chance = 24,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$100~s~!',
    price = {
      price_money = 100,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Rare12 = {
    chance = 23,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$150~s~!',
    price = {
      price_money = 150,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Rare = {
    chance = 22,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$200~s~!',
    price = {
      price_money = 200,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Rare1 = {
    chance = 21,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$250~s~!',
    price = {
      price_money = 250,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic222 = {
    chance = 20,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$300~s~!',
    price = {
      price_money = 300,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic = {
    chance = 18,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$400~s~!',
    price = {
      price_money = 400,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic3 = {
    chance = 14,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$500~s~!',
    price = {
      price_money = 500,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic2 = {
    chance = 10,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$600~s~!',
    price = {
      price_money = 600,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Epic1 = {
    chance = 6,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$750~s~!',
    price = {
      price_money = 750,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  },
  Legendary = {
    chance = 2,
    message = '~g~Vous avez gagné!~s~ Vous remportez la somme de ~g~$1000~s~!',
    price = {
      price_money = 1000,
      item = {
        price_is_item = false,
        item_name = '',
        item_label = '',
        item_amount = 1
      }
    }
  }
}

Config.Webhooks = {
  webhooksEnabled = true, -- enable/disable webhooks. Place your 'Discord WEBHOOK URL' in server/s_webhooks.lua:1
  logProperties = {
    possibleCheatingAttempt = true, -- will trigger on possible cheating attempt
    winMessages = true, -- will trigger on win (both money and item)
    loseMessages = false, -- will trigger on lose
    earlyMessage = false -- will trigger if person doesn't fully scratch ticket
  },
}

Config.ScratchCooldownInSeconds = 10 -- Cooldown in SECONDS, when will player be able to scratch another ticket?
Config.ShowCooldownNotifications = true -- Show a notification to player with the remaining cooldown timer
Config.ShowUsedTicketNotification = true  -- Show a notification to player whenever a ticket is used
Config.ShowResultTicketNotification = true  -- Show a notification with message of price ticket. See Config.Prices.message
Config.ScratchAmount = 80    -- Percentage of the ticket that needs to be scrapped away for the price to be 'seen'