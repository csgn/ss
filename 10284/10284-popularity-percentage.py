# Popularity Percentage ( 10284 ) ( HARD )
# https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=2
# FIRST APPROACH

import pandas as pd

df = facebook_friends.copy()
df = pd.DataFrame(pd.concat([df['user1'], df['user2']]), columns=[
                  "uid"]).sort_values("uid")
df = df.groupby("uid")["uid"].count().reset_index(name="count")
df["popularity_percentage"] = df["count"] / len(df) * 100

df.reset_index()[["uid", "popularity_percentage"]]

"""
uid	popularity_percent
1	55.556
2	33.333
3	33.333
4	11.111
5	11.111
6	22.222
7	11.111
"""
