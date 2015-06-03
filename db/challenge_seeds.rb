# Should ONLY contain records used in the game
Chest.create([
  {
    size: 'Large',
    color: 'Green',
    item: Item.create({name:"map",description:"its a map...", token: "$33m$13git"})
  },
  {
    size: 'Small',
    color: 'Brown',
    item: Item.create({name:"map",description:"its a map...", token: "$33m$13git"})
  }
])
