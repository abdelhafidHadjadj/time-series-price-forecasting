library(tseries)
library(forecast)
library(forecast)



# Vérifier que le fichier existe avant de le charger
if ("nasdaq_cleaned.csv" %in% list.files()) {
  data <- read.csv("nasdaq_cleaned.csv")
  print(head(data))  # Afficher les premières lignes pour vérifier les données
} else {
  stop("Le fichier 'nasdaq_cleaned.csv' n'a pas été trouvé.")
}

open_data <- data$Open
close_data <- data$Close

summary(open_data)
summary(close_data)

hist(open_data, 
     main="Distribution des prix d'ouverture", 
     xlab="Prix", 
     col="blue")

hist(close_data,
     main = "Distribution des prix de fermeture",
     xlab = "Prix",                               
     col = "green")   


adf.test(close_data)  # Augmented Dickey-Fuller Test
data$Close_diff <- c(NA, diff(data$Close, differences = 1))
head(data)
data <- na.omit(data)
head(data)

# Visualisation après transformation
plot.ts(data$Close_diff, main="Prix de fermeture différenciés", ylab="Prix", col="blue")

#Décomposition de la série temporelle

# Remplacez la fréquence selon vos données
close_ts <- ts(close_data, frequency=30)  

# Décomposition
stl_decomp <- stl(close_ts, s.window="periodic")

# Visualisation
plot(stl_decomp)



# Identification automatique des paramètres ARIMA
arima_model <- auto.arima(close_ts)

# Résumé du modèle
summary(arima_model)

# Visualisation des résidus
checkresiduals(arima_model)



# Division des données en ensemble d’apprentissage et de test
# Taille de l'ensemble d'entraînement
train_size <- round(0.8 * length(close_ts))

# Ensemble d'entraînement : les premiers 'train_size' éléments
train <- close_ts[1:train_size]

# Ensemble de test : les éléments restants après 'train_size'
test <- close_ts[(train_size + 1):length(close_ts)]


# Ajustement du modèle sur les données d'apprentissage
arima_train <- auto.arima(train)

# Prédictions sur l'ensemble de test
forecast_test <- forecast(arima_train, h=length(test))

# Évaluation de la performance
rmse <- sqrt(mean((forecast_test$mean - test)^2))
print(paste("RMSE: ", rmse))

# Prévisions pour 30 jours
future_forecast <- forecast(arima_model, h=30)  
plot(future_forecast)

# Intervalles de confiance inclus dans le graphique

print(future_forecast)
predictions <- future_forecast$mean
print(predictions)  # Afficher les prix prédits

write.csv(data.frame(future_forecast), "prix_predictifs.csv", row.names = FALSE)






