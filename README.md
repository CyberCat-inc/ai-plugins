# cybercat — plugin partagé CyberCat

Marketplace et plugin compatibles **Cursor** et **Claude Code** à partir d'une
**seule source**. Les composants (skills, hooks, MCP…) vivent une seule fois
dans `plugins/cybercat/` ; chaque outil lit son propre manifest sans
duplication de contenu.

## Contenu actuel

| Composant | Déclencheur | Source originale |
|---|---|---|
| `skills/code-review/` | `/code-review` ou « review my changes » | Alex Firlot — [`richelieu/crm-api@feature/RICRM-206`](https://gitlab.cybercat.priv/richelieu/crm-api/-/blob/feature/RICRM-206/.cursor/skills/code-review/SKILL.md) |

## Arborescence

```text
cybercat-plugin/                     # repo = marketplace
├── .claude-plugin/
│   └── marketplace.json             # catalogue Claude Code
├── plugins/
│   └── cybercat/                    # le plugin lui-même
│       ├── .claude-plugin/plugin.json
│       ├── .cursor-plugin/plugin.json
│       └── skills/
│           └── code-review/SKILL.md
├── install-local.sh                 # installer universel (Cursor + Claude Code)
└── README.md
```

## Installation (universelle, zéro config)

Clone où tu veux, lance le script, c'est tout. Aucun chemin à adapter.

```bash
git clone <repo-url> cybercat-plugin
cd cybercat-plugin
./install-local.sh
```

Le script :

- **Cursor** : symlinke `plugins/cybercat/` vers `~/.cursor/plugins/local/cybercat`.
- **Claude Code** : si la CLI `claude` est disponible, ajoute automatiquement la
  marketplace locale et installe le plugin. Sinon, il t'affiche les deux
  commandes à taper dans la CLI Claude.

Ensuite **redémarre Cursor** (`Developer: Reload Window`) et/ou **Claude Code**,
puis teste avec `/code-review` dans un repo qui a des modifs non-committées.

### Options

```bash
./install-local.sh --cursor      # seulement Cursor
./install-local.sh --claude      # seulement Claude Code
./install-local.sh --uninstall   # tout désinstaller proprement
./install-local.sh --help
```

### Installation manuelle (si besoin)

**Cursor** — depuis la racine du clone :

```bash
ln -s "$(pwd)/plugins/cybercat" ~/.cursor/plugins/local/cybercat
```

**Claude Code** — dans la CLI `claude` :

```text
/plugin marketplace add <chemin-absolu-du-clone>
/plugin install cybercat@cybercat
```

## Distribuer à l'équipe

1. Push ce repo sur GitLab CyberCat (ou GitHub).
2. Tes collègues font :

   ```bash
   git clone <repo-url> && cd cybercat-plugin && ./install-local.sh
   ```

3. **Mises à jour** : après un `git pull`, Cursor recharge automatiquement
   (symlink). Pour Claude Code, `claude plugin marketplace update cybercat`
   suffit — ou re-lance `./install-local.sh` qui fait la même chose.

### Distribution sans cloner (optionnel, plus tard)

Une fois le repo hébergé, on pourra aussi installer directement depuis GitLab :

```text
# dans Claude Code
/plugin marketplace add https://gitlab.cybercat.priv/<group>/cybercat-plugin.git
/plugin install cybercat@cybercat
```

Et côté Cursor, soumettre le repo à la marketplace officielle ou à une
**team marketplace** (Teams/Enterprise) pour de la distribution en un clic.

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

Après un changement, bumpe `version` dans **les trois** manifests :

- `.claude-plugin/marketplace.json`
- `plugins/cybercat/.claude-plugin/plugin.json`
- `plugins/cybercat/.cursor-plugin/plugin.json`

Sans bump, Claude Code garde l'ancienne version en cache côté clients.
