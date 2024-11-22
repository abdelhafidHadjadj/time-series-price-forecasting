# Time Series Price Forecasting

## Description du Projet

Ce projet a pour objectif de nettoyer, analyser et modéliser des séries temporelles basées sur les prix historiques. Les étapes incluent le nettoyage des données, l'analyse statistique, la décomposition des séries temporelles et la prévision des prix futurs à l'aide d'un modèle ARIMA.

---

## Structure du Projet

### 1. Fichiers et Scripts
- **`NASDAQ.csv` et `CAC40.csv`** : Fichiers de données brutes contenant les informations de séries temporelles.
- **`cleaning.py`** : Script Python pour nettoyer les données.
- **`analyse.r`** : Script R pour analyser les données nettoyées et produire des statistiques descriptives et des visualisations.
- **`arma.r`** : Script R pour modéliser les séries temporelles à l'aide d'ARIMA et effectuer des prévisions.

---

## Étapes et Explications

### 1. Nettoyage des Données (`cleaning.py`)
Le script effectue les tâches suivantes :
- **Chargement des données** avec `pandas`.
- **Nettoyage** :
  - Suppression des lignes où le volume est nul.
  - Suppression des doublons.
- **Conversion des dates** en format `datetime`.
- **Enregistrement des données nettoyées** dans `cleaned_data.csv`.

#### Exemple de sortie
Avant nettoyage :
Aprés nettoyage :


---

### 2. Analyse des Données (`analyse.r`)
Les étapes suivantes sont réalisées :
- **Chargement des données nettoyées** et vérification.
- **Statistiques descriptives** des prix d'ouverture et de fermeture.
- **Visualisation des données** :
  - Graphique des prix d'ouverture et de fermeture au fil du temps à l'aide de `ggplot2`.

#### Exemple de visualisation
Un graphique linéaire montrant l'évolution des prix au fil du temps.

---

### 3. Modélisation ARIMA (`arma.r`)
Les étapes incluent :
1. **Préparation des données** :
   - Vérification de la stationnarité avec le test ADF.
   - Transformation des séries temporelles pour les rendre stationnaires.
2. **Décomposition des séries temporelles** :
   - Extraction de la tendance, saisonnalité, et résidu.
3. **Construction du modèle ARIMA** :
   - Identification automatique des paramètres avec `auto.arima`.
   - Ajustement du modèle sur un ensemble d'apprentissage.
4. **Prévision** :
   - Évaluation du modèle avec RMSE sur l'ensemble de test.
   - Prévision des prix futurs pour 30 jours avec intervalles de confiance.

#### Exemple de sortie
- **Résumé du modèle ARIMA** :
- **RMSE** :
- **Graphiques** :
  - Série temporelle différenciée.
  - Résultats de la décomposition STL.
  - Prévisions futures avec intervalles de confiance.

---

## Instructions pour l'Exécution

### 1. Prérequis
- Python 3.x
- R et RStudio
- Bibliothèques nécessaires :
  - Python : `pandas`
  - R : `dplyr`, `ggplot2`, `tseries`, `forecast`

### 2. Exécution
1. **Nettoyage des données** :
   ```bash
   python cleaning.py
