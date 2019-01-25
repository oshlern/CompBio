import random

hetero, d_homo, r_homo = 0, 0, 0
n = 100

first_names = ["Liam", "Emma", "Noah", "Olivia", "William", "Ava", "James", "Isabella", "Logan", "Sophia", "Benjamin", "Mia", "Mason", "Charlotte", "Elijah", "Amelia", "Oliver", "Evelyn", "Jacob", "Abigail", "Lucas", "Harper", "Michael", "Emily", "Alexander", "Elizabeth", "Ethan", "Avery", "Daniel", "Sofia", "Matthew", "Ella", "Aiden", "Madison", "Henry", "Scarlett", "Joseph", "Victoria", "Jackson", "Aria", "Samuel", "Grace", "Sebastian", "Chloe", "David", "Camila", "Carter", "Penelope", "Wyatt", "Riley", "Jayden", "Layla", "John", "Lillian", "Owen", "Nora", "Dylan", "Zoey", "Luke", "Mila", "Gabriel", "Aubrey", "Anthony", "Hannah", "Isaac", "Lily", "Grayson", "Addison", "Jack", "Eleanor", "Julian", "Natalie", "Levi", "Luna", "Christopher", "Savannah", "Joshua", "Brooklyn", "Andrew", "Leah", "Lincoln", "Zoe", "Mateo", "Stella", "Ryan", "Hazel", "Jaxon", "Ellie", "Nathan", "Paisley", "Aaron", "Audrey", "Isaiah", "Skylar", "Thomas", "Violet", "Charles", "Claire", "Caleb", "Bella", "Josiah", "Aurora", "Christian", "Lucy", "Hunter", "Anna", "Eli", "Samantha", "Jonathan", "Caroline", "Connor", "Genesis", "Landon", "Aaliyah", "Adrian", "Kennedy", "Asher", "Kinsley", "Cameron", "Allison", "Leo", "Maya", "Theodore", "Sarah"]
last_names = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes"]

people = []
gene_list = ["A", "B", "C", "D"]#, "E", "F"]

class Allele(Object):
    def __init__(dominant, name=""):
        self.dominant = dominant
        self.recessive = not dominant
        self.name = name

class Gene(Object):
    def __init__(allele1, allele2, name=""):
        self.allele1 = allele1
        self.allele2 = allele2
        self.alleles = [allele1, allele2]
        if self.allele1.dominant:
            if self.allele2.dominant:
                self.zygous = "homo_d"
            else: 
                self.zygous = "hetero"
        elif self.allele2.dominant:
                self.zygous = "hetero"
        else:
            self.zygous = "homo_r"

class Person(Object):
    def __init__(genes, first_name="", last_name=""):
        self.genes = genes
        self.first_name = first_name
        self.last_name = last_name

def gene_birth(gene1, gene2):
    return Gene(random.choice(gene1.alleles), random.choice(gene2.alleles))

def birth(p1, p2):
    last_name = random.choice(p1.last_name, p2.last_name)
    first_name = random.choice(first_names)
    genes = [gene_birth(p1.genes[i], p2.genes[i]) for i in range(min(len(p1.genes), len(p2.genes)))]
    return Person(genes, first_name, last_name)

def random_spawn(n, p):
    for _ in range(n):
        genes = []
        for gene_name in gene_list:
            genes.append(Gene(Allele((random.random() > p), name), Allele((random.random() > p), name), name))
        people.append(Person(genes, random.choice(first_names), random.choice(last_names)))

def monogomous_generation(people, fertility=1):
    random.shuffle(people)
    for i in range(0, int(len(people)*fertility), 2):
        new_people.append(birth(people[i], people[i+1]))

def random_generation(people, fertility=1):
    for i in range(int(len(people)*fertility)):
        # random.shuffle(people) # too inefficient
        p1, p2 = random.choice(people), random.choice(people)
        if p1 == p2:
            i -= 1
            continue
        new_people.append(birth(p1, p2))

