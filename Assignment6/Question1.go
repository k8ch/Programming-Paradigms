// Question 1

/* 
Create a struct House with the following fields :
	A slice of strings for the rooms in the house
	A string with the name
	A slice of struct roomSz
The helper struct roomSz should have two fields of type float32: width and length.
Create an interface Home with the following two methods
	inputSqft with no arguments and no return
	printMetric with no arguments and no return
Implement the following global functions
	NewHouse returning a pointer to House with the field name set to “House”, the field
rooms set to a slice containing the strings "kitchen", "living", "dining", "main" and the field
sizeFt set to a slice of default initialized struct roomSz of the same length than
rooms.
	NewHouseRooms which is the same as NewHouse but taking an argument of type slice of
strings with other rooms, e.g., "bedroom1", "bedroom2" and the fields rooms and sizeFt
correspondingly set.
Implement methods of the interface Home for a pointer to House
	The method inputSqft that allows the user to input the size of each room
	The method printMetric that prints all the rooms in the house but in meters instead of feet 
*/

package main

import(
	"fmt"
	"strconv"
	"bufio"
	"os"
	"strings"
)

type House struct {
	rooms []string
	name string
	sizeFt []roomSz
}

type roomSz struct{
	width float32
	length float32
}

type Home interface {
	inputSqft()
	printMetric()
}

func (r roomSz) getWidth() float32{
	return r.width
}

func (r roomSz) getLength() float32{
	return r.length
}


func NewHouse() House {
	house := House{}
	house.name = "House"
	house.rooms = []string{"kitchen", "living", "dining", "main"}
	house.sizeFt = make([]roomSz, len(house.rooms))
	return house
}

func NewHouseRooms(extraRooms []string) House{
	house := House{}
	house.name = "House"
	house.rooms = []string{"kitchen", "living", "dining", "main"}
	for i := 0; i < len(extraRooms);  i++ {
		house.rooms = append(house.rooms, extraRooms[i])
	}
	house.sizeFt = make([]roomSz, len(house.rooms))
	return house
}

func (house House) inputSqft(){

	for i := 0; i < len(house.rooms); i++{

		read := bufio.NewReader(os.Stdin)
		fmt.Print(house.rooms[i], " : width x length: ")
		input, _ := read.ReadString('\n')
		str := strings.Split(strings.TrimSpace(input), "x")

		str1, _ := strconv.ParseFloat(str[0], 64)
		str2, _ := strconv.ParseFloat(str[1], 64)

		width := float32(str1)
		length := float32(str2)


		house.sizeFt[i] = roomSz{width, length}

	}
	return
}

func (house House) printMetric() {

	println(house.name)

	for i := 0; i < len(house.rooms); i++{

		fmt.Println(house.rooms[i], " : ", house.sizeFt[i].getWidth()/3.2808, " x ", house.sizeFt[i].getLength()/3.2808 )



	}
}

//testing
/*
func main(){
	fmt.Println("")
	//to test with NewHouse

	house := NewHouse()
	house.inputSqft()
	house.printMetric()

	//to test with NewHouseRooms
	str := []string{"bedroom1", "bedroom2"}
	house := NewHouseRooms(str)
	house.inputSqft()
	house.printMetric()
}
*/

/* 
Create a struct Semi which embeds the struct House and has no other fields. Add the global
functions NewSemi and NewSemiRooms should behave correspondingly to the function
NewHouse and NewHouseRooms, respectively. The only difference should be that these
function will set the name field in the embedded House to "Semi" instead of "House". Make
sure to also supply the required methods that a pointer Semi will implement the interface Home.
*/

type Semi struct{
	House
}

func NewSemi() Semi {
	semi := Semi{}
	semi.name = "Semi"
	semi.rooms = []string{"kitchen", "living", "dining", "main"}
	semi.sizeFt = make([]roomSz, len(semi.rooms))
	return semi
}

func NewSemiRooms(extraRooms []string) Semi{
	semi := Semi{}
	semi.name = "Semi"
	semi.rooms = []string{"kitchen", "living", "dining", "main"}
	for i := 0; i < len(extraRooms);  i++ {
		semi.rooms = append(semi.rooms, extraRooms[i])
	}
	semi.sizeFt = make([]roomSz, len(semi.rooms))
	return semi
}

/*
Write a main routine which makes a slice of type Home as follows
homes := []Home{NewHouse(), NewSemi(),
 NewHouseRooms([]string{"bedroom1", "bedroom2"})}
Then loops over all homes calling inputSqft on each. Afterwards loops over all homes
again calling printMetric. 

*/

func main(){
	homes := []Home{NewHouse(), NewSemi(), NewHouseRooms([]string{"bedroom1", "bedroom2"})}


	for i := 0; i < len(homes); i++{
		house := homes[i]
		house.inputSqft()
		house.printMetric()
	}
}
