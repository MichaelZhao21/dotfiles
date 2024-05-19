package scripts

import (
	"bufio"
	"log"
	"os"
	"strings"
)

func ReadConfig() []string {
	// Read file
	file, err := os.Open("files")
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
			// Use home directory as base unless the path is absolute
			base := homeDir + "/"
			if strings.HasPrefix(line, "[/") {
				base = ""
			}

			// Set the curr dir
			currDir = base + strings.TrimSuffix(strings.TrimPrefix(line, "["), "]")
			continue
		}

		// If the line starts with a slash, use absolute path
		if strings.HasPrefix(line, "/") {
			files = append(files, line)
			continue
		}

		// Otherwise, use the relative path
		files = append(files, currDir+"/"+line)
	}

	return files
}
