# Monthly Percentage Difference ( 10319 ) ( Hard )
# https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=2

# Resources
# https://www.educative.io/answers/how-to-create-lags-and-leads-of-a-column-in-a-pandas-dataframe

import pandas as pd

df = sf_transactions.copy()

df["year_month"] = df['created_at'].agg(
    lambda x: "-".join(str(x).split(" ")[0].split("-")[:2]))

"""
    df.groupby("year_month")["value"]
      .reset_index(name="monthly_revenue")
      .sort_values("year_month")
"""
grouped = df.groupby("year_month") \
            .sum() \
            .reset_index() \
            .sort_values("year_month")[["year_month", "value"]]

grouped['last_month_value'] = grouped['value'].shift(1)
grouped["revenue_diff_pct"] = round(
    ((grouped["value"] - grouped["last_month_value"]) / grouped["last_month_value"]) * 100, 2)

grouped[["year_month", "revenue_diff_pct"]]
