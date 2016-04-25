#Question 3

# Create a class House with the following instance variables :
#   A list of strings for the rooms in the house
#   A string with the name 'House'
# House should have the following methods:
#   A constructor with an optional argument of a list of strings. Without the optional argument
# the object should have a list of rooms [ 'kitchen', 'living', 'dinning', 'main' ] while with an
# optional argument ['bedroom 1', 'bedroom 2'], the list of rooms should be [ 'kitchen', 'living',
# 'dinning', 'main', 'bedroom 1', 'bedroom 2'].
#   A method inputSqft that allows the user to input the size of each room
#   A method printMetric that prints all the rooms in the house but in meters instead of feet 


class House:
    rooms = []
    name = "House"
    roomExist = False

    def __init__(self, room=None):
        if room is None:
            self.rooms = ["kitchen", "living", "dining", "main"]
        else:
            self.rooms = ["kitchen", "living", "dining", "main", "bedroom1", "bedroom 2"]
            self.roomExist = True

    def inputSqft(self):
        self.kitchenSize = input("kitchen : width x length: ")
        self.livingSize = input("living : width x length: ")
        self.diningSize = input("dining : width x length: ")
        self.mainSize = input("main : width x length: ")

        if self.roomExist is True:
            self.bedroom1Size = input("bedroom 1 : width x length: ")
            self.bedroom2Size = input("bedroom 2 : width x length: ")

    def printMetric(self):

        print(
            self.name + "\n"
            "kitchen : " + (str(round(float(self.kitchenSize.split("x")[0]) * 0.3048, 2)) + " x "
                            + str(round(float(self.kitchenSize.split("x")[1]) * 0.3048, 2))) + " m" + "\n"
            "living : " + (str(round(float(self.livingSize.split("x")[0]) * 0.3048, 2)) + " x "
                           + str(round(float(self.livingSize.split("x")[1]) * 0.3048, 2))) + " m" + "\n"
            "dining : " + (str(round(float(self.diningSize.split("x")[0]) * 0.3048, 2)) + " x "
                           + str(round(float(self.diningSize.split("x")[1]) * 0.3048, 2))) + " m" + "\n"
            "main : " + (str(round(float(self.mainSize.split("x")[0]) * 0.3048, 2)) + " x "
                         + str(round(float(self.mainSize.split("x")[1]) * 0.3048, 2))) + " m"
        )
        if self.roomExist is True:
            print(
                "bedroom 1 : " + (str(round(float(self.bedroom1Size.split("x")[0]) * 0.3048, 2)) + " x "
                                  + str(round(float(self.bedroom1Size.split("x")[1]) * 0.3048, 2))) + " m" + "\n"
                "bedroom 2 : " + (str(round(float(self.bedroom2Size.split("x")[0]) * 0.3048, 2)) + " x "
                                  + str(round(float(self.bedroom2Size.split("x")[1]) * 0.3048, 2))) + " m" + "\n"
            )

# Derive a class Semi from House. The only new method is a constructor that works identical to
# House and simply sets the room instance variable in House by calling the constructor in House.
# Semi should have its name set to 'Semi'. 

class Semi(House):

    def __init__(self):
        super().__init__()
        self.name = "Semi"


''' h1 = House()
print(h1.rooms)
h2 = House(['bedroom 1', 'bedroom 2'])
print(h2.rooms)
h2.inputSqft()
h2.printMetric()
h3 = Semi()
h3.inputSqft()
h3.printMetric() '''
