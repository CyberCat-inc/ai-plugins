# ai-plugins — plugins partagés

Marketplace et plugin compatibles **Cursor** et **Claude Code** à partir d'une
**seule source**. Les composants (skills, hooks, MCP…) vivent une seule fois
dans `plugins/cybercat/` ; chaque outil lit son propre manifest sans
duplication de contenu.

## Contenu actuel

| Composant | Déclencheur |
|---|---|
| `skills/cc-code-review/` | `/cc-code-review` (alias `/review`) ou « review my changes » |

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
│           └── cc-code-review/SKILL.md
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

Le plugin est installé. Teste dans un repo avec des modifs non committées avec `/cc-code-review` (alias `/review`).

### Cursor

1. Ouvre **Settings → Plugins**.
2. Va dans l'onglet **Marketplaces**.
3. Clique **Add marketplace** et colle `https://github.com/CyberCat-inc/ai-plugins`.
4. Retourne dans l'onglet **Discover**, sélectionne **cybercat** puis clique **Install**.
5. Recharge la fenêtre via la command palette (`Developer: Reload Window`).

Teste avec `/cc-code-review` dans un repo avec des modifs non committées.

> Pour les orgs Cursor (Teams / Enterprise) : un admin peut aussi importer le repo dans le **Team Marketplace** (voir plus bas), auquel cas l'étape 3 est déjà faite et il suffit d'activer **cybercat**.

## Mises à jour

Les nouvelles versions sont distribuées automatiquement par le marketplace.

- **Claude Code** : dans `/plugins → Marketplaces`, sélectionne **cybercat** et appuie sur `u` pour update.
- **Cursor** : recharge la fenêtre (`Developer: Reload Window`) ; le marketplace resynchronise.

## Ajouter un composant

Tout se passe **à l'intérieur de `plugins/cybercat/`**, à côté de `skills/` :

| Je veux ajouter… | Je crée… | Cursor | Claude Code |
|---|---|:-:|:-:|
| Un skill | `skills/<nom>/SKILL.md` | ✓ | ✓ |
| Une slash-command | `commands/<nom>.md` | ✓ | ✓ |
| Un hook | `hooks/hooks.json` + scripts | ✓ | ✓ |
| Un serveur MCP | `.mcp.json` (racine plugin) | ✓ | ✓ |
| Une rule | `rules/<nom>.mdc` | ✓ | — |
| Un subagent | `agents/<nom>.md` | ✓ | ✓ |

Après un changement, bumpe `version` dans **les quatre** fichiers de version :

- `.claude-plugin/marketplace.json` (`metadata.version`)
- `.cursor-plugin/marketplace.json` (`metadata.version`)
- `plugins/cybercat/.claude-plugin/plugin.json`
- `plugins/cybercat/.cursor-plugin/plugin.json`

Sans bump côté Claude Code, les clients gardent l'ancienne version en cache.

## Cursor Team Marketplace (org)

Le dépôt contient `.cursor-plugin/marketplace.json` à la racine, comme le [référentiel Cursor](https://cursor.com/docs/reference/plugins.md#multi-plugin-repositories) l'exige pour un repo **multi-plugins**.

**Pour un admin Cursor (plan Teams / Enterprise)** : Dashboard → Settings → Plugins → **Team Marketplaces** → **Import** → coller l'URL du repo, puis assigner le plugin **cybercat** aux groupes (requis ou optionnel) et enregistrer.
