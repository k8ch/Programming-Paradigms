//Kateryna Chernega
//7246161
//CSI2120
//Assignment6, Question 1

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
/*func main(){
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


func main(){
	homes := []Home{NewHouse(), NewSemi(), NewHouseRooms([]string{"bedroom1", "bedroom2"})}


	for i := 0; i < len(homes); i++{
		house := homes[i]
		house.inputSqft()
		house.printMetric()
	}
}