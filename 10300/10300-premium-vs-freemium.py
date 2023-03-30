# Premium vs Freemium ( 10300 ) ( Hard )
# https://platform.stratascratch.com/coding/10300-premium-vs-freemium?code_type=2
# Resources
# https://pandas.pydata.org/docs/reference/api/pandas.pivot_table.html

import pandas as pd

user_df = ms_user_dimension.copy()
acc_df = ms_acc_dimension.copy()
download_df = ms_download_facts.copy()

# FIRST APROACH
paying_df = user_df.merge(acc_df, on="acc_id")[["user_id", "paying_customer"]]

df = paying_df.merge(download_df, on="user_id").sort_values("date")

no = df[df["paying_customer"] == 'no'].groupby(
    "date")["downloads"].sum().reset_index(name="no")
yes = df[df["paying_customer"] == 'yes'].groupby(
    "date")["downloads"].sum().reset_index(name="yes")

res = no.merge(yes, on=["date"])
res[res.no > res.yes]


# SECOND APROACH

df = download_df.merge(user_df)
df = df.merge(acc_df)
df = df.pivot_table(index='date', columns='paying_customer',
                    values='downloads', aggfunc='sum')
df[df['no'] > df['yes']].reset_index()

"""
date	no	yes
2020-08-16 00:00:00	15	14
2020-08-17 00:00:00	45	9
2020-08-18 00:00:00	10	7
2020-08-21 00:00:00	32	17
"""
