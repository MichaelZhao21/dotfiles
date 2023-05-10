package scripts

import (
	"os"
	"strings"

	cp "github.com/otiai10/copy"
)

func LoadDotfiles() {
	// Call ReadConfig to get a list of files to back up
	files := ReadConfig()

	// Get the home directory
	homeDir := os.Getenv("HOME")

	// Create backups directory if it doesn't exist
	if _, err := os.Stat(homeDir + "/backups"); os.IsNotExist(err) {
		os.Mkdir(homeDir+"/backups", 0755)
	}

	// Loop through all files and symlink
	for _, file := range files {
		// If the symlink exists, delete it
		if _, err := os.Lstat(file); err == nil {
			os.Remove(file)
		} else if _, err := os.Stat(file); err == nil {
			// If it exists in the backup, delete the old backup
			if _, err := os.Stat(homeDir + "/backups" + strings.TrimPrefix(file, homeDir)); err == nil {
				err := os.RemoveAll(homeDir + "/backups" + strings.TrimPrefix(file, homeDir))
				if err != nil {
					panic(err)
				}
			}

			// Copy the file to backups and delete it
			err2 := cp.Copy(file, homeDir+"/backups"+strings.TrimPrefix(file, homeDir))
			err3 := os.RemoveAll(file)
			if err2 != nil {
				panic(err2)
			}
			if err3 != nil {
				panic(err3)
			}
		}

		// Symlink the file
		cwd, _ := os.Getwd()
		err := os.Symlink(cwd+"/df"+strings.TrimPrefix(file, homeDir), file)
		if err != nil {
			panic(err)
		}
	}
}
