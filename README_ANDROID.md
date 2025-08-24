# Retour Slog — Android (Kivy)

Version Android de l’assistant de saisie, en **Python/Kivy**.  
Fonctions clés :
- Étapes guidées, **images d’aide sous les champs** (toujours visibles).
- **Saisie en MAJUSCULES**, touche Entrée ⇒ passe à l’étape suivante et met **X** si vide.
- **Boutons “Conclusion” verrouillés** selon l’état :  
  - Cassé/Défectueux ⇒ seul **Destruction** actif.  
  - Remis en stock ⇒ **Destruction** désactivé.  
- **Changement de carton** : lecture du fichier `stock_carton_slog.xlsx` et **déduction** de la quantité (par groupe de 4 premières lettres + emplacement).
- Enregistrement en **Excel (.xlsx)** dans `Documents/RetourSlog` (ou `Download/RetourSlog`).

## Arbo & photos d’aide
Placez vos photos d’aide dans :
```
/photos/photo1.png .. photo11.png
```
ou directement dans le dossier app. Les formats `.png/.jpg/.jpeg/.gif/.webp` sont acceptés.

Correspondance :
- photo1, photo2 → Référence produit
- photo3 → N° commande
- photo4 → N° retour
- photo5..8 → N° suivi
- photo9..11 → Nom client

## Stock cartons
Copiez votre `stock_carton_slog.xlsx` dans :
- `Documents/RetourSlog/` **ou**
- `Download/`

> Le programme cherchera automatiquement dans ces dossiers.
> Format attendu (colonnes A-D) : Référence • (libre) • Emplacement • Quantité

## Construction de l’APK
Pré-requis (Linux/WSL recommandé) :
```
pip install buildozer==1.5.0 cython
sudo apt-get install -y python3-pip git zip unzip openjdk-11-jdk zlib1g-dev
pip install --upgrade pip
```

Dans le dossier du projet (celui de ce ZIP) :
```
buildozer init   # si besoin, déjà fourni
buildozer android debug
```
L’APK sera dans `bin/`. Installez-le sur le téléphone (USB ou partage) :  
```
adb install -r bin/*.apk
```

## Conseils Android (accès fichiers)
- Sur Android 10+, l’accès aux dossiers externes peut demander d’autoriser le stockage à l’installation.
- Si le stock n’est pas détecté, mettez `stock_carton_slog.xlsx` dans **Download** et relancez l’app.
- Vous pouvez changer le dossier par défaut en modifiant `default_save_dir()` dans `main.py`.

## Limitations (MVP)
- Pas de “table Excel” ni formules automatiques (on écrit les valeurs simples).
- Si votre Android bloque l’accès à `Documents/`, l’app basculera sur `Download/RetourSlog`.
- Pour un partage direct (WhatsApp/Email) du fichier Excel, on peut l’ajouter ensuite (intent Android).

Besoin d’un **APK déjà compilé** ou d’un **accès Google Drive/Sheets** au lieu d’Excel ? Dites-le et on ajuste.
