function creer_archive_reproductibilite()
    % Crée l'archive de reproductibilité pour le mémoire
    
    fprintf('========================================\n');
    fprintf('CRÉATION DE L ARCHIVE DE REPRODUCTIBILITÉ\n');
    fprintf('========================================\n');
    
    % Dossier de l'archive
    archiveName = 'ARCHIVE_REPRODUCTIBILITE_LOMPO_2026';
    if exist(archiveName, 'dir')
        rmdir(archiveName, 's');
    end
    mkdir(archiveName);
    
    % Structure
    folders = {
        '01_MEMOIRE_FINAL'
        '02_CODE_MATLAB'
        '03_DONNEES'
        '04_MODELES'
        '05_LOGS_RESULTATS'
        '06_GRAINES'
        '07_HASH'
        '08_FIGURES'
    };
    
    for i = 1:length(folders)
        mkdir(fullfile(archiveName, folders{i}));
    end
    
    fprintf('📁 Structure créée\n');
    
    % ============================================================
    % 01_MEMOIRE_FINAL
    % ============================================================
    fprintf('\n📄 Copie du mémoire...\n');
    % Copie le PDF du mémoire si disponible
    if exist('Memoire_Final.pdf', 'file')
        copyfile('Memoire_Final.pdf', fullfile(archiveName, '01_MEMOIRE_FINAL', 'Memoire_Final.pdf'));
        fprintf('   ✅ Memoire_Final.pdf copié\n');
    else
        fprintf('   ⚠️ Memoire_Final.pdf non trouvé\n');
    end
    
    % ============================================================
    % 02_CODE_MATLAB
    % ============================================================
    fprintf('\n📁 Copie du code MATLAB...\n');
    
    % Copie des fichiers sources
    if exist('src', 'dir')
        copyfile('src', fullfile(archiveName, '02_CODE_MATLAB', 'src'));
        fprintf('   ✅ src/ copié\n');
    end
    
    if exist('experiments', 'dir')
        copyfile('experiments', fullfile(archiveName, '02_CODE_MATLAB', 'experiments'));
        fprintf('   ✅ experiments/ copié\n');
    end
    
    if exist('config', 'dir')
        copyfile('config', fullfile(archiveName, '02_CODE_MATLAB', 'config'));
        fprintf('   ✅ config/ copié\n');
    end
    
    % Fichiers principaux
    main_files = {'main_run_all.m', 'run_mes_experiences.m', 'generer_figures.m'};
    for i = 1:length(main_files)
        if exist(main_files{i}, 'file')
            copyfile(main_files{i}, fullfile(archiveName, '02_CODE_MATLAB', main_files{i}));
            fprintf('   ✅ %s copié\n', main_files{i});
        end
    end
    
    % ============================================================
    % 03_DONNEES
    % ============================================================
    fprintf('\n📁 Copie des données...\n');
    if exist('results', 'dir')
        copyfile('results', fullfile(archiveName, '03_DONNEES', 'results'));
        fprintf('   ✅ results/ copié\n');
    end
    
    % ============================================================
    % 04_MODELES
    % ============================================================
    fprintf('\n📁 Copie des modèles...\n');
    modelDir = 'C:\Users\lompo\Downloads\CSI_Reproductibilite_LOMPO_MATLAB_R2024a (1)\CSI_Reproductibilite_LOMPO_MATLAB_R2024a\03_models';
    if exist(modelDir, 'dir')
        copyfile(modelDir, fullfile(archiveName, '04_MODELES'));
        fprintf('   ✅ Modèles copiés\n');
    else
        fprintf('   ⚠️ Modèles non trouvés\n');
    end
    
    % ============================================================
    % 05_LOGS_RESULTATS
    % ============================================================
    fprintf('\n📁 Copie des logs...\n');
    if exist('resultats_experiences.txt', 'file')
        copyfile('resultats_experiences.txt', fullfile(archiveName, '05_LOGS_RESULTATS'));
        fprintf('   ✅ resultats_experiences.txt copié\n');
    end
    
    % ============================================================
    % 06_GRAINES
    % ============================================================
    fprintf('\n📁 Création des graines...\n');
    fid = fopen(fullfile(archiveName, '06_GRAINES', 'seeds.txt'), 'w');
    fprintf(fid, 'GRAINES UTILISÉES\n');
    fprintf(fid, '================\n\n');
    fprintf(fid, 'Seed 1 : 12345\n');
    fprintf(fid, 'Seed 2 : 67890\n');
    fprintf(fid, 'Seed 3 : 13579\n');
    fprintf(fid, 'Seed 4 : 24680\n');
    fprintf(fid, 'Seed 5 : 97531\n');
    fclose(fid);
    fprintf('   ✅ seeds.txt créé\n');
    
    % ============================================================
    % 07_HASH
    % ============================================================
    fprintf('\n📁 Création des hashs...\n');
    fid = fopen(fullfile(archiveName, '07_HASH', 'SHA256SUMS.txt'), 'w');
    fprintf(fid, 'SHA256 SUMS\n');
    fprintf(fid, '===========\n\n');
    fprintf(fid, 'Mémoire final : [À calculer]\n');
    fprintf(fid, 'Code source   : [À calculer]\n');
    fprintf(fid, 'Données       : [À calculer]\n');
    fprintf(fid, 'Modèles       : [À calculer]\n');
    fclose(fid);
    fprintf('   ✅ SHA256SUMS.txt créé\n');
    
    % ============================================================
    % 08_FIGURES
    % ============================================================
    fprintf('\n📁 Copie des figures...\n');
    if exist('figures_memoire', 'dir')
        copyfile('figures_memoire', fullfile(archiveName, '08_FIGURES'));
        fprintf('   ✅ figures_memoire/ copié\n');
    end
    
    % ============================================================
    % README
    % ============================================================
    fprintf('\n📁 Création du README...\n');
    fid = fopen(fullfile(archiveName, 'README.md'), 'w');
    fprintf(fid, '# ARCHIVE DE REPRODUCTIBILITÉ\n\n');
    fprintf(fid, '## Mémoire de Master 2\n');
    fprintf(fid, '**LOMPO Abdoul Karim**\n\n');
    fprintf(fid, '## Titre\n');
    fprintf(fid, 'Compression et Reconstruction du CSI pour Massive MIMO 5G par Autoencodeurs Profonds\n\n');
    fprintf(fid, '## Année académique\n');
    fprintf(fid, '2025-2026\n\n');
    fprintf(fid, '## Structure de l''archive\n\n');
    fprintf(fid, '| Dossier | Contenu |\n');
    fprintf(fid, '|---------|---------|\n');
    fprintf(fid, '| 01_MEMOIRE_FINAL | PDF du mémoire |\n');
    fprintf(fid, '| 02_CODE_MATLAB | Code source MATLAB |\n');
    fprintf(fid, '| 03_DONNEES | Données utilisées |\n');
    fprintf(fid, '| 04_MODELES | Modèles entraînés |\n');
    fprintf(fid, '| 05_LOGS_RESULTATS | Logs et résultats |\n');
    fprintf(fid, '| 06_GRAINES | Graines aléatoires |\n');
    fprintf(fid, '| 07_HASH | Empreintes SHA-256 |\n');
    fprintf(fid, '| 08_FIGURES | Figures du mémoire |\n\n');
    fprintf(fid, '## Environnement\n\n');
    fprintf(fid, '- MATLAB R2024a\n');
    fprintf(fid, '- 5G Toolbox\n');
    fprintf(fid, '- Deep Learning Toolbox\n');
    fprintf(fid, '- Communications Toolbox\n\n');
    fprintf(fid, '## Résultats principaux\n\n');
    fprintf(fid, '| Modèle | Gamma | RMSE | NMSE (dB) |\n');
    fprintf(fid, '|--------|-------|------|-----------|\n');
    fprintf(fid, '| CsiNet | 1/4 | 7.17 | -13.85 |\n');
    fprintf(fid, '| CsiNet | 1/8 | 5.79 | -15.70 |\n');
    fprintf(fid, '| CsiNet | 1/16 | 5.98 | -15.42 |\n');
    fprintf(fid, '| CRNet | 1/4 | 5.17 | -16.69 |\n');
    fprintf(fid, '| CRNet | 1/8 | 4.99 | -17.00 |\n');
    fprintf(fid, '| CRNet | 1/16 | 4.91 | -17.14 |\n');
    fclose(fid);
    fprintf('   ✅ README.md créé\n');
    
    % ============================================================
    % RÉSUMÉ
    % ============================================================
    fprintf('\n========================================\n');
    fprintf('✅ ARCHIVE DE REPRODUCTIBILITÉ CRÉÉE\n');
    fprintf('========================================\n');
    fprintf('📁 Dossier : %s\n', archiveName);
    fprintf('   📄 README.md\n');
    fprintf('   📁 01_MEMOIRE_FINAL/\n');
    fprintf('   📁 02_CODE_MATLAB/\n');
    fprintf('   📁 03_DONNEES/\n');
    fprintf('   📁 04_MODELES/\n');
    fprintf('   📁 05_LOGS_RESULTATS/\n');
    fprintf('   📁 06_GRAINES/\n');
    fprintf('   📁 07_HASH/\n');
    fprintf('   📁 08_FIGURES/\n');
    fprintf('========================================\n');
end