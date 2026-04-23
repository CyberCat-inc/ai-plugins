---
name: cc-code-review
description: Reviews uncommitted code changes (or a branch comparison) against SOLID, DRY, Clean Code, and the project / language / framework standards in use. Use when the user types /cc-code-review (alias /review) or asks to review their code.
---

# Skill cc-code-review

Ce skill permet à l'agent d'effectuer une revue de code complète des changements non committés (staged et unstaged).

## Instructions

Quand l'utilisateur demande une revue (par ex. via `/cc-code-review`, l'alias `/review`, ou en demandant « review my changes »), suis ces étapes :

1.  **Récupérer les changements** :
    - Exécute `git diff -w HEAD` pour récupérer les modifications des fichiers trackés (en ignorant les whitespaces).
    - Exécute `git ls-files --others --exclude-standard` pour trouver les fichiers untracked (nouveaux).
    - Lis le contenu de tous les fichiers untracked découverts.
    - Si aucun changement staged ou uncommitted n'est trouvé (les deux commandes retournent vide), demande à l'utilisateur quelles branches il veut comparer (par ex. `feature-branch` vs `main`). Ensuite, exécute `git diff -w <base>...<target>` pour récupérer les changements entre ces branches et procède à la revue.
2.  **Analyser le code** : Revois systématiquement les changements selon les critères suivants :
    *   **Principes SOLID** : Vérifie que Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation et Dependency Inversion sont respectés.
    *   **Principe DRY** : Identifie toute duplication de logique inutile.
    *   **Clean Code** : Évalue les conventions de nommage, la taille des fonctions, la lisibilité et la structure globale.
    *   **Standards du projet / langage / framework** : Vérifie que le code suit les conventions et les best practices propres au projet, au langage de programmation et au framework utilisé (par ex. patterns idiomatiques, style guides, recommandations officielles du framework).
3.  **Rapporter les problèmes** : Numérote chaque problème séquentiellement (à partir de `#1`) pour l'ensemble du rapport, afin que l'utilisateur puisse y référer dans le chat (par ex. « fix #3 »). Pour chaque problème identifié, fournis :
    *   **Problème** : Une explication claire de ce qui cloche et pourquoi.
    *   **Emplacement** : Le chemin du fichier et les numéros de ligne approximatifs.
    *   **Solution** : Un exemple de code concret ou une suggestion de refactor pour corriger le problème.

## Exemples

**Utilisateur** : /cc-code-review
**Agent** : *Exécute `git diff HEAD` et `git ls-files --others --exclude-standard`, lit les nouveaux fichiers, analyse le tout et fournit un rapport structuré.*

### Format de rapport exemple :

**Fichier : `src/services/UserService.ts`**
*   **#1 🔴 Problème (SOLID/SRP)** : La fonction `updateUser` gère aussi les notifications par courriel.
    *   **Solution** : Extraire la logique de notification dans un `NotificationService` dédié.
*   **#2 🟡 Problème (TypeScript)** : Le paramètre `data` dans `processUser` est typé `any`.
    *   **Solution** : Définir une interface `UserData` et l'utiliser pour le paramètre `data`.
