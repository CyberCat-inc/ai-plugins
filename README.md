# ai-plugins — plugins partagés CyberCat

Marketplace et plugin compatibles **Cursor** et **Claude Code** à partir d'une
**seule source**. Les composants (skills, hooks, MCP…) vivent une seule fois
dans `plugins/cybercat/` ; chaque outil lit son propre manifest sans
duplication de contenu.

**Source canonique (public, GitHub Free) :** [`github.com/CyberCat-inc/ai-plugins`](https://github.com/CyberCat-inc/ai-plugins) — pour le clone, Cursor Team Marketplace et la soumission marketplace Cursor.

**Miroir interne (privé) :** [`gitlab.com/cybercatinc/cybercat/ai-plugins`](https://gitlab.com/cybercatinc/cybercat/ai-plugins) — même contenu ; utile si GitHub est indisponible ou pour les workflows GitLab-only.

## Contenu actuel

| Composant | Déclencheur | Source originale |
|---|---|---|
| `skills/code-review/` | `/code-review` ou « review my changes » | Alex Firlot — [`richelieu/crm-api@feature/RICRM-206`](https://gitlab.cybercat.priv/richelieu/crm-api/-/blob/feature/RICRM-206/.cursor/skills/code-review/SKILL.md) |

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
├── install-local.sh                 # installer universel (Cursor + Claude Code)
└── README.md
```

## Prérequis

- **Depuis GitHub (recommandé)** : aucun compte requis pour **cloner** un dépôt **public** ; une clé SSH ou HTTPS suffit.
- **Depuis GitLab (miroir privé)** : être membre du groupe avec au moins le rôle **Developer** sur [`cybercatinc/cybercat/ai-plugins`](https://gitlab.com/cybercatinc/cybercat/ai-plugins).
- **Auth Git** : clé SSH ou HTTPS (PAT `read_repository` suffit pour un clone privé ; `api` si tu utilises `glab`).
- **macOS** ou **Linux** (Bash 4+). Sous **Windows**, utiliser **WSL2** ou **Git Bash** (le script utilise des symlinks).
- **Cursor** installé (pour la partie IDE).
- Optionnel mais recommandé : la CLI [`claude`](https://docs.claude.com/en/docs/claude-code/installation) pour que `./install-local.sh` enregistre automatiquement la marketplace Claude Code.

### Checklist rapide (nouveau dev)

1. Cloner depuis **GitHub** (public) ou **GitLab** (privé, si tu as accès).
2. `cd ai-plugins && ./install-local.sh`
3. Redémarrer Cursor (`Developer: Reload Window`) et tester `/code-review` dans un repo avec des changements non committés.
4. Si tu utilises Claude Code : ouvrir une session `claude` et vérifier que `/code-review` répond (ou suivre les deux lignes affichées par le script si la CLI `claude` était absente au moment de l’install).

## Installation — 2 commandes

**GitHub (défaut)** :

```bash
git clone git@github.com:CyberCat-inc/ai-plugins.git
cd ai-plugins && ./install-local.sh
```

HTTPS :

```bash
git clone https://github.com/CyberCat-inc/ai-plugins.git
cd ai-plugins && ./install-local.sh
```

**GitLab (miroir interne)** :

```bash
git clone git@gitlab.com:cybercatinc/cybercat/ai-plugins.git
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

Après un changement, bumpe `version` dans **les quatre** fichiers de version :

- `.claude-plugin/marketplace.json` (`metadata.version`)
- `.cursor-plugin/marketplace.json` (`metadata.version`)
- `plugins/cybercat/.claude-plugin/plugin.json`
- `plugins/cybercat/.cursor-plugin/plugin.json`

Sans bump côté Claude Code, les clients gardent l’ancienne version en cache.

## Cursor Team Marketplace (org)

Le dépôt GitHub public contient [`.cursor-plugin/marketplace.json`](https://github.com/CyberCat-inc/ai-plugins/blob/main/.cursor-plugin/marketplace.json) à la racine, comme le [référentiel Cursor](https://cursor.com/docs/reference/plugins.md#multi-plugin-repositories) l’exige pour un repo **multi-plugins**.

**Pour un admin Cursor (plan Teams / Enterprise)** : Dashboard → Settings → Plugins → **Team Marketplaces** → **Import** → coller :

`https://github.com/CyberCat-inc/ai-plugins`

Ensuite assigner le plugin **cybercat** aux groupes (requis ou optionnel) et enregistrer.

**Pour tout le monde (sans marketplace)** : le flow manuel `git clone` + `./install-local.sh` reste valide et identique que le clone vienne de GitHub ou de GitLab.

## GitLab privé

L’import Team Marketplace Cursor vers **GitLab** (URL privée) a été testé sans succès. Le miroir GitLab reste disponible pour clone interne et pour les workflows qui restent sur GitLab ; la découverte Cursor passe par **GitHub**.
