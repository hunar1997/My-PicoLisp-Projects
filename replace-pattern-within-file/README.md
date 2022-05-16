# Replacing patterns within a file

Back in university, we had packages for running Atomistic Physics simuations and some calculations were tedious, we needed to run calculations a number of times, each time only changing a number, but each calculation took hours.. Thus we needed a script and I used python f-strings .. here is the alternative solution in PicoLisp:

* Create a template file, make unique patterns (here i used tags `<Atoms>`)
* Define the patterns in the `.l` file and provide the replacements

Thanks for reading :)
