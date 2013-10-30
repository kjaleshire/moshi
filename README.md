Moshi
====

For catching and creating all (well, most...) of your misspelled words. Does fuzzy correction and generation based on incorrect vowels or capitalization, or duplicate letters.

Installation and Usage:
===

Moshi is packaged as a gem. To build (but not install):
	$ rake build

To build and install into your system gems:
	$ rake install

Moshi has two modes, suggestion and mutation, each based off a loaded dictionary you may specify.

Suggestion:
==

	$ moshi [-o|--original] [-a|--all] [dictionary]
Loads the dictionary at the path specified. If no path is specified, `/usr/share/dict/words` is loaded. Once loaded, moshi will present a prompt: 
	>_

Enter a misspelled word and a suggestion will be printed. If no suggestion can be made or the word is correct, `NO SUGGESTION` will be printed. If the word is already correct, `CORRECT` will be printed

When `-a` is used, all close suggestions will be listed, not just the best. When `-o` is used, the original word will be printed before its suggestion(s).

Suggestion will continue until EOF (^d) or interrupt.

Generation:
==

	$ moshi [-g|--generate N] [-o|--original] [dictionary_path]
Similar to suggestion in that the dictionary will be automatically loaded or specified. Moshi will select N words from the dictionary, mutate and print them.

When `-o` is used, the original word will be printed before its mutation.

Additional options:
==

	$ moshi -h|--help
print help summary and exit
	$ moshi -v|--version
print version and exit

Enjoy!
===

Moshi is short for moshireru (もうしいれる), 'to propose, to suggest'

Bugs or suggestions, please email me: kjaleshire@gmail.com

Copyright (c) 2013 Kyle J Aleshire. All rights Reserved. MIT License.