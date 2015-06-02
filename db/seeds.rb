# Should ONLY contain records used in references or in the game
Chest.create([
  {
    size: 'Large',
    color: 'Yellow',
    item: Item.create({name:"map",description:"its a map...", token: "$33m$13git"})
  },
  {
    size: 'Small',
    color: 'Orange',
    item: Item.create({name:"map",description:"its a map...", token: "$33m$13git"})
  }
])
