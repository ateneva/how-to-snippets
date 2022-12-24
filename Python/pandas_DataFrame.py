# A pandas DataFrame can be created using various inputs like:
    # Lists
    # dict
    # Series
    # Numpy ndarrays
    # Another DataFrame

# create dataframe from list
import pandas as pd
data = [1,2,3,4,5]
df = pd.DataFrame(data)
print (df)

import pandas as pd
data = [['Alex',10],['Bob',12],['Clarke',13]]
df = pd.DataFrame(data,columns=['Name','Age'])
print (df)

# NB: the dtype parameter changes the type of Age column to floating point.
import pandas as pd
data = [['Alex',10],['Bob',12],['Clarke',13]]
df = pd.DataFrame(data,columns=['Name','Age'],dtype=float)
print (df)

#-------------creating dataframes from ndarrays--------------------------------------------------
# Note the values 0,1,2,3. They are the default index assigned to each using the function range(n).
import pandas as pd
data = {'Name':['Tom', 'Jack', 'Steve', 'Ricky'],'Age':[28,34,29,42]}
df = pd.DataFrame(data)
print (df)

# Note how the index parameter assigns an index to each row.
import pandas as pd
data = {'Name':['Tom', 'Jack', 'Steve', 'Ricky'],'Age':[28,34,29,42]}
df = pd.DataFrame(data, index=['rank1','rank2','rank3','rank4'])
print (df)

