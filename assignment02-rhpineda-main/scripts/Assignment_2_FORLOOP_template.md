# Template for Assignment_2 For Loop Lab

__Name:__ Ricardo Pineda IV

__Student ID:__ 917486212

__Where applicable (or when in doubt) provide the code you used to answer the questions__

__Exercise One:__ Write a for loop to pluralize peach, tomato, potato (remember that these end in "es" when plural).  Put the code below (in a code block!)

```
fruit_list="peach tomato potato"

for fruit in $fruit_list
  do 
    echo "${fruit}es"
  done
```
__Exercise Two:__ In your own words provide a human "translation" of the for loop given __directly above__ the Exercise 2 prompt on the lab webpage.

```
for file in ${myfiles}
  do
    cat ${file}
  done
```

1. `echo ${myfiles}` -> just lists out files listed from current directory `for_ex` in this case
2. `for file in ${myfiles}` -> makes a for loop that goes through each file in the `ls`'d directory
3. `do` and `cat ${file}` and `done` -> reads each of the files in `for_ex` and prints it all out in the terminal 

__Exercise Three:__ Modify the for loop given __directly above__ the Exercise 3 prompt on the lab webpage to produce the output __directly below__ the Exercise 3 prompt on the lab webpage.

```
for file in ${myfiles}
  do
    echo file ${file} contains: $(cat ${file})
  done
```

**MV** -0

