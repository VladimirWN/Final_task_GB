class Pet:
    def __init__(self, name, age, species):
        self.name = name
        self.age = age
        self.species = species
        self.command_list = []

    def add_command(self, command):
        self.command_list.append(command)

    def __str__(self):
        return f"{self.name} ({self.species}, {self.age} years old)"


class Cat(Pet):
    def __init__(self, name, age):
        super().__init__(name, age, "cat")
        self.command_list.extend(["spat\'", "jrat\'", "ks-ks"])


class Dog(Pet):
    def __init__(self, name, age):
        super().__init__(name, age, "dog")
        self.command_list.extend(["lie down", "sit", "give me a paw"])


class Hamster(Pet):
    def __init__(self, name, age):
        super().__init__(name, age, "hamster")
        self.command_list.extend(["wheel"])
