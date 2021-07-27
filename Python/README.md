# Functions Best Practices

## Document your code
With a docstring though, it is much easier to tell what the expected inputs and outputs should be, as well as what the function does. A docstring is a string written as the first line of a function. Because docstrings usually span multiple lines, they are enclosed in triple quotes, Python's way of writing multi-line strings:

Every docstring has some (although usually not all) of these five key pieces of information:
 - Description of what the function does.
 - Description of the arguments, if any.
 - Description of the return value(s), if any.
 - Description of errors raised, if any.
 - Optional extra notes or examples of usage.

```
def function(arg_1, arg_2=42):
    """Description of what the function does.

    Args:
      arg_1 (str): Description of arg_1 that can break onto the next line
        if needed.
      arg_2 (int, optional): Write optional when an argument has a default
        value.

    Returns:
      bool: Optional description of the return value
      Extra lines are not indented.

    Raises:
      ValueError: Include any error types that the function intentionally
        raises.

    Notes:
      See https://www.dataquest.io for more info.  
    """
```

 - use the **inspect** module to return the **docstring** for a function

```
import inspect

def count_letter(content, letter):
    """Counts the number of times letter appears in content.

    Args:
      content (str): The string to search.
      letter (str): The letter to search for.

    Returns:
      int
      
    Raises:
      ValueError: letter must be a single character string
    """
    if (not isinstance(letter, str)) or len(letter) != 1:
        raise ValueError('`letter` must be a single character string.')
    return len([char for char in content if char == letter])

formatted_docstring = inspect.getdoc(count_letter)
print(formatted_docstring)
```

## Create functions that are easy to test, debug, and change

### DRY = Do Not Repeat Yourself

```
def standardize(column):
    """Standardizes the values in a column.

    Args:
      column (pandas Series): The data to standardize.

    Returns:
      pandas Series: the values as z-scores
    """
    # Finish the function so that it returns the z-scores
    z_score = (column - column.mean()) / column.std()
    return z_score

# Use the standardize() function to calculate the z-scores
df['y1_z'] = standardize(df['y1_gpa'])
df['y2_z'] = standardize(df['y2_gpa'])
df['y3_z'] = standardize(df['y3_gpa'])
df['y4_z'] = standardize(df['y4_gpa'])
```

### DO One Thing

```
def calculate_mean(values):
    """Gets the mean of a list of `values`

    Args:
      values (iterable of float): A tuple of numbers

    Returns:
      float: The mean of the provided numbers
    """
    mean = sum(values) / len(values)
    return mean

even = (1,3,5,8)
odd = (1,3,5,8,10)
print(f'The mean of {even} is {calculate_mean(even)}')
print(f'The mean of {odd} is {calculate_mean(odd)}')
```

```
def calculate_median(values):
    """Gets the median of a list of `values`

    Args:
      values (iterable of float): A tuple of numbers

    Returns:
      float: the median of the provided numbers
    """

    midpoint = int(len(values) / 2)

    if len(values) % 2 == 0:
        median = (values[midpoint - 1] + values[midpoint]) / 2
    else:
        median = values[midpoint]

    return median

even = (1,3,5,8)
odd = (1,3,5,8,10)
print(f'The median of {even} is {calculate_median(even)}')
print(f'The median of {odd} is {calculate_median(odd)}')
```