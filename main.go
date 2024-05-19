package main

import (
	"dotfiles/scripts"
	"fmt"
	"os"
)

func main() {
	// Check to make sure there is 0 or 1 command line arguments
	if len(os.Args) > 2 {
		fmt.Println("Usage: dotfiles [save|load] (default is load)")
		os.Exit(1)
	}

	// Get the command line argument
	var command string
	if len(os.Args) == 2 {
		command = os.Args[1]
	}

	// Run the command
	switch command {
	case "save":
		fmt.Println("Saving dotfiles...")
		scripts.SaveDotfiles()
	default:
		fmt.Println("Loading dotfiles...")
		scripts.LoadDotfiles()
	}

}
