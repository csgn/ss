# Number Of Units Per Nationality ( 10156 ) ( Medium )
# https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=2

# Import your libraries
import pandas as pd

# Start writing code
airbnb_hosts.head()

df1 = airbnb_hosts.copy()
df2 = airbnb_units.copy()


apartments_df = df2[df2['unit_type'] == 'Apartment']
age_under_30_df = df1[df1['age'] < 30]

merged = pd.merge(age_under_30_df,
         apartments_df,
         how="inner",
         on="host_id")
         
(merged.groupby(['nationality'])['unit_id']
      .nunique()
      .to_frame('apartment_count')
      .reset_index()
      .sort_values('apartment_count'))
