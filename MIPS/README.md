# MIPS code samples

### The following are some examples of my MIPS code samples. Here is a brief description of what each program does:

#### *quicksort*
An Implementation of the quicksort algorithm using the MIPS assembly language. Instructions:
- inputs can be positive numbers of up to two digits, 
- they should be separated by a single blank space
- after the values have been entered, the following keys, so the following jobs:
  - 'c' clears the array of numbers that were to be sorted
  - 's' displays the sorted array
  - 'q' terminates the program
 If after pressing 'c', the uses continues to input integers, those will be added to the already existing array, and sorted altogether.
 
 *Example:*
 ```
 Welcome to QuickSort
Start entering values into the MMIO
56 4 6 78 9 24 56 34 21 24 26 28 45 69 97 94 92 34 7

The sorted array is: 4 6 7 9 21 24 24 26 28 34 34 45 56 56 69 78 92 94 97 
57 59 42 43 77 88 99
The sorted array is: 4 6 7 9 21 24 24 26 28 34 34 42 43 45 56 56 57 59 69 77 78 88 92 94 97 99 
The array is re-initialized
9 8 7 6 5 4 3 2 1

The sorted array is: 1 2 3 4 5 6 7 8 9 
99 98 97 96 95 94 93 92 91
The sorted array is: 1 2 3 4 5 6 7 8 9 91 92 93 94 95 96 97 98 99
 ```
The following string was passed as input into the MMIO simulator for the output to apprear this way:
```
56 4 6 78 9 24 56 34 21 24 26 28 45 69 97 94 92 34 7s57 59 42 43 77 88 99sc9 8 7 6 5 4 3 2 1s99 98 97 96 95 94 93 92 91sq
```

#### *_count_*
A MIPS program that counts the number of occurrences of a word in a text block entered using the keyboard. The user enters a text block (no more than 600 characters) in the console and then asks for a word to search for. 
Note that a word means any continuous set of characters before the next space. The program searches the text block and displays the number of occurrences of the word entered. The program prints the text and the word entered by the keyboard. The end of the text block is reached when the user presses the <Enter> key. After the program finishes it provides an option of redoing the task or exiting the program.
This program implements Memory Mapper I/O, thus when running the program on mars, the text should be entered into the MMIO keyboard and display simulators. 

*Example:*
```
WordCount
Enter the text segment:
Peter Piper picked a peck of pickled peppers A peck of picked pickled peppers Peter Piper picked If Peter Piper picked 10 pecks of pickled peppers Where are the pecks of pickled petters Peter Piper picked
Enter the search word:
picked

The word 'picked' occurred 5 time(s).
press 'e' to enter another segment of text or 'q' to quit.
-- program is finished running --
```
