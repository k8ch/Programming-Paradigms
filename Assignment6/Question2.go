package main

import(
	"runtime"
	"time"
	"os"
	"bufio"
	"strings"
	//"fmt"
)

func main() {
	runtime.GOMAXPROCS(4)

	input1, _ := os.Open("input1.txt")
	scanner1 := bufio.NewScanner(input1)
	chan1 := make(chan string)
	defer input1.Close()

	input2, _ := os.Open("input2.txt")
	scanner2 := bufio.NewScanner(input2)
	chan2 := make(chan string)
	defer input2.Close()

	output, _ := os.Create("output.txt")
	defer output.Close()

	timer := time.NewTimer(time.Second*2)

	go func() {
		time.Sleep(200*time.Millisecond)
		for scanner1.Scan() {
			str1 := scanner1.Text()
			wordsInput1 := strings.Fields(str1)

			for i := range wordsInput1 {
				chan1 <- wordsInput1[i]
			}

		}
	}()

	go func() {
		time.Sleep(300*time.Millisecond)
		for scanner2.Scan() {
			str2 := scanner2.Text()
			wordsInput2 := strings.Fields(str2)

			for i := range wordsInput2{
				chan1 <- wordsInput2[i]
			}
		}
	}()

	for {

		 <-timer.C
		output.WriteString("\n")
		timer.Reset(time.Second * 2)
		select {
		case output1 := <-chan1:
			output.WriteString(output1 + " ")
			//fmt.Println(output1)
		case output2 := <-chan2:
			output.WriteString(output2 + " ")
			//fmt.Println(output2)
		}

	}

}

