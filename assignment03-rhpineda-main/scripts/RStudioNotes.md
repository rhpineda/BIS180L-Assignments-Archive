# 1: Basic Blocks

- Can do basic math in console
- `<-` is used to assign variable
- `c()` to concatenate variables to make a vector
- basic math
  - `sqrt()`
  - `abs()`
- 2 vectors of equal length, arithmetic element by element
  - if unequal length, then recycle the shorter vector
-like terminal, can use `tab` to get auto complete and `up arrow` for last input

# 3: Sequence of Numbers

- `x:y` get int seq from x to y
  - works with pi, just does +1 or -1 every increment
- `?function` to get documentation
  - `?":"` for `:` b/c it's a symbol
- `seq(x, y)` does the same as `x:y`  
  - has addn'l options
      - can specify increment such as: `seq(0,10,by=0.5)`
      - can just list of specific length `seq(5, 10, length=30)`
- `length(x)` gets length of vector
- `seq_along(x)` = `seq(along.with = my_seq)` = `1:length(my_seq)`
  - just different ways to get the same result
- `rep(x, times = y)`
  - makes a new vector which is just x repeated y times
  - x can be a vector itself
  - OUTPUT: 1,2,3,4,1,2,3,4..... y times where x = 1,2,3,4
- `rep(x, each = y)`
  - makes a new vector where each element of x is repeated y times in sequence
  - x can be a vector itself
  - OUTPUT: 1,1,1... 2,2,2... 3,3,3... 4,4,4... y times where x = 1,2,3,4

# 4: Vectors
- two types of vectors
  - atomic, only 1 type
  - list, different data types
- Logical vectors
  - TRUE, FALSE , NA
  - when using logical operators the logic is applied to each element of a vector
- logical operators
  - \>, >=, <, <=, == and !=
  - | is OR
  - & is AND
  - !x is the negation of x
    - if x = TRUE the !x = FALSE
- `"x"` -> double quotes indicate character objects
- `paste(x, collapse =  " ")`
  - joins ELEMENTS OF A CHARACTER VECTOR  
  - can specify how each of the elements are separated by
    - in this case it's a space
- `paste(x, y, sep =  " ")`n
  - joins VECTORS together
  - paste can coerce numbers as a character

# 5: Missing Value
- NA -> NA when using math
- `rnorm(x)`
  - get x elements w/ normal dist
- `sample(x, y)`
  - get y samples from x vector
- is.na(x)
  - returns if x is NA or not, TRUE or FALSE
  - NA's are placeholders and aren't actually values
  - so `is.na(x)` != `x == NA`
- counting TF's in a vector
  - TRUE = 1
  - FALSE = 0
  - use `sum(x)` to count how many TRUE's there are in x
- NaN
  - not a number
  - get from 0/0 or Inf
  
# 6: Subsetting Vectors
- square brackets to get a slice of a vector
- `x[1:10]` returns a vector for the first 10 values of x
  - R is 1 based indexed
- `x[is.na(x)]` returns all the NA's from the vector x
  - likewise `x[!is.na(x)]` returns all the non-NA's from the vector x
- `x[x > 0]` returns all the positive values of x
  -works with other logical operators
- Need to get rid of the NA's in a vector if we don't want NA's there
- `x[!is.na(x) & x > 0]` - can combine multiple logical operations when subsetting
-`x[c(3,5,7)]` = `c(x[3], x[5], x[7])`
- can specify a subset of x as a vector or individually
- selecting a slice outside of a vector returns an NA
- `x[c(-a, -c)]` OR `x[-c(a, c)]`
  - selecting a subset of vector x except the certain values a and c
- named vectors are just dictionaries
- `names(x)`
  - to find the key value of the named vector 
- `names(x) <- ("X", "Y", "Z")`
  - to add key values to a nameless vector with 
- `identical(x,y)`
  - to see if x and y are equvalent
- `vect["X"]`
  - subsets the named vector `vect` and returns only the column with the key value of `"X"`

# 7: Matricies and Data Frames
- Matrices can only contain a single class of data
- Data frames can have different classes of data
- `dim(x)`
  - can find the dimensions of x
- `dim(x) <- c(a,b)`
  - can define x to have a dimension of `a` rows and `b` columns
- `x <- matrix(data = 1:20, nrow = 4, ncol = 5)` is the same as `x <- (1:20)` then `dim(x) <- c(4,5)`
- `cbind(x,y)`
  - adds x to y as leftmost column
  - coerce y to be same type as x
    - problematic if x is different from y
- `data.frame(x, y)`
  - creates data frame, no coercion b/c data frames allow for different classes
- `colnames(x) <- a`
  - adds `a` column names to `x` data frame

# 8: Logic (Up to 52%)
- `==` to test equality
- `!=` to test inequality
- normal test like `<`, `>` work as expected
- `<=` for less than or equal to
- `>=` for greater than or equal to
- `!(logical expression that equals TRUE)` should return false
  - not operator returns to opposite of what an expression would w/o it
- two AND operators
  - `&` evaluates across a vector
  - `&&` evaluates on the the first member of a vector
- two OR operators
  - `|` evaluates across a vector
  - `||` evauates on the first member of a vector
  
# 9 Functions (Up to 51%)
- functions are generally written as `function(args)`
- *"Everything that exists is an object everything that happens is a function call"*
- just writing out `function` w/o parenthesis will show you its code
- super basic function format:
  ```
  function_name <- function(argument) {
  CODE
  }
  ```
- set default argument by setting it equal to something  
  -EX: 
  ```
  function_name <- function(argument = 12) {
  CODE
  }
  ```
- you can explicitly specify arguments when calling a function
  -like `remainder(divisor = 11, num = 5)` versus `remainder(5, 11)`
- `args(function)`
  - used to find the arguments of a function
  - example of passing a function as an argument
    ```
    evaluate <- function(func, dat){
    func(dat)
    }
    ```

# 12: Looking at Data
- `ls()` shows the variables in the env't 
- generally you want to look at the data or get some idea about it
  - use `dim(data)` to get dimensional information about data
  - `class(data)` to get its class
  - `nrow(data)` and `ncol(data)` to get number of rows and columns
  - `object.size(data)` get memory occupied by data
  - `names(data)` gets column names
  - `head(data)` to get first 6 rows of data
    - can specify different number of rows w/ another argument, `head(data, 10)`
  - `tail(data)` to get last 6 rows of data
    - can also specify how much like head
  - `summary(data)`
    - shows a lot of data for each column
      - can show length, class, mode, or even summary statistics like min, median, mean, max, 1st and 3rd quartiles, and #NA's
    - use `table(data$categoricalcolumn)` to see what's in categorical columns
  - `str(data)`
      - shows a good summary of the data
      - class, #rows and columns, types of data in each column and the head of each column

# HW Notes

- ls and rm work on variables in R
  
  
  
  
  
