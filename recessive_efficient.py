import random

h, d, r = 0, 0, 0
n = 100

# def generation(h, d, r):

    
# for

first_names = ["Liam", "Emma", "Noah", "Olivia", "William", "Ava", "James", "Isabella", "Logan", "Sophia", "Benjamin", "Mia", "Mason", "Charlotte", "Elijah", "Amelia", "Oliver", "Evelyn", "Jacob", "Abigail", "Lucas", "Harper", "Michael", "Emily", "Alexander", "Elizabeth", "Ethan", "Avery", "Daniel", "Sofia", "Matthew", "Ella", "Aiden", "Madison", "Henry", "Scarlett", "Joseph", "Victoria", "Jackson", "Aria", "Samuel", "Grace", "Sebastian", "Chloe", "David", "Camila", "Carter", "Penelope", "Wyatt", "Riley", "Jayden", "Layla", "John", "Lillian", "Owen", "Nora", "Dylan", "Zoey", "Luke", "Mila", "Gabriel", "Aubrey", "Anthony", "Hannah", "Isaac", "Lily", "Grayson", "Addison", "Jack", "Eleanor", "Julian", "Natalie", "Levi", "Luna", "Christopher", "Savannah", "Joshua", "Brooklyn", "Andrew", "Leah", "Lincoln", "Zoe", "Mateo", "Stella", "Ryan", "Hazel", "Jaxon", "Ellie", "Nathan", "Paisley", "Aaron", "Audrey", "Isaiah", "Skylar", "Thomas", "Violet", "Charles", "Claire", "Caleb", "Bella", "Josiah", "Aurora", "Christian", "Lucy", "Hunter", "Anna", "Eli", "Samantha", "Jonathan", "Caroline", "Connor", "Genesis", "Landon", "Aaliyah", "Adrian", "Kennedy", "Asher", "Kinsley", "Cameron", "Allison", "Leo", "Maya", "Theodore", "Sarah"]
last_names = ["Smith", "Johnson", "Williams", "Jones", "Brown", "Davis", "Miller", "Wilson", "Moore", "Taylor", "Anderson", "Thomas", "Jackson", "White", "Harris", "Martin", "Thompson", "Garcia", "Martinez", "Robinson", "Clark", "Rodriguez", "Lewis", "Lee", "Walker", "Hall", "Allen", "Young", "Hernandez", "King", "Wright", "Lopez", "Hill", "Scott", "Green", "Adams", "Baker", "Gonzalez", "Nelson", "Carter", "Mitchell", "Perez", "Roberts", "Turner", "Phillips", "Campbell", "Parker", "Evans", "Edwards", "Collins", "Stewart", "Sanchez", "Morris", "Rogers", "Reed", "Cook", "Morgan", "Bell", "Murphy", "Bailey", "Rivera", "Cooper", "Richardson", "Cox", "Howard", "Ward", "Torres", "Peterson", "Gray", "Ramirez", "James", "Watson", "Brooks", "Kelly", "Sanders", "Price", "Bennett", "Wood", "Barnes", "Ross", "Henderson", "Coleman", "Jenkins", "Perry", "Powell", "Long", "Patterson", "Hughes", "Flores", "Washington", "Butler", "Simmons", "Foster", "Gonzales", "Bryant", "Alexander", "Russell", "Griffin", "Diaz", "Hayes"]

gene_list = ["A", "B", "C", "D"]#, "E", "F"]

class Allele():
    def __init__(self, dominant, name=""):
        self.dominant = dominant
        self.recessive = not dominant
        self.name = name

class Gene():
    def __init__(self, allele1, allele2, name=""):
        self.name = name
        self.allele1 = allele1
        self.allele2 = allele2
        self.alleles = [allele1, allele2]
        if allele1.dominant and allele2.dominant:
            self.zygous = "d"
        elif allele1.dominant or allele2.dominant:
            self.zygous = "h"
        else:
            self.zygous = "r"

class Person():
    def __init__(self, genes, first_name="", last_name=""):
        self.genes = genes
        self.first_name = first_name
        self.last_name = last_name

    def __str__(self):
        gene_str = ""
        for gene in self.genes:
            gene_str += gene.name + ": " + gene.zygous + ",\t"
        return self.first_name + " " + self.last_name + ":\t" + gene_str


def gene_birth(gene1, gene2):
    assert gene1.name == gene2.name
    return Gene(random.choice(gene1.alleles), random.choice(gene2.alleles), name=gene1.name)

def birth(p1, p2):
    last_name = random.choice([p1.last_name, p2.last_name])
    first_name = random.choice(first_names)
    genes = [gene_birth(p1.genes[i], p2.genes[i]) for i in range(min(len(p1.genes), len(p2.genes)))]
    return Person(genes, first_name, last_name)

def random_spawn(n, p):
    new_people = []
    for _ in range(n):
        genes = []
        for gene_name in gene_list:
            genes.append(Gene(Allele((random.random() > p), gene_name), Allele((random.random() > p), gene_name), gene_name))
        new_people.append(Person(genes, random.choice(first_names), random.choice(last_names)))
    return new_people

def monogomous_generation(people, fertility=1):
    new_people = []
    random.shuffle(people)
    for i in range(0, int(len(people)*fertility), 2):
        new_people.append(birth(people[i], people[i+1]))
    return new_people

def random_generation(people, fertility=1):
    new_people = []
    for i in range(int(len(people)*fertility)):
        # random.shuffle(people) # too inefficient
        p1, p2 = random.choice(people), random.choice(people)
        if p1 == p2:
            i -= 1
            continue
        new_people.append(birth(p1, p2))
    return new_people

def analyze_people(people, gene_list):
    genes = {gene_name: {"d": 0, "h": 0, "r": 0} for gene_name in gene_list}
    for person in people:
        for gene in person.genes:
            genes[gene.name][gene.zygous] += 1
    for gene_name in genes:
        total = float(sum(genes[gene_name].values()))
        for zygous in genes[gene_name]:
            genes[gene_name][zygous] /= total
    return genes

if __name__ == "__main__":
    people = random_spawn(8,0.5)    
    for person in people:
        print(person)
    people = random_generation(people, 0.8)
    print("gen 2")
    for person in people:
        print(person)
    people = random_generation(people, 0.6)
    print("gen 3")
    for person in people:
        print(person)
    # people = random_spawn(1000,0.5)
    # print(analyze_people(people, gene_list))
