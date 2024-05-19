package scripts

import (
	"fmt"
	"os"
	"strings"

	cp "github.com/otiai10/copy"
)

func SaveDotfiles() {
	// Call ReadConfig to get a list of files to back up
	files := ReadConfig()

	// Get the home directory
	homeDir := os.Getenv("HOME")

	// If the "df" directory is not empty, ask the user
	// if they want to overwrite the saved dotfiles
	dirExists, _ := os.Stat("df")
	if dirExists != nil {
		var choice string
		fmt.Print("The saved df directory is not empty. Are you sure you want to overwrite the files? (y/N) ")
		fmt.Scanln(&choice)
		if strings.ToLower(choice) != "y" {
			fmt.Println("Aborted.")
			return
		}
	}

	// Loop through all files and copy recursively
	for _, file := range files {
		cp.Copy(file, "df"+strings.TrimPrefix(file, homeDir))
	}

	fmt.Println("Dotfiles succesfully saved!")
}
