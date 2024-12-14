import qrcode

# L'URL du repository GitHub de votre projet
repo_url = "https://github.com/abdelhafidHadjadj/time-series-price-forecasting"

# Créer un objet QR code
qr = qrcode.QRCode(
    version=1,  # Taille du QR code, de 1 (petit) à 40 (grand)
    error_correction=qrcode.constants.ERROR_CORRECT_L,  # Niveau de correction d'erreurs
    box_size=10,  # Taille des "boîtes" du QR code
    border=4,  # Largeur de la bordure
)

# Ajouter l'URL au QR code
qr.add_data(repo_url)
qr.make(fit=True)

# Créer l'image du QR code
img = qr.make_image(fill='black', back_color='white')

# Sauvegarder l'image
img.save("github_repo_qr_code.png")

# Afficher le QR code
img.show()
