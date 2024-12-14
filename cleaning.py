import pandas as pd

# Chargement des données
data = pd.read_csv("NASDAQ.csv")

print("----------- Avant Nettoyage --------------")
print(data.head())  

# Afficher la structure du jeu de données
print(data.info())

# Afficher un résumé statistique des colonnes numériques
print(data.describe())  

print("----------- Après Nettoyage ----------------")

# Convertir la colonne 'Date' en objet datetime
if 'Date' in data.columns:
    data['Date'] = pd.to_datetime(
        data['Date'], 
        format='%Y-%m-%d', 
        errors='coerce') 
else:
    print("Erreur : La colonne 'Date' est manquante.")
    exit()

# Vérifier les dates manquantes ou invalides et les supprimer
data = data.dropna(subset=['Date'])

# Trier les données par date pour maintenir la continuité temporelle
data = data.sort_values(by='Date')

# Remplacer toutes les valeurs manquantes dans les colonnes numériques
numerical_cols = data.select_dtypes(include=['float64', 'int64']).columns
for col in numerical_cols:
    data[col] = data[col].fillna(0) 

# Supprimer les lignes en double pour éviter les données redondantes
data = data.drop_duplicates()

# Assurer qu'il n'y a pas de lacunes dans la série temporelle 
# en rééchantillonnant à une fréquence régulière
data.set_index('Date', inplace=True)  
# Rééchantillonner à une fréquence quotidienne (D= par jour)
data = data.asfreq('D') 

# Interpolation linéaire des valeurs manquantes
data = data.interpolate(method='linear', limit_direction='both')  

# Après nettoyage : Afficher un résumé du jeu de données nettoyé
print(data.info())  # Structure mise à jour du jeu de données
print(data.dtypes)  # Vérifier les types de données après nettoyage
print(data.head())  # Afficher les premières lignes du jeu de données nettoyé

# Sauvegarder le jeu de données nettoyé dans un nouveau fichier CSV
# Réinitialiser l'index pour enregistrer 'Date' comme colonne dans le CSV
data.reset_index(inplace=True)  
data.to_csv("nasdaq_cleaned.csv", index=False)
print("Le jeu de données nettoyé a été sauvegardé sous 'nasdaq_cleaned.csv'.")
