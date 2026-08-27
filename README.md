# Code source du mémoire - LOMPO Abdoul Karim

[![MATLAB](https://img.shields.io/badge/MATLAB-R2024a-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-blue.svg)](https://github.com/LOMPOOAL/CsiNet-CRNet-5G-MIMO)

Ce dépôt contient le code MATLAB utilisé pour le mémoire :

**"Compression et Reconstruction du CSI pour Massive MIMO 5G par Autoencodeurs Profonds"**

---

## 📂 Contenu du dépôt

| Fichier | Taille | Description |
|---------|--------|-------------|
| `createCsiNet.m` | 1,2 KB | Architecture de l'autoencodeur CsiNet |
| `createCRNet.m` | 3,8 KB | Architecture de l'autoencodeur CRNet avec branches parallèles |
| `create_and_test_models.m` | 4,5 KB | Création des modèles et test de passage avant |
| `test_complet_architectures.m` | 5,2 KB | Test complet des deux architectures |
| `verify_metrics.m` | 1,8 KB | Vérification des métriques MSE/RMSE/NMSE |
| `verify_pipeline_dimensions.m` | 3,1 KB | Vérification des dimensions du pipeline CSI |
| `evaluerQuantificationReelle.m` | 2,5 KB | Évaluation de l'impact de la quantification |
| `realQuantizationTest.m` | 2,0 KB | Test de quantification réelle du vecteur latent |
| `etude_systeme_ZF.m` | 2,8 KB | Étude du système avec précodage Zero-Forcing |
| `generer_logs_complet.m` | 3,2 KB | Génération des logs complets pour le jeu de test |
| `generer_logs_20000_complet.m` | 4,0 KB | Génération de 20 000 logs de décision |
| `tester_tous_les_codes.m` | 5,5 KB | Test de l'ensemble des fonctions MATLAB |
| `verifier_fonctions.m` | 1,5 KB | Vérification de l'existence des fonctions |

---

## ⚙️ Instructions d'utilisation

### Prérequis

- **MATLAB R2024a** ou version ultérieure
- Toolboxes requises :
  - 5G Toolbox
  - Deep Learning Toolbox
  - Statistics and Machine Learning Toolbox

### Installation

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/LOMPOOAL/CsiNet-CRNet-5G-MIMO.git
   cd CsiNet-CRNet-5G-MIMO
