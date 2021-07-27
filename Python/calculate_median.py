
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