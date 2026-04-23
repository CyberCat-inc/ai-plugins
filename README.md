# ai-plugins — plugins partagés

Marketplace et plugin compatibles **Cursor** et **Claude Code** à partir d'une
**seule source**. Les composants (skills, hooks, MCP…) vivent une seule fois
dans `plugins/cybercat/` ; chaque outil lit son propre manifest sans
duplication de contenu.

## Contenu actuel

| Composant | Déclencheur |
|---|---|
| `skills/code-review/` | `/code-review` ou « review my changes » |

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
│           └── code-review/SKILL.md
└── README.md
```

## Prérequis

- **Auth Git** : clé SSH ou HTTPS.
- **macOS** ou **Linux** (Bash 4+). Sous **Windows**, utiliser **WSL2** ou **Git Bash** (l'installation utilise des symlinks).
- **Cursor** installé (pour la partie IDE).
- Optionnel : la CLI [`claude`](https://docs.claude.com/en/docs/claude-code/installation) pour installer le plugin côté Claude Code.

### Checklist rapide (nouveau dev)

1. Cloner le repo.
2. Suivre l'[installation manuelle](#installation-manuelle) ci-dessous.
3. Redémarrer Cursor (`Developer: Reload Window`) et tester `/code-review` dans un repo avec des changements non committés.
4. Si tu utilises Claude Code : ouvrir une session `claude` et ajouter la marketplace + installer le plugin (voir plus bas).

## Installation

Clone le repo, puis suis les étapes manuelles pour Cursor et/ou Claude Code.

```bash
git clone <repo-url>
```

Ensuite **redémarre Cursor** (Cmd+Shift+P → `Developer: Reload Window`) et/ou **Claude Code**, puis teste avec `/code-review` dans un repo qui a des modifs non-committées.

### Installation manuelle

**Cursor** — depuis la racine du clone :

```bash
mkdir -p ~/.cursor/plugins/local
ln -s "$(pwd)/plugins/cybercat" ~/.cursor/plugins/local/cybercat
```

**Claude Code** — dans une session `claude` :

```text
/plugin marketplace add /chemin/absolu/vers/ai-plugins
/plugin install cybercat@cybercat
```

## Mises à jour

Quand un changement est poussé (nouveau skill, version bumpée, etc.) :

```bash
cd ai-plugins && git pull
```

- **Cursor** : c'est un symlink, les fichiers mis à jour sont lus à la prochaine commande. Au besoin `Developer: Reload Window`.
- **Claude Code** : `claude plugin marketplace update cybercat`.

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

**Pour tout le monde (sans marketplace)** : le flow manuel `git clone` + installation manuelle reste valide.
