# Should ONLY contain records used in the game
Chest.create([
  {
    size: 'Large',
    color: 'Green',
    key_slot: Digest::SHA1::hexdigest(KeyCard.create(blade: SecureRandom.uuid.gsub('-','').upcase).blade),
    item: Item.create({name:"map",description:"its a map...", token: "$33m$13git"})
  },
  {
    size: 'Small',
    color: 'Purple',
    key_slot: Digest::SHA1::hexdigest(KeyCard.create(blade: SecureRandom.uuid.gsub('-','').upcase).blade),
    item: nil
  },
  {
    size: 'Medium',
    color: 'Brown',
    key_slot: Digest::SHA1::hexdigest(KeyCard.create(blade: SecureRandom.uuid.gsub('-','').upcase).blade),
    item: Item.create({name:"map",description:"its a map...", token: "$33m$13git"})
  }
])
