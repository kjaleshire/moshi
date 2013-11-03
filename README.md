Moshi
===

For catching and creating all (well, most...) of your misspelled words. Does fuzzy correction and generation based on incorrect vowels, bad capitalization, or duplicate letters.

Installation and Usage:
===

Moshi is packaged as a gem. To build (but not install):

	$ rake build

To build and install into your system gems:

	$ rake install

Moshi has two modes, suggestion and generation, each based off a loaded dictionary you may specify.

Suggestion:
===

	$ moshi [-a|--all] [-o|--original] [-d|--dictionary custom_dictionary]
Loads the dictionary at the given path. If none is specified, `/usr/share/dict/words` is loaded. Once loaded, moshi will present a prompt:

	> _

Enter a misspelled word and a suggestion will be printed. If no suggestion is found, `NO SUGGESTION` will be printed. If the word is already correct, moshi will reply `CORRECT`.

When `-a` is used, all close suggestions will be listed with the best first. 
When `-o` is used, the original word will be printed before its suggestion(s).

Suggestion will continue until end-of-file (control-D) or interrupt (control-C).

Generation:
===

	$ moshi [-g|--generate N] [-o|--original] [-d|--dictionary custom_dictionary]
Load a dictionary, either default or specified, select `N` words from it, mutate then print them.

When `-o` is used, the original word will be printed before its mutation.

Additional options:
===

	$ moshi -h|--help
Print help summary and exit

	$ moshi -v|--version
Print version and exit

Examples
===

Load a dictionary at $HOME/custom_dict.txt and start a prompt:

	$ moshi -d ~/custom_dict.txt

Load the default dictionary and start a prompt. Print the submitted word and the best suggestion, followed by all other possible corrections:

	$ moshi -o -a

Generate 5 mispelled words and the word they were mutated from:

	$ moshi -g 5 -o

Generate 10 misspelled words then print them and their correction:

	$ moshi -g 10 | moshi -o

Enjoy!
===

Moshi is short for moshireru (もうしいれる), 'to propose, to suggest'

Bugs or suggestions, please email me: kjaleshire@gmail.com

Copyright (c) 2013 Kyle J Aleshire. All rights Reserved. MIT License.