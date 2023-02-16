# Users By Average Session Time ( 10352 ) ( Medium )
# https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=2

import pandas as pd
import numpy as np

df = facebook_web_log.copy()

filtered_df = df[df['action'].isin(['page_load', 'page_exit'])]

c1 = filtered_df[filtered_df['action'] == 'page_load'][['user_id', 'timestamp']]
c2 = filtered_df[filtered_df['action'] == 'page_exit'][['user_id', 'timestamp']]

merged_df = pd.merge(c1, c2, how="inner", on="user_id")
merged_final_df = merged_df[(merged_df['timestamp_x'] < merged_df['timestamp_y'])]

def to_date(r):
    return pd.to_datetime(r).apply(lambda x: x.date())

merged_final_df['date_x'] = to_date(merged_final_df['timestamp_x'])
merged_final_df['date_y'] = to_date(merged_final_df['timestamp_y'])

grouped_df = (
    merged_final_df
        .groupby(["user_id", "date_x"])
        .agg(load=('timestamp_x', np.max),
             exit=('timestamp_y', np.min))
).reset_index()

grouped_df['session_time'] = grouped_df['exit'] - grouped_df['load']

grouped_df.groupby('user_id')['session_time'].agg(lambda x: np.mean(x)).reset_index()
