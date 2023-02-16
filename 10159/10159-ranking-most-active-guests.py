# Ranking Most Active Guests ( 10159 ) ( Medium )
# https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?code_type=2

# Resources
# https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html
# https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.rank.html

import pandas as pd
        
df = (airbnb_contacts
        .groupby('id_guest')['n_messages']
        .sum()
        .reset_index()
        .sort_values(by=['n_messages', 'id_guest'],
                     ascending=[False, True]))
                     
df["ranking"] = df["n_messages"].rank(method="dense",
                                      ascending=False)
df

# OUTPUT
# ranking  id_guest                               sum_n_messages
# -------- -------------------------------------  --------------
# 1			882f3764-05cc-436a-b23b-93fea22ea847	20
# 1			62d09c95-c3d2-44e6-9081-a3485618227d	20
# 2			b8831610-31f2-4c58-8ada-63b3601ca476	17
# 2			91c2a883-04e3-4bbb-a7bb-620531318ab1	17
# 3			6133fb99-2391-4d4b-a077-bae40581f925	16
# ...
