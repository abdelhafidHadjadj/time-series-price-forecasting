import pandas as pd

data = pd.read_csv("CAC40.csv")
print("------------------------------------------------ Avant Nettoyage -----------------------------------------------")
print(data.head())
print(data.info())       # Structure des données
print(data.describe())   # Résumé statistique de chaque colonne
# ---------------------- Début de traitement ---------------------------
print("------------------------------------------------ Aprés Nettoyage ---------------------------------------------------")
data['Date'] = pd.to_datetime(data['Date'], format='%Y-%m-%d') 
data = data[data['Volume'] > 0]  # Supprimer les lignes où Volume = 0
data = data.drop_duplicates() # Remove duplicates data
print(data.info())
print(data.dtypes)  # Vérifier si tout est correct
print(data.head())
data.to_csv("cleaned_data.csv", index=False)