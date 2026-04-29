# ai-plugins — plugins partagés

Marketplace et plugin compatibles **Cursor** et **Claude Code** à partir d'une
**seule source**. Les composants (skills, hooks, MCP…) vivent une seule fois
dans `plugins/cybercat/` ; chaque outil lit son propre manifest sans
duplication de contenu.

## Contenu actuel

| Composant | Déclencheur |
|---|---|
| `skills/cc-code-review/` | `/cc-code-review` (alias `/review`) ou « review my changes » |
| `skills/cc-notes-de-dev/` | `/cc-notes-de-dev` ou « rédige les notes de développement » |

## Arborescence

```text
ai-plugins/                          # repo = marketplace
├── .claude-plugin/
│   └── marketplace.json             # catalogue Claude Code
├── .cursor-plugin/
│   └── marketplace.json             # catalogue Cursor (multi-plugins)
├── plugins/
│   └── cybercat/                    # le plugin lui-même
│       ├── .claude-plugin/plugin.json
│       ├── .cursor-plugin/plugin.json
│       └── skills/
│           ├── cc-code-review/SKILL.md
│           └── cc-notes-de-dev/SKILL.md
└── README.md
```

## Prérequis

- **Cursor** (pour l'IDE) et/ou **Claude Code** CLI (voir [installation de `claude`](https://docs.claude.com/en/docs/claude-code/installation)).

## Installation

L'installation se fait entièrement via le Marketplace intégré de chaque outil. URL du repo à coller :

```
https://github.com/CyberCat-inc/ai-plugins
```

### Claude Code

1. Lance `claude` dans ton terminal.
2. Tape `/plugins`.
3. Va dans l'onglet **Marketplaces**.
4. Choisis **+ Add Marketplace** et colle `https://github.com/CyberCat-inc/ai-plugins`.
5. Va dans l'onglet **Discover**, sélectionne **cybercat**.
6. Sur l'écran de détails, choisis **Install for you (user scope)**.

Le plugin est installé. Teste dans un repo avec des modifs non committées avec `/cc-code-review` (alias `/review`), ou avec un billet à documenter via `/cc-notes-de-dev`.

### Cursor

Le plugin est déjà disponible pour tous les utilisateurs Cursor de CyberCat.

1. Ouvre **Settings → Plugins**.
2. Dans l'onglet **Discover**, sélectionne **cybercat** puis clique **Install**.
3. Recharge la fenêtre via la command palette (`Developer: Reload Window`).

Teste avec `/cc-code-review` dans un repo avec des modifs non committées, ou avec un billet à documenter via `/cc-notes-de-dev`.

## Mises à jour

Les nouvelles versions sont distribuées automatiquement par le marketplace.

- **Claude Code** : dans `/plugins → Marketplaces`, sélectionne **cybercat** et appuie sur `u` pour update.
- **Cursor** : recharge la fenêtre (`Developer: Reload Window`) ; le marketplace resynchronise.
