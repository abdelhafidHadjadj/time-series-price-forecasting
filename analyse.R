# Définir un miroir CRAN
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Installer et charger les packages nécessaires
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

library(dplyr)
library(ggplot2)

# Vérifiez le répertoire de travail actuel

setwd("C:/Users/hadja/Desktop/TP_STAT")
cat("Répertoire de travail actuel:", getwd(), "\n")

# Vérifier que le fichier existe avant de le charger
if ("nasdaq_cleaned.csv" %in% list.files()) {
  data <- read.csv("nasdaq_cleaned.csv")
  cat("Le fichier a été chargé avec succès.\n")
  
  # Vérifier les colonnes disponibles
  cat("Colonnes disponibles :", names(data), "\n")
  
  # Convertir la colonne 'Date' en format Date
  if ("Date" %in% names(data)) {
    data$Date <- as.Date(data$Date, format = "%Y-%m-%d")
  } else {
    stop("La colonne 'Date' est absente du fichier.")
  }
  
  # Afficher les premières lignes pour vérifier les données
  cat("Aperçu des données :\n")
  print(head(data))
} else {
  stop("Le fichier 'nasdaq_cleaned.csv' n'a pas été trouvé dans le répertoire de travail actuel.")
}

# Statistiques descriptives
if (all(c("Open", "Close") %in% names(data))) {
  stats <- data %>%
    summarise(
      mean_open = mean(Open, na.rm = TRUE),
      sd_open = sd(Open, na.rm = TRUE),
      mean_close = mean(Close, na.rm = TRUE),
      sd_close = sd(Close, na.rm = TRUE)
    )
  
  cat("Statistiques descriptives :\n")
  print(stats)
} else {
  stop("Les colonnes 'Open' et/ou 'Close' sont absentes du fichier.")
}

# Visualisation des prix d'ouverture et de fermeture
if ("Date" %in% names(data) && all(c("Open", "Close") %in% names(data))) {
  ggplot(data, aes(x = Date)) +
    geom_line(aes(y = Open, color = "Open"), size = 1) +
    geom_line(aes(y = Close, color = "Close"), size = 1) +
    labs(
      title = "Prix d'ouverture et de fermeture au fil du temps",
      x = "Date",
      y = "Prix"
    ) +
    scale_color_manual(values = c("Open" = "blue", "Close" = "red")) +
    theme_minimal()
} else {
  stop("Les colonnes nécessaires pour la visualisation sont absentes.")
}

