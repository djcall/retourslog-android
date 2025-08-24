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

## Construction rapide de l’APK

### Option A — **Docker (recommandé, simple)**
1. Installe Docker Desktop (Windows/Mac) ou `docker.io` (Linux).
2. Ouvre un terminal **dans le dossier du projet** (celui contenant `main.py`).
3. Lance :
   ```bash
   ./build_apk_docker.sh
   ```
4. L’APK apparaît dans `./bin/`.

### Option B — **GitHub Actions (CI)**
1. Crée un dépôt GitHub et pousse-y ces fichiers.
2. Dans GitHub, onglet **Actions** → le workflow **Build Android APK** se lance automatiquement (ou lance-le à la main).
3. Récupère l’APK dans **Actions** → **Artifacts** → `retourslog-apk`.

### Option C — **Local (WSL/Ubuntu)**
```bash
pip install buildozer==1.5.0 cython
sudo apt-get install -y openjdk-11-jdk zlib1g-dev
buildozer android debug
```
APK dans `bin/`.

### Installation sur le téléphone
- Active **Sources inconnues** / **Autoriser cette source**.
- Copie l’APK sur le téléphone et installe-le.
- Au premier lancement, autorise l’accès **Stockage**.

### Notes Android
- Si l’app ne voit pas `stock_carton_slog.xlsx`, mets-le dans **Download** et relance.
- Dossier de sortie Excel : `Documents/RetourSlog/` (sinon `Download/RetourSlog/`).



## Build rapide avec Docker (recommandé)

1) Installe **Docker Desktop** (Windows) ou **Docker** (Linux/Mac).
2) Dans ce dossier, lance :
   - Linux/Mac :
     ```bash
     chmod +x docker_build_apk.sh
     ./docker_build_apk.sh
     ```
   - Windows :
     Double-clique `docker_build_apk.bat`

L’APK sort dans `./bin/` (debug).

## Build via GitHub Actions (sans rien installer)

1) Crée un dépôt GitHub et pousse ces fichiers.
2) Va dans **Actions** → active les workflows → lance **Build Android APK** (workflow_dispatch).
3) Récupère l’artefact `RetourSlog-android-debug-apk` (le .apk est dedans).

> Signature *debug* automatique (ok pour tester et installer sur un téléphone). Pour une **release** signée Play Store, je te fournis le script keystore dès que tu veux.
