# Djassa

Application e-commerce mobile mettant en relation trois types d'utilisateurs : **client**, **vendeur** et **livreur**. Achat, vente et livraison de produits, avec suivi de commande en temps réel.

## ✨ Fonctionnalités

- **Multi-rôles** : une même app sert le client, le vendeur et le livreur, avec des parcours dédiés à chacun
- **Paiement en ligne** intégré via GeniusPay
- **Suivi de livraison** en temps réel avec cartes animées selon l'étape (préparation, en route, livré...)
- **Comptes utilisateurs** isolés (données scoped par utilisateur, pas de fuite entre comptes)
- **Avis, codes promo et zones de livraison** gérés côté backend

## 🛠️ Stack technique

- **Flutter** — app multiplateforme (Android, iOS, Web, macOS, Linux, Windows)
- **Riverpod** — gestion d'état
- **GoRouter** — navigation
- **Sizer** — UI responsive
- **Supabase** — backend (base de données, authentification, Edge Functions)

## 🚀 Démarrer le projet

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Un projet [Supabase](https://supabase.com) configuré (voir `supabase/`)

### Installation

```bash
git clone https://github.com/kyleerik17/djassa.git
cd djassa
flutter pub get
```

### Configuration

Renseigner les clés Supabase (URL + clé publique) dans la configuration du projet avant de lancer l'app.

### Lancer l'app

```bash
flutter run
```

## 📁 Structure du projet

```
lib/            # Code source de l'application
supabase/       # Schéma, migrations et Edge Functions
test/           # Tests
android/ ios/ web/ macos/ linux/ windows/   # Cibles de build par plateforme
releases/       # Builds publiés
```

## 📌 Statut

Projet en développement actif.

## 📄 Licence

_À définir._
