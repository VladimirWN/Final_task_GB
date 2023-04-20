from application.service.counter import *
from application.service.pet_service import *
from application.view.menu import *


def start():
    counter = Counter()
    pets = []

    while True:
        menu()
        choice = get_data("Enter your choice: ")
        if choice == "1":
            try:
                with counter:
                    pet = create_pet()
                    pets.append(pet)
                    sent_msg("Pet added!")
            except Exception as e:
                sent_msg("Error: ", e)
        elif choice == "2":
            name = get_data("Enter the pet's name: ")
            for pet in pets:
                if pet.name == name:
                    print_commands(pet)
                    break
            else:
                sent_msg("Pet not found")
        elif choice == "3":
            name = get_data("Enter the pet's name: ")
            for pet in pets:
                if pet.name == name:
                    train_pet(pet)
                    break
            else:
                sent_msg("Pet not found")
        elif choice == "4":
            if len(pets) > 0:
                for pet in pets:
                    sent_msg(pet)
            else:
                sent_msg("Pet list is empty")
        elif choice == "5":
            sent_msg("Current quantity is ", counter.count)
        elif choice == "0":
            sent_msg("Goodbye!")
            break
        else:
            sent_msg("Invalid choice")
