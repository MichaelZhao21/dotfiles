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

	// Loop through all files and symlink
	for _, file := range files {
		// Save the file if it exists to backups
		if _, err := os.Stat(file); err == nil {
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

		// If the symlink exists, delete it
		if _, err := os.Lstat(file); err == nil {
			os.Remove(file)
		}

		// Symlink the file
		cwd, _ := os.Getwd()
		err := os.Symlink(cwd+"/df"+strings.TrimPrefix(file, homeDir), file)
		if err != nil {
			panic(err)
		}
	}
}
