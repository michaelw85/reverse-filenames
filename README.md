reverse-filenames
=================

Bash script that changes all filenames in the current dir to reversed filenames.
The script skips folders, only changes files and is not recursive.
While executing, it will show a progress bar and show stats when it is finished.

In a Debian environment you can put the script in /usr/local/bin/ to make it available for all users on the server.
Don't forget to give the script the correct ownership and user rights. The script needs to be executable.
After that, you can call the script using it's filename (reverse-filenames) in your current dir and that's it.

