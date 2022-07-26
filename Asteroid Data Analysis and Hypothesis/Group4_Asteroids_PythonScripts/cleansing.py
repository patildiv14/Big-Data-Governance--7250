import pandas as pd
filename = 'asteroid-dataset.csv'
df = pd.read_csv(filename, low_memory=False)

#print num of null values for each column
print(df.isna().sum())

#remove whitespaces in full_name
df['full_name'] = df['full_name'].str.strip()
#remove whitespaces in orbit_id
df['full_name'] = df['orbit_id'].str.strip()

#replace null values with 'unknown'
df['pha'] = df['pha'].fillna('Unknown')

df['neo'] = df['neo'].fillna('Unknown')

df['diameter'] = df['diameter'].fillna('Unknown')

df['H'] = df['H'].fillna('Unknown')

df['moid'] = df['moid'].fillna('Unknown')

#dropping columns not being used
df = df.drop('name', 1)
df = df.drop('spkid', 1)
df = df.drop('albedo', 1)
df = df.drop('prefix', 1)
df = df.drop('epoch', 1)
df = df.drop('epoch_mjd', 1)
df = df.drop('epoch_cal', 1)
df = df.drop('equinox', 1)
df = df.drop('a', 1)
df = df.drop('rms', 1)
df = df.drop('pdes', 1)
df = df.drop('om', 1)
df = df.drop('q', 1)
df = df.drop('w', 1)
df = df.drop('ma', 1)
df = df.drop('ad', 1)
df = df.drop('tp', 1)
df = df.drop('per', 1)
df = df.drop('per_y', 1)
df = df.drop('diameter_sigma', 1)
df = df.drop('tp_cal', 1)
df = df.drop('moid_ld', 1)
df = df.drop('sigma_q', 1)
df = df.drop('sigma_i', 1)
df = df.drop('sigma_om', 1)
df = df.drop('sigma_w', 1)
df = df.drop('sigma_ma', 1)
df = df.drop('sigma_ad', 1)
df = df.drop('sigma_n', 1)
df = df.drop('sigma_tp', 1)
df = df.drop('sigma_per', 1)
df = df.drop('sigma_e', 1)
df = df.drop('sigma_a', 1)

df.duplicated(subset=None, keep='first')

#rows and columns
print(df.shape)

print(df.describe())

df.loc[df["neo"] == "Y", "neo"] = 'Yes'
df.loc[df["neo"] == "N", "neo"] = 'No'
df.loc[df["pha"] == "Y", "pha"] = 'Yes'
df.loc[df["pha"] == "N", "pha"] = 'No'

print(df.columns)

# create a function
def d_cat(diameter):
    if type(diameter) == str:
        return "unknown-size"
    if diameter>=0 and diameter<=24.9999:
        return "small_size"
    elif diameter>=25 and diameter<=99.9999:
        return "medium_size"
    elif diameter>=100:
        return "large_size"
# create a new column based on condition
df['diameter_cat'] = df['diameter'].apply(d_cat)

print(df.columns)
print(df["diameter_cat"])

# create a function
def h_cat(h):
    if type(h) == str:
        return "not_known"
    if h<0:
        return "negative"
    if h>=0 and h<=9.99999999:
        return "low"
    elif h>=10 and h<=19.99999999:
        return "med"
    elif h>=20:
        return "high"
# create a new column based on condition
df['H_cat'] = df['H'].apply(h_cat)


# create a function
def e_cat(e):
    if e>=0 and e<=0.04:
        return "circular"
    elif e>=0.04000001 and e<=1:
        return "elliptical"
    elif e>=1.0000001:
        return "hyperbola"
# create a new column based on condition
df['eccentricity_cat'] = df['e'].apply(e_cat)

# create a function
def i_cat(i):
    if i>=0 and i<=90:
        return "acute"
    elif i>=90.00001:
        return "obtuse"
# create a new column based on condition
df['inclination_cat'] = df['i'].apply(i_cat)

# create a function
def moid_cat(moid):
    if type(moid) == str:
        return "unknown"
    if moid>=0 and moid<=3.18:
        return "small"
    elif moid>=3.180001 and moid<=25:
        return "medium"
    elif moid>=25.00001:
        return "large"
# create a new column based on condition
df['moid_cat'] = df['moid'].apply(moid_cat)

# create a function
def n_cat(n):
    if n>=0 and n<=0.24:
        return "extremely"
    elif n>=0.2400000001 and n<=0.43:
        return "slow"
    elif n>=0.430000001:
        return "fast"
# create a new column based on condition
df['n_cat'] = df['n'].apply(n_cat)


df.rename(columns={"id": "asteroidId", "e": "eccentricity", "i": "inclination"}, inplace=True)

df.to_csv('asteroid-filtered-dataset.csv', index=False)