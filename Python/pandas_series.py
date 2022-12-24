#-----------------------------------------------------------------------------------------------------------

# Block Comment = Ctrl + Shift + /

# If data is an ndarray, then index passed must be of the same length.
# If no index is passed, then by default index will be range(n)
# where n is array length, i.e., [0,1,2,3…. range(len(array))-1]

#create series from ndarray
import pandas as pd
import numpy as np
data = np.array(['a','b','c','d'])
s = pd.Series(data)
print(s)

#We did not pass any index, so by default, it assigned the indexes ranging from 0 to len(data)-1, i.e., 0 to 3.
#---------------------------------------------------------------------------------------------------------------

#Series with Index
import pandas as pd
import numpy as np
data = np.array(['a','b','c','d'])
s = pd.Series(data,index=[100,101,102,103])
print (s)

#We passed the index values here. Now we can see the customized indexed values in the output.

#---------------------------------------------------------------------------------------------------------------

#Dictionary
import pandas as pd
import numpy as np
data = {'a' : 0., 'b' : 1., 'c' : 2.}
s = pd.Series(data)
print (s)

# A dict can be passed as input and if no index is specified, then the dictionary keys are taken in a sorted order to construct index.
# If index is passed, the values in data corresponding to the labels in the index will be pulled out.

import pandas as pd
import numpy as np
data = {'a' : 0., 'b' : 1., 'c' : 2.}
s = pd.Series(data,index=['b','c','d','a'])
print (s)

#Observe − Index order is persisted and the missing element is filled with NaN (Not a Number).

#If data is a scalar value, an index must be provided. The value will be repeated to match the length of index
import pandas as pd
import numpy as np
s = pd.Series(5, index=[0, 1, 2, 3])
print (s)

#-------------------accessing data from series with position------------------------------------------------
import pandas as pd
s = pd.Series([1,2,3,4,5],index = ['a','b','c','d','e'])

#retrieve the first element
print (s[0])

#retrieve the first three element
print (s[:3])

#retrieve the last three element
print (s[-3:])

#retrieve a single element
print (s['a'])

#retrieve multiple elements
print (s[['a','c','d']])

#If a label is not contained, an exception is thrown
#print (s['f'])
#--------------------------------------------------------------------------------------------------------------