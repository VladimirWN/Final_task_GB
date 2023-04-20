from application.model.pets import *
from application.view.console_view import *


def create_pet():
    name = get_data("Enter pet name: ")
    if not name:
        raise Exception("name cannot be empty")
    age = int(get_data("Enter pet age: "))
    species = get_data("Enter pet species (cat, dog, or hamster): ")

    if species.lower() == "cat":
        pet = Cat(name, age)
    elif species.lower() == "dog":
        pet = Dog(name, age)
    elif species.lower() == "hamster":
        pet = Hamster(name, age)
    else:
        raise Exception("invalid species")

    while True:
        command = sent_msg("Enter a command for the pet or press Enter to finish: ")
        if not command:
            break
        pet.add_command(command)

    return pet


def print_commands(pet):
    sent_msg(f"{pet.name} can do the following commands:")
    for command in pet.command_list:
        sent_msg(command)


def train_pet(pet):
    while True:
        command = get_data("Enter a new command for the pet or press Enter to finish: ")
        if not command:
            break
        pet.add_command(command)
