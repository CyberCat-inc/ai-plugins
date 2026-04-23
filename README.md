# ai-plugins — plugins partagés CyberCat

Marketplace et plugin compatibles **Cursor** et **Claude Code** à partir d'une
**seule source**. Les composants (skills, hooks, MCP…) vivent une seule fois
dans `plugins/cybercat/` ; chaque outil lit son propre manifest sans
duplication de contenu.

**Repo :** [`gitlab.com/cybercatinc/cybercat/ai-plugins`](https://gitlab.com/cybercatinc/cybercat/ai-plugins) (privé, accès équipe CyberCat)

## Contenu actuel

| Composant | Déclencheur | Source originale |
|---|---|---|
| `skills/code-review/` | `/code-review` ou « review my changes » | Alex Firlot — [`richelieu/crm-api@feature/RICRM-206`](https://gitlab.cybercat.priv/richelieu/crm-api/-/blob/feature/RICRM-206/.cursor/skills/code-review/SKILL.md) |

## Arborescence

```text
ai-plugins/                          # repo = marketplace
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

## Prérequis

- Accès au GitLab.com CyberCat (clé SSH ou token HTTPS configuré) — normalement déjà en place pour tout dev de l'équipe.
- **macOS** ou **Linux** (Bash). Pour Windows, utiliser WSL2 ou Git Bash.
- Optionnel mais recommandé : la CLI [`claude`](https://docs.claude.com/en/docs/claude-code/installation) pour l'intégration automatique dans Claude Code.

## Installation — 2 commandes

```bash
git clone git@gitlab.com:cybercatinc/cybercat/ai-plugins.git
cd ai-plugins && ./install-local.sh
```

Ou en HTTPS si tu préfères :

```bash
git clone https://gitlab.com/cybercatinc/cybercat/ai-plugins.git
cd ai-plugins && ./install-local.sh
```

Le script :

- **Cursor** : symlinke `plugins/cybercat/` vers `~/.cursor/plugins/local/cybercat`.
- **Claude Code** : si la CLI `claude` est présente, ajoute la marketplace locale et installe le plugin automatiquement. Sinon, il t'affiche les deux commandes à taper toi-même dans la session Claude.

Ensuite **redémarre Cursor** (Cmd+Shift+P → `Developer: Reload Window`) et/ou **Claude Code**, puis teste avec `/code-review` dans un repo qui a des modifs non-committées.

### Options du script

```bash
./install-local.sh --cursor      # seulement Cursor
./install-local.sh --claude      # seulement Claude Code
./install-local.sh --uninstall   # tout désinstaller proprement
./install-local.sh --help
```

### Installation manuelle (si le script échoue)

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

Quand un collègue pousse un changement (nouveau skill, version bumpée, etc.) :

```bash
cd ai-plugins && git pull
```

- **Cursor** : c'est un symlink, les fichiers mis à jour sont lus à la prochaine commande. Au besoin `Developer: Reload Window`.
- **Claude Code** : `claude plugin marketplace update cybercat` — ou ré-exécuter `./install-local.sh` qui fait la même chose.

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

## Pourquoi ce setup et pas la Team Marketplace Cursor ?

La Team Marketplace Cursor (dashboard admin → Import) ne supporte pas encore les URLs GitLab privées (testé — échec à l'import). On reste donc sur le flow manuel `git clone + ./install-local.sh`, qui fonctionne identiquement sur Cursor et Claude Code. Le jour où Cursor ajoute le support GitLab ou qu'on miroir le repo sur GitHub, on basculera.
