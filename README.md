# public-configs
Declarative configs that I'm comfortable making public.

This is a temporary deployment method which symlinks files to this repository locally.

Setup: 
- `git clone` this Repo
- `cd` into this Repo
- `cp vars-template.sh`
- `nano vars-template.sh` Add your configurations
- `nano symlink.sh` Modify and customize which configs to use
- `chmod +x symlink.sh` Make the script deployable
- `sh symlink.sh` Deploy symlinks.

Note: Everytime you add a new config, you'll want to add it to the symlinks script and rerun it to place that symlink.
