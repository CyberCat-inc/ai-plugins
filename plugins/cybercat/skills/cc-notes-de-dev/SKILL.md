---
name: cc-notes-de-dev
description: Produit des notes de développement courtes et directement utilisables. Utiliser quand l'utilisateur demande de rédiger ou réviser des notes de développement à partir d'un billet, d'une évaluation, ou du contexte projet disponible.
---

# Skill cc-notes-de-dev

Ce skill sert à produire des notes de développement courtes, concrètes et directement utilisables. Les notes doivent transmettre au dev les pointeurs de cohérence projet qu'il ne peut pas deviner facilement.

## Instructions

Quand l'utilisateur demande des notes de développement (par ex. via `/cc-notes-de-dev` ou en demandant « rédige les notes de développement »), suis ces étapes :

1.  **Lire le contexte disponible** :
    - Utilise le billet Jira courant, ses critères d'acceptation et son contexte disponible comme source principale.
    - Utilise une évaluation existante comme contexte complémentaire si elle est fournie, sans présumer de sa provenance.
    - Utilise le repo et les conventions disponibles quand ils sont accessibles.
    - Si le contexte projet ou repo n'est pas accessible, indique la limite seulement si elle change la qualité des notes.
    - Ne refais pas l'analyse complète du billet et ne reprends pas d'estimation, de complexité ou de table d'heures dans les notes.
2.  **Extraire les pointeurs projet utiles** :
    - Identifie les noms exacts utiles : routes, classes, méthodes/actions, composants, formulaires ou requêtes, modèles, relations, champs, données d'entrée/sortie et conventions nommées du projet.
    - Signale les patterns, composants, relations, champs ou mécanismes existants à réutiliser quand c'est pertinent.
    - Mentionne les commandes ou scaffolds seulement quand ils sont une convention projet utile.
    - Ne produis pas une liste exhaustive de fichiers.
3.  **Capturer les décisions et gotchas** :
    - Note les décisions à ne pas manquer : réutiliser un mécanisme existant, ne pas créer une nouvelle structure, respecter un hors-scope, ou suivre une convention déjà établie.
    - Note seulement les pièges métier ou techniques courts, concrets et liés au billet ou au projet : règles métier, permissions, feature flags, états ou statuts, calculs métier, données existantes, comportements de sécurité, hors-scope explicite, ou autre contrainte vérifiable.
    - Évite les rappels génériques qui pourraient s'appliquer à n'importe quel billet.
    - Si plusieurs solutions sont possibles, garde seulement la décision recommandée et une justification courte.
4.  **Identifier les dépendances** :
    - Mentionne les billets, travaux préalables, migrations, routes, pages, epics ou mécanismes existants dont le développement dépend.
    - Ne refais pas l'évaluation de l'épic.
5.  **Ajouter un snippet seulement si nécessaire** :
    - Ajoute un snippet court uniquement s'il désambiguïse une convention, une route, une relation, un champ à transmettre ou une mécanique difficile à visualiser.
    - Évite les gros blocs SQL, PHP ou JavaScript.
6.  **Rapporter les notes** :
    - Réponds dans la langue de l'utilisateur.
    - Garde les notes concises et directement utilisables comme notes de développement.
    - Omet les sections vides.
    - Réponds `N/A` si les notes n'ajoutent rien de concret au billet.
    - Ne mentionne aucun secret, URL privée, client, identifiant interne sensible ou détail non publiable.

## Format de rapport exemple

Format avec sections, pour un billet qui a plusieurs pointeurs utiles :

```markdown
## Notes de développement

### Pointeurs projet
- Routes / classes :
- Méthodes / actions :
- Composants / formulaires / requêtes :
- Données / relations / champs :

### Gotchas / décisions
- ...

### Dépendances
- ...

### Snippet utile
...
```

Format barebone, pour un billet plus petit :

```markdown
## Notes de développement

- Route `...`
- Classe / méthode `...`
- Convention nommée `...`
- Pattern existant à réutiliser `...`
```

Si rien n'ajoute de valeur :

```markdown
## Notes de développement

N/A
```

## Règles

- Ne pas inclure d'estimation de temps ni de niveau de complexité.
- Ne pas produire de plan de code détaillé.
- Ne pas produire de checklist d'implémentation exhaustive ni de pseudo-plan de code.
- Ne pas produire de table de tâches avec heures.
- Ne pas réécrire les critères d'acceptation.
- Ne pas ajouter de scénarios de test détaillés par défaut.
- Ne pas inclure de gros blocs de code; préférer un snippet court quand il clarifie une convention ou une mécanique.
- Utiliser les vrais termes du framework et du projet quand ils sont connus.
- Combiner cohérence avec l'existant et respect des bonnes pratiques; adapter selon le contexte plutôt qu'appliquer l'un ou l'autre mécaniquement.
