package main

import (
	"fmt"
)

func main() {
	for i := 0; i < 256; i++ {
		fg := 15
		if (i > 6 && i < 16) ||
			(i > 33 && i < 52) ||
			(i > 69 && i < 88) ||
			(i > 105 && i < 124) ||
			(i > 141 && i < 160) ||
			(i > 177 && i < 196) ||
			(i > 213 && i < 232) ||
			i > 243 {
			fg = 0
		}
		fmt.Printf("\x1b[48;5;%dm\x1b[38;5;%dm %3[1]d \x1b[0m", i, fg)
		if i < 15 {
			fmt.Print(" ")
		}
		// if i == 15 || i == 33 || i == 69 || i == 105 || i == 141 || i == 177 || i == 213 || i == 51 || i == 87 || i == 123 || i == 159 || i == 195 || i == 231 || i == 255 {
		if i == 15 || i == 51 || i == 87 || i == 123 || i == 159 || i == 195 || i == 231 || i == 255 {
			fmt.Println()
		}
	}
}
