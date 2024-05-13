fred = AgeSchema::Nodes::Person.create(first_name: 'Fredrick Jay', nick_name: 'Fred', last_name: 'Flintstone', gender: 'male')

quarry = AgeSchema::Nodes::Company.create(company_name: 'Bedrock Quarry')

crane = AgeSchema::Edges::WorksAt.create(start_node: fred, end_node: quarry, employee_role: 'Crane Operator')

mr_slate = AgeSchema::Nodes::Person.create(first_name: 'George', nick_name: 'Mr. Slate', last_name: 'Slate', gender: 'male')

boss = AgeSchema::Edges::WorksAt.create(start_node: mr_slate, end_node: quarry, employee_role: 'Manager')


## Flintstone family
# agriculture (hillbilly)
# San Cemente Owner
zeke = AgeSchema::Nodes::Person.new(first_name: 'Zeke', last_name: 'Flintstone', gender: 'male').save
# agriculture (hillbilly)
jed = AgeSchema::Nodes::Person.new(first_name: 'Jed', last_name: 'Flintstone', gender: 'male').save

# soldier / pilot
rocky = AgeSchema::Nodes::Person.new(first_name: 'Rockbottom', nick_name: 'Rocky', last_name: 'Flintstone', gender: 'male').save

# rich uncle
giggles = AgeSchema::Nodes::Person.new(first_name: 'Jay Giggles', nick_name: 'Uncle Giggles', last_name: 'Flintstone', gender: 'male').save

# freeway traffic reporter
pops = AgeSchema::Nodes::Person.new(first_name: 'Ed Pops', nick_name: 'Pops', last_name: 'Flintstone', gender: 'male').save
# homemaker
edna = AgeSchema::Nodes::Person.new(first_name: 'Edna', last_name: 'Flintstone', given_name: 'Hardrock', gender: 'female').save

# married to wilma
# son of pops & edna (crane operator at 'Slate Rock & Gravel Company').save
fred = AgeSchema::Nodes::Person.create(first_name: 'Fredrick Jay', nick_name: 'Fred', last_name: 'Flintstone', gender: 'male')

# married to fred
# reporter & caterer & homemaker
wilma = AgeSchema::Nodes::Person.new(first_name: 'Wilma', last_name: 'Flintstone', given_name: 'Slaghoople', gender: 'female').save

# daughter of fred & wilma, married to bamm-bamm
# advertising executive
pebbles = AgeSchema::Nodes::Person.new(first_name: 'Pebbles Wilma', nick_name: 'Pebbles', last_name: 'Rubble', given_name: 'Flintstone', gender: 'female').save
# adopted brother to pebbles
stoney = AgeSchema::Nodes::Person.new(first_name: 'Stoney', last_name: 'Flintstone', gender: 'male').save


## Hardrock family
# father to Edna, Tex, Jemina (married to Lucile)
james = AgeSchema::Nodes::Person.new(first_name: 'James', last_name: 'Hardrock', gender: 'male').save
# mother to Edna, Tex, Jemina (married to James)
lucile = AgeSchema::Nodes::Person.new(first_name: 'Lucile', last_name: 'Hardrock', given_name: 'von Stone', gender: 'female').save

# sister to Tex & Edna
jemina = AgeSchema::Nodes::Person.new(first_name: 'Jemina', last_name: 'Hardrock', gender: 'female').save

# texrock rangers & rancher (town: texrock)
# brother to Edna
tex = AgeSchema::Nodes::Person.new(first_name: 'Tex', last_name: 'Hardrock', gender: 'male').save

# daughter of tex
mary = AgeSchema::Nodes::Person.new(first_name: 'Mary Lou', last_name: 'Hardrock', gender: 'female').save
# son of tex (ranch owner)
tumbleweed = AgeSchema::Nodes::Person.new(first_name: 'Tumbleweed', last_name: 'Hardrock', gender: 'male').save

## Slaghoople family
# father to Wilma, married to Pearl
ricky = AgeSchema::Nodes::Person.new(first_name: 'Richard', nick_name: 'Ricky', last_name: 'Slaghoople', gender: 'male').save
pearl = AgeSchema::Nodes::Person.new(first_name: 'Pearl', last_name: 'Slaghoople', gender: 'female').save

# wilma's sister
mica = AgeSchema::Nodes::Person.new(first_name: 'Mica', last_name: 'Slaghoople', gender: 'female').save
# wilma's sister
mickey = AgeSchema::Nodes::Person.new(first_name: 'Michael', nick_name: 'Mickey', last_name: 'Slaghoople', gender: 'female').save
# wilma's brother
michael = AgeSchema::Nodes::Person.new(first_name: 'Jerry', last_name: 'Slaghoople', gender: 'male').save

## McBricker family
brick = AgeSchema::Nodes::Person.new(first_name: 'Brick', last_name: 'McBricker', gender: 'male').save
jean = AgeSchema::Nodes::Person.new(first_name: 'Jean', last_name: 'McBricker', gender: 'female').save

# betty's bother (child of brick & jean)
# HS Basketball player
brad = AgeSchema::Nodes::Person.new(first_name: 'Brad', last_name: 'McBricker', gender: 'male').save


## Slate family
# flo's brother (lives in granite town)
# manager of 'Bedrock & Gravel Quarry Company'
mr_slate = AgeSchema::Nodes::Person.new(first_name: 'George', nick_name: 'Mr.', last_name: 'Slate', gender: 'male').save
# married to mr. slate
mrs_slate = AgeSchema::Nodes::Person.new(first_name: 'Mrs.', last_name: 'Slate', gender: 'female').save

# child of mr. slate & mrs. slate
eugene = AgeSchema::Nodes::Person.new(first_name: 'Eugene', last_name: 'Slate', gender: 'male').save
# child of mr. slate & mrs. slate
bessie = AgeSchema::Nodes::Person.new(first_name: 'Bessie', last_name: 'Slate', gender: 'female').save
# bessie's child (son)
eddie = AgeSchema::Nodes::Person.new(first_name: 'Edward', nick_name: 'Eddie', last_name: 'Slate', gender: 'male').save

## Rubble family
# married to flo
# used car salesman
bob = AgeSchema::Nodes::Person.new(first_name: 'Robert', nick_name: 'Bob', last_name: 'Rubble', gender: 'male').save
# married to bob (homemaker)
flo = AgeSchema::Nodes::Person.new(first_name: 'Florence', nick_name: 'Flo', last_name: 'Rubble', given_name: 'Slate', gender: 'female').save

# barney's brother (younger)
dusty = AgeSchema::Nodes::Person.new(first_name: 'Dusty', last_name: 'Rubble', gender: 'male').save

# married to betty (child of bob & flo)
# police officer & crane operator at 'Slate Rock & Gravel Company'
barney = AgeSchema::Nodes::Person.new(first_name: 'Bernard Matthew', nick_name: 'Barney', last_name: 'Rubble', gender: 'male').save
# married to barney, child of brick & jean
# reporter & caterer & homemaker
betty = AgeSchema::Nodes::Person.new(first_name: 'Elizabeth Jean', nick_name: 'Betty', last_name: 'Rubble', given_name: 'McBricker', gender: 'female').save

# adopted son of barney & betty (married to pebbles)
# auto mechanic, then screenwriter
bamm = AgeSchema::Nodes::Person.new(first_name: 'Bamm-Bamm', last_name: 'Rubble', gender: 'male').save
# son of bamm-bamm & pebbles
chip = AgeSchema::Nodes::Person.new(first_name: 'Charleston Frederick', nick_name: 'Chip', last_name: 'Rubble', gender: 'male').save
# daughter of bamm-bamm & pebbles
roxy = AgeSchema::Nodes::Person.new(first_name: 'Roxann Elisabeth', nick_name: 'Roxy', last_name: 'Rubble', gender: 'female').save

## The Gruesomes – A creepy but friendly family, who move in next door to the Flintstones in later seasons.
# Uncle Ghastly – The uncle of Gobby from Creepella's side of the family, who is mostly shown as a large furry hand with claws emerging from a door, a well, or a wall. His shadow was also seen in their debut episode. He wasn't named until his second appearance, which is also the only time he is heard speaking, as he is heard laughing from a well.
ghastly = AgeSchema::Nodes::Person.new(first_name: 'Ghastly', last_name: 'Gruesome', gender: 'male').save
# Weirdly Gruesome – The patriarch of the Gruesome family, who works as a reality-show host.
# reality host
weirdly = AgeSchema::Nodes::Person.new(first_name: 'Weirdly', last_name: 'Gruesome', gender: 'male').save
# Creepella Gruesome – Weirdly's tall wife.
creepella = AgeSchema::Nodes::Person.new(first_name: 'Creepella', last_name: 'Gruesome', gender: 'female').save
# Goblin "Gobby" Gruesome – Weirdly and Creepella's son.
gobby = AgeSchema::Nodes::Person.new(first_name: 'Goblin', nick_name: 'Gobby', last_name: 'Gruesome', gender: 'male').save


## The Hatrocks
# Granny Hatrock – The mother of Jethro and grandmother of Zack and Slab.
granny = AgeSchema::Nodes::Person.new(first_name: 'Granny', last_name: 'Hatrock', gender: 'female').save
# Jethro Hatrock – The patriarch of the Hatrock Family. He had brown hair in "The Hatrocks and the Flintstones" and taupe-gray hair in "The Hatrocks and the Gruesomes".
jethro = AgeSchema::Nodes::Person.new(first_name: 'Jethro', last_name: 'Hatrock', gender: 'male').save
# Gravella Hatrock – Jethro's wife.
gravella = AgeSchema::Nodes::Person.new(first_name: 'Gravella', last_name: 'Hatrock', gender: 'female').save
# Zack Hatrock – Jethro and Gravella's oldest son.
zack = AgeSchema::Nodes::Person.new(first_name: 'Zack', last_name: 'Hatrock', gender: 'male').save
# Slab Hatrock – The youngest son of Jethro and Gravella.
slab = AgeSchema::Nodes::Person.new(first_name: 'Slab', last_name: 'Hatrock', gender: 'male').save
# Benji Hatrock – Jethro's son-in-law.
benji = AgeSchema::Nodes::Person.new(first_name: 'Benji', last_name: 'Hatrock', gender: 'male').save

## others
# Friend to Barney & Fred (fire chief)
joe = AgeSchema::Nodes::Person.new(first_name: 'Joseph', nick_name: 'Joe', last_name: 'Rockhead', gender: 'male').save

# paperboy (town: bedrock)
arnold = AgeSchema::Nodes::Person.new(first_name: 'Arnold', last_name: 'Granite', gender: 'male').save

stoney = AgeSchema::Nodes::Person.new(first_name: 'Stoney', last_name: 'Curtis', gender: 'male').save
perry = AgeSchema::Nodes::Person.new(first_name: 'Perry', last_name: 'Masonry', gender: 'male').save

# Sam Slagheap – The Grand Poobah of the Water Buffalo Lodge.
sam = AgeSchema::Nodes::Person.new(first_name: 'Samuel', nick_name: 'Sam', last_name: 'Slagheap', gender: 'male').save

## Alien
########
# planet = Zetox
gazoo = AgeSchema::Nodes::Person.new(species: alien, first_name: 'The Great', last_name: 'Gazoo', gender: 'male').save
# gazoo = AgeSchema::Nodes::Person.new(species: alien, first_name: 'The Great', last_name: 'Gazoo', gender: 'male', planet: zetox)

## PETS
#######
# flintstones
dino = AgeSchema::Nodes::Pet.new(species: 'dino', pet_name: 'Dino', gender: 'male').save
pussy = AgeSchema::Nodes::Pet.new(species: 'tiger', pet_name: 'Baby Pussy', gender: 'female').save
hoppy = AgeSchema::Nodes::Pet.new(species: 'kanga', pet_name: 'Hoppy', gender: 'male').save

## Companies
############
san_cemente = AgeSchema::Nodes::Company.create(company_name: 'San Cemente')
# san_cemente = AgeSchema::Nodes::Company.new(company_name: 'San Cemente').save
bedrock_news = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Daily News').save
bedrock_police = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Police Department').save
bedrock_fire = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Fire Department').save
bedrock_quarry = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Quarry Company').save
betty_wilma_catering = AgeSchema::Nodes::Company.new(company_name: 'Betty & Wilma Catering').save
texrock_ranch = AgeSchema::Nodes::Company.new(company_name: 'Texrock Ranch').save
teradactyl = AgeSchema::Nodes::Company.new(company_name: 'Teradactyl Flights').save
auto_repair = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Auto Repair').save
used_cars = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Used Cars').save
bedrock_entetainment = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Entertainment').save
bedrock_army = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Army').save
independent = AgeSchema::Nodes::Company.new(company_name: 'Independent').save
advertising = AgeSchema::Nodes::Company.new(company_name: 'Bedrock Advertising').save
buffalo_lodge = AgeSchema::Nodes::Company.new(company_name: 'Water Buffalo Lodge').save

## Jobs
#######
## San Cemente Owner
cemente = Job.create!(role: 'owner', company: san_cemente)
# agriculture
farmer = Job.create!(role: 'farmer', company: independent)
# pilot
pilot = Job.create!(role: 'pilot', company: teradactyl)
# soldier
soldier = Job.create!(role: 'soldier', company: bedrock_army)
# wealthy
wealth = Job.create!(role: 'independently wealthy', company: independent)
# reporter
traffic = Job.create!(role: 'traffice reporter', company: bedrock_news)
reporter = Job.create!(role: 'news reporter', company: bedrock_news)
# homemaker
homemaker = Job.create!(role: 'homemaker', company: independent)
# mining company manager
manager = Job.create!(role: 'manager', company: bedrock_quarry)
# crane operator
crane = Job.create!(role: 'crane operator', company: bedrock_quarry)
# advertising executive
advertising = Job.create!(role: 'advertising executive', company: advertising)
# caterer
caterer = Job.create!(role: 'caterer', company: betty_wilma_catering)
# auto mechanic
mechanic = Job.create!(role: 'auto mechanic', company: auto_repair)
# screenwriter
screenwriter = Job.create!(role: 'screenwriter', company: bedrock_entetainment)
# police officer
police = Job.create!(role: 'police officer', company: bedrock_police)
# rancher
rancher = Job.create!(role: 'rancher', company: texrock_ranch)
# used car salesman
salesman = Job.create!(role: 'used car salesman', company: used_cars)
# reality show host
host = Job.create!(role: 'reality show host', company: bedrock_entetainment)
# fire chief
fire_chief = Job.create!(role: 'fire chief', company: bedrock_fire)
# paperboy
paper_delivery = Job.create!(role: 'paperboy', company: bedrock_news)
# Grand Poobah
grand_poobah = Job.create!(role: 'The Grand Poobah', company: buffalo_lodge)

## PersonJobs
##############
# zeke - San Cemente Owner
PersonJob.create!(person: zeke, job: cemente, start_date: Date.new(1980, 1, 1))
# jed - farmer
PersonJob.create!(person: jed, job: farmer, start_date: Date.new(1980, 1, 1))
# rocky - ww1 soldier
PersonJob.create!(person: rocky, job: soldier, start_date: Date.new(1980, 1, 1), end_date: Date.new(1985, 12, 31))
# rocy - pilot after war
PersonJob.create!(person: rocky, job: pilot, start_date: Date.new(1986, 1, 1))

# giggles rich uncle
PersonJob.create!(person: giggles, job: wealth, start_date: Date.new(1980, 1, 1))

# pops - freeway traffic reporter
PersonJob.create!(person: pops, job: traffic, start_date: Date.new(1980, 1, 1))
# edna - homemaker
PersonJob.create!(person: edna, job: homemaker, start_date: Date.new(1980, 1, 1))

# fred - crane operator
crane = PersonJob.AgeSchema::Edges::WorksAt(start_node: fred, end_node: quarry, employee_role: 'Crane Operator')
# married to fred
# wilma - reporter & caterer & homemaker
PersonJob.create!(person: wilma, job: reporter, start_date: Date.new(1980, 1, 1), end_date: Date.new(1989, 12, 31))
PersonJob.create!(person: wilma, job: caterer, start_date: Date.new(1990, 1, 1))
PersonJob.create!(person: wilma, job: homemaker, start_date: Date.new(1980, 1, 1))

# pebbles - advertising executive
PersonJob.create!(person: pebbles, job: advertising, start_date: Date.new(1995, 1, 1))

# texrock rangers & rancher (town: texrock)
PersonJob.create!(person: tex, job: rancher, start_date: Date.new(2080, 1, 1))

# mr_slate - manager
PersonJob.create!(person: mr_slate, job: manager, start_date: Date.new(1980, 1, 1))


## Rubble family
# bob - used car salesman
PersonJob.create!(person: bob, job: salesman, start_date: Date.new(1980, 1, 1))
# flo - (homemaker)
PersonJob.create!(person: flo, job: homemaker, start_date: Date.new(1980, 1, 1))

# police officer & crane operator at 'Slate Rock & Gravel Company'
PersonJob.create!(person: barney, job: police, start_date: Date.new(1980, 1, 1), end_date: Date.new(1989, 12, 31))
PersonJob.create!(person: barney, job: crane, start_date: Date.new(1990, 1, 1))

# betty - reporter & caterer & homemaker
PersonJob.create!(person: betty, job: reporter, start_date: Date.new(1980, 1, 1), end_date: Date.new(1989, 12, 31))
PersonJob.create!(person: betty, job: caterer, start_date: Date.new(1990, 1, 1))
PersonJob.create!(person: betty, job: homemaker, start_date: Date.new(1980, 1, 1))

# bamm-bamm - auto mechanic, then screenwriter
PersonJob.create!(person: bamm, job: mechanic, start_date: Date.new(1995, 1, 1), end_date: Date.new(1999, 12, 31))
PersonJob.create!(person: bamm, job: screenwriter, start_date: Date.new(2000, 1, 1))


## The Gruesomes
# weirdly - reality host
PersonJob.create!(person: weirdly, job: host, start_date: Date.new(1990, 1, 1))

## others
# joe - fire chief)
PersonJob.create!(person: joe, job: fire_chief, start_date: Date.new(1980, 1, 1))

# paperboy (town: bedrock)
PersonJob.create!(person: arnold, job: paper_delivery, start_date: Date.new(1980, 1, 1))

# Sam Slagheap – The Grand Poobah of the Water Buffalo Lodge.
PersonJob.create!(person: sam, job: grand_poobah, start_date: Date.new(1985, 1, 1))
