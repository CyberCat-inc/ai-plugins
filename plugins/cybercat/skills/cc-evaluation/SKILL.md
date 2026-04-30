---
name: cc-evaluation
description: Évalue l'effort et le temps requis pour un billet Jira de développement avant les notes de dev ou la planification. Utiliser quand l'utilisateur demande d'analyser un billet, découper le scope, estimer le temps et la complexité, identifier les dépendances, bloquants, risques ou préparer la matière pour cc-notes-de-dev.
---

# Skill cc-evaluation

Ce skill sert d'abord à produire une estimation courte et fondée de l'effort et du temps requis pour un billet avant les notes de dev. Il explique les sous-éléments, hypothèses, incertitudes et risques qui influencent cette estimation, puis prépare la matière utile pour `cc-notes-de-dev`, sans rédiger la note finale ni produire un plan d'implémentation détaillé.

## Instructions

Quand l'utilisateur demande d'évaluer un billet (par ex. via `/cc-evaluation` ou en demandant « évalue ce billet »), suis ces étapes :

1.  **Lire le contexte disponible** :
    - Lis le billet Jira comme source principale quand un identifiant est fourni et que Jira est accessible.
    - Si Jira n'est pas accessible, travaille à partir du contenu fourni et indique cette limite.
    - Utilise aussi le résumé, la description, les critères d'acceptation, l'épic complet, les billets liés, le repo et les conventions disponibles.
    - Quand l'épic ou les billets liés sont accessibles, repère les dépendances, bloquants ou conflits potentiels entre billets.
    - Si une source utile n'est pas accessible, indique la limite explicitement.
    - Sépare ce qui est écrit dans le billet de ce qui est une hypothèse.
2.  **Définir le scope** :
    - Résume le but métier ou utilisateur.
    - Classe le travail : bug, récit, refactor, dette, intégration, UI, backend ou mixte.
    - Identifie les éléments hors-scope ou ambigus.
3.  **Découper le travail** :
    - Liste les sous-éléments orientés résultat, pas seulement les fichiers à modifier.
    - Note les dépendances entre sous-éléments quand elles existent.
    - Garde le découpage assez court pour servir d'intrant bref à `cc-notes-de-dev`.
4.  **Estimer l'effort et qualifier la complexité** :
    - Donne une estimation de temps totale et par sous-élément quand c'est raisonnablement possible.
    - Nomme les hypothèses utilisées pour estimer l'effort.
    - Si le contexte ne permet pas d'estimer le temps avec confiance, indique pourquoi et quelles informations manquent.
    - Donne une complexité `faible`, `moyenne` ou `élevée` pour chaque sous-élément comme appui à l'estimation.
    - Justifie chaque cote en une phrase.
5.  **Identifier les risques** :
    - Liste les dépendances, bloquants confirmés, conflits entre billets de l'épic, risques possibles, migrations, permissions, feature flags, impacts UI/API et compatibilité de données.
    - Mentionne les besoins de tests seulement lorsqu'un risque technique précis n'est pas déjà couvert par les critères d'acceptation.
    - Évite les avertissements génériques non liés au billet ou au code observé.
6.  **Rapporter l'évaluation** :
    - Réponds dans la langue de l'utilisateur.
    - Reste concis, factuel et traçable.
    - Ne mentionne aucun secret, URL privée, client, identifiant interne sensible ou détail non publiable.
    - Ne rédige pas les notes de dev finales et ne produis pas un plan de code détaillé.

## Format de rapport exemple

```markdown
# Évaluation

## Résumé
- But :
- Type de travail :
- Confiance :

## Sous-éléments
- **...** — complexité : faible/moyenne/élevée. Estimation : ... si possible. Raison :

## Estimation
- Total :
- Par sous-élément :
- Hypothèses :
- Incertitudes / limites :

## Dépendances et bloquants
- Confirmés :
- Possibles :

## Risques et points d'attention
- ...

## Questions ouvertes
- ...

## Intrants éventuels pour cc-notes-de-dev
- Sous-éléments à reprendre :
- Dépendances, bloquants ou décisions à reprendre :
- Termes ou conventions à préserver :
```

## Règles

- Ne pas inventer du contexte Jira, produit ou codebase manquant.
- Ne pas inclure de snippets de code pendant l'évaluation. Signaler seulement si un exemple pourrait être utile plus tard pour un concept complexe ou inhabituel.
- Utiliser les vrais termes du framework et du projet quand ils sont connus.
- Si plusieurs approches sont possibles, nommer les options et recommander la meilleure avec une justification courte.
- Combiner cohérence avec l'existant et respect des bonnes pratiques; adapter selon le contexte plutôt qu'appliquer l'un ou l'autre mécaniquement.
- Ne pas produire d'arborescence exhaustive ou de liste autonome de fichiers impactés; nommer les impacts seulement s'ils expliquent un sous-élément, une dépendance ou un risque.
