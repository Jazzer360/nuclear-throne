# Every 15s poll api

# Update timestamp-indexed mapping with returned previous run

# set current run to result from api call for displaying the current run

# update displayed page based on recomputed info

# Page display
# Current Run
# Last N runs
# Best N runs (level reached, enemies killed, etc)

### Data stream handling ###

stream_url = 'https://tb-api.xyz/stream/get'
params = 
  s: '76561197966479698'
  key: 'BCFJMRTW6'

runs = {}

add_run_data = (data) ->
  if data
    if data.world >= 100
      data.secret = data.world
      data.world = runs[data.timestamp].world
      data.level = runs[data.timestamp].level + 1
    runs[data.timestamp] = data

update = ->
  $.getJSON stream_url, params, on_update

on_update = (data) ->
  add_run_data data.previous
  add_run_data data.current

  update_view()
  console.log runs
  setTimeout update, 5000

update()


### Display functions ###

$curr = $('#current-run')

update_view = ->
  runids = Object.keys(runs)
  curr = runs[Math.max runids...]
  if not curr
    return
  $curr.find('.char').text chars[curr.char]
  $curr.find('.kills').text curr.kills
  if curr.secret
    $curr.find('.world').text worlds[curr.secret]
    $curr.find('.level').text ''
  else
    $curr.find('.world').text worlds[curr.world]
    $curr.find('.level').text curr.level
  $curr.find('.loops').text curr.loops
  $curr.find('.health').text curr.health
  if curr.lasthit is -1
    $curr.find('.lasthit').text ''
  else
    $curr.find('.lasthit').text enemies[curr.lasthit]
  $curr.find('.crown').text crowns[curr.crown]
  $curr.find('.weapon1').text weapons[curr.wepA]
  $curr.find('.weapon2').text weapons[curr.wepB]
  $mutations = $curr.find('.mutation-list')
  $mutations.empty()
  for mutation in get_mutations curr
    $mutations.append('<li>' + mutation + '</li>')

get_mutations = (run) ->
  mutations = []
  for flag, i in run.mutations
    if flag is '1'
      mutations.push muts[i]
  return mutations


### Game data ###

chars = 
  ['', 'Fish', 'Crystal', 'Eyes', 'Melting', 'Plant',
   'Y.V.', 'Steroids', 'Robot', 'Chicken', 'Rebel',
   'Horror', 'Rogue', 'Skeleton', 'Frog']

muts = 
  ['Heavy Heart', 'Rhino Skin', 'Extra Feet', 'Plutonium Hunger',
   'Rabbit Paw', 'Throne Butt', 'Lucky Shot', 'Bloodlust',
   'Gamma Guts', 'Second Stomach', 'Back Muscle', 'Scarier Face',
   'Euphoria', 'Long Arms', 'Boiling Veins', 'Shotgun Shoulders',
   'Recycle Gland', 'Laser Brain', 'Last Wish', 'Eagle Eyes',
   'Impact Wrists', 'Bolt Marrow', 'Stress', 'Trigger Fingers',
   'Sharp Teeth', 'Patience', 'Hammerhead', 'Strong Spirit',
   'Open Mind']

worlds =
  0: 'Campfire', 1: 'Desert', 2: 'Sewers', 3: 'Scrapyard',
  4: 'Crystal Caves', 5: 'Frozen City', 6: 'Labs', 7: 'The Palace',
  100: 'Crown Vault', 101: 'Oasis', 102: 'Pizza Sewers', 103: 'Y.V\'s Mansion',
  104: 'Cursed Crystal Caves', 105: 'Jungle', 107: 'Y.V\'s Crib', 106: 'I.D.P.D. Headquarters'

weapons =
  ['', 'Revolver', 'Triple Machinegun', 'Wrench', 'Machinegun', 'Shotgun',
   'Crossbow', 'Grenade Launcher', 'Double Shotgun', 'Minigun', 'Auto Shotgun',
   'Auto Crossbow', 'Super Crossbow', 'Shovel', 'Bazooka', 'Sticky Launcher',
   'SMG', 'Assault Rifle', 'Disc Gun', 'Laser Pistol', 'Laser Rifle', 'Slugger',
   'Gatling Slugger', 'Assault Slugger', 'Energy Sword', 'Super Slugger',
   'Hyper Rifle', 'Screwdriver', 'Laser Minigun', 'Blood Launcher', 'Splinter Gun',
   'Toxic Bow', 'Sentry Gun', 'Wave Gun', 'Plasma Gun', 'Plasma Cannon',
   'Energy Hammer', 'Jackhammer', 'Flak Cannon', 'Golden Revolver', 'Golden Wrench',
   'Golden Machinegun', 'Golden Shotgun', 'Golden Crossbow', 'Golden Grenade Launcer',
   'Golden Laser Pistol', 'Chicken Sword', 'Nuke Launcher', 'Ion Cannon',
   'Quadruple Machinegun', 'Flamethrower', 'Dragon', 'Flare Gun', 'Energy Screwdriver',
   'Hyper Launcher', 'Laser Cannon', 'Rusty Revolver', 'Lightning Pistol',
   'Lightning Rifle', 'Lightning Shotgun', 'Super Flak Cannon', 'Sawed-off Shotgun',
   'Splinter Pistol', 'Super Splinter Gun', 'Lighting SMG', 'Smart Gun',
   'Heavy Crossbow', 'Blood Hammer', 'Lightning Cannon', 'Pop Gun',
   'Plasma Rifle', 'Pop Rifle', 'Toxic Launcher', 'Flame Cannon', 'Lightning Hammer',
   'Flame Shotgun', 'Double Flame Shotgun', 'Auto Flame Shotgun', 'Cluster Launcher',
   'Grenade Shotgun', 'Grenade Rifle', 'Rogue Rifle', 'Party Gun', 'Double Minigun',
   'Gatling Bazooka', 'Auto Grenade Shotgun', 'Ultra Revolver', 'Ultra Laser Pistol',
   'Sledgehammer', 'Heavy Revolver', 'Heavy Machinegun', 'Heavy Slugger',
   'Ultra Shovel', 'Ultra Shotgun', 'Ultra Crossbow', 'Ultra Grenade Launcher',
   'Plasma Minigun', 'Devastator', 'Golden Plasma Gun', 'Golden Slugger',
   'Golden Splinter Gun', 'Golden Screwdriver', 'Golden Bazooka',
   'Golden Assault Rifle', 'Super Disc Gun', 'Heavy Auto Crossbow',
   'Heavy Assault Rifle', 'Blood Cannon', 'Dog Spin Attack', 'Dog Missile',
   'Incinerator', 'Super Plasma Cannon', 'Seeker Pistol', 'Seeker Shotgun',
   'Eraser', 'Guitar', 'Bouncer SMG', 'Bouncer Shotgun', 'Hyper Slugger',
   'Super Bazooka', 'Frog Pistol', 'Black Sword', 'Golden Nuke Launcher',
   'Golden Disc Gun', 'Heavy Grenade Launcher', 'Gun Gun', 'Golden Frog Pistol']

enemies = 
  ['Bandit', 'Maggot', 'Rad Maggot', 'Big Maggot', 'Scorpion', 'Gold Scorpion',
   'Big Bandit', 'Rat', 'Rat King', 'Green Rat', 'Gator', 'Exploder', 'Toxic Frog',
   'Mom', 'Assassin', 'Raven', 'Salamander', 'Sniper', 'Big Dog', 'Spider', '',
   'Laser Crystal', 'Hyper Crystal', 'Snow Bandit', 'Snowbot', 'Wolf', 'Snowtank',
   'Lil Hunter', 'Freak', 'Explo Freak', 'Rhino Freak', 'Necromancer', 'Turret',
   'Technomancer', 'Guardian', 'Explo Guardian', 'Dog Guardian', 'Throne',
   'Throne II', 'Bone Fish', 'Crab', 'Turtle', 'Venus Grunt', 'Venus Sarge',
   'Fireballer', 'Super Fireballer', 'Jock', 'Cursed Spider', 'Cursed Crystal',
   'Mimic', 'Health Mimic', 'Grunt', 'Inspector', 'Shielder', 'Crown Guardian',
   'Explosion', 'Small Explosion', 'Fire Trap', 'Shield', 'Toxin', 'Horror',
   'Barrel', 'Toxic Barrel', 'Golden Barrel', 'Car', 'Venus Car', 'Venus Car Fixed',
   'Venuz Car 2', 'Icy Car', 'Thrown Car', 'Mine', 'Crown of Death', 'Rogue Strike',
   'Blood Launcher', 'Blood Cannon', 'Blood Hammer', 'Disc', 'Curse Eat',
   'Big Dog Missile', 'Halloween Bandit', 'Lil Hunter Fly', 'Throne Death',
   'Jungle Bandit', 'Jungle Assassin', 'Jungle Fly', 'Crown of Hatred', 'Ice Flower',
   'Cursed Ammo Pickup', 'Underwater Lightning', 'Elite Grunt', 'Blood Gamble',
   'Elite Shielder', 'Elite Inspector', 'Captain', 'Van', 'Buff Gator', 'Generator',
   'Lightning Crystal', 'Golden Snowtank', 'Green Explosion', 'Small Generator',
   'Golden Disc', 'Big Dog Explosion', 'IDPD Freak', 'Throne II Death', '']

crowns =
  ['', '', 'Crown of Death', 'Crown of Life', 'Crown of Haste',
   'Crown of Guns', 'Crown of Hatred', 'Crown of Blood', 'Crown of Destiny',
   'Crown of Love', 'Crown of Risk', 'Crown of Curses', 'Crown of Luck',
   'Crown of Protection']
