
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