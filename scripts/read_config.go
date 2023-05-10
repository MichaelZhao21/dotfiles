package scripts

import (
	"bufio"
	"log"
	"os"
	"strings"
)

func ReadConfig() []string {
	// Read file
	file, err := os.Open("scripts/files")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	// Set current directory to home directory by default
	homeDir := os.Getenv("HOME")
	currDir := homeDir

	// Create a list of all directories and files to back up
	var files []string

	// Read file line by line
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		// Get line
		line := scanner.Text()

		// Ignore empty lines
		if line == "" {
			continue
		}

		// Ignore comments
		if strings.HasPrefix(line, "#") {
			continue
		}

		// If the line is wrapped in brackets, set the current directory
		if strings.HasPrefix(line, "[") && strings.HasSuffix(line, "]") {
			currDir = homeDir + "/" + strings.TrimSuffix(strings.TrimPrefix(line, "["), "]")
			continue
		}

		// Add the file to the list
		files = append(files, currDir+"/"+line)
	}

	return files
}
