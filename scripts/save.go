package scripts

import (
	"os"
	"strings"

	cp "github.com/otiai10/copy"
)

func SaveDotfiles() {
	// Call ReadConfig to get a list of files to back up
	files := ReadConfig()

	// Get the home directory
	homeDir := os.Getenv("HOME")

	// Loop through all files and copy recursively
	for _, file := range files {
		cp.Copy(file, "df"+strings.TrimPrefix(file, homeDir))
	}
}
