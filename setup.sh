#!/bin/bash
mkdir -p game_files
cd game_files
mkdir 1er_chiffre
cd 1er_chiffre
echo "Trouvez le fichier qui fait 1Ko et ouvrez-le" > "Instructions"
echo "Le 1er chiffre est 5" > file_1
truncate -s 1024 file_1 # Fichier de 1 Ko
for i in {2..10}; do
    echo "Ceci est un fichier inutile" > "file_$i"
    truncate -s $((RANDOM % 500 + 500)) "file_$i"
done
cd ..

# Étape 2 : Création du fichier pour le 2ème chiffre sans le chiffre dans le fichier
mkdir 2eme_chiffre
cd 2eme_chiffre
echo "Modifiez les permissions de 'fichier' pour avoir rwx/r/r " > "Instructions"
echo "modifiez mes permissions" > "fichier"
chmod 644 fichier
cd ..

# Étape 3 : Création du fichier pour le 3ème chiffre sans le chiffre dans le fichier
mkdir 3eme_chiffre
cd 3eme_chiffre
echo "Déplacez le 'fichier' dans un dossier 'trois' qu'il faut créer dans ce répértoire" > Instructions
echo "Fichier a deplacer" > "fichier"
cd .. 

# Retour au dossier principal
cd ..

# Création des scripts de vérification et du cadenas
# Script cadenas.sh pour entrer le code final
echo -e "#!/bin/bash\n\nread -p 'Entrez le code à trois chiffres: ' code\nif [[ \"\$code\" == \"525\" ]]; then\n  echo 'Bravo tu as reussi a sortir!'\nelse\n  echo 'Perdu, reessaie.'\nfi" > cadenas.sh
chmod +x cadenas.sh

# Script verification_2.sh pour vérifier les permissions du fichier 2eme_chiffre
cd game_files/2eme_chiffre
echo -e "#!/bin/bash\n\nif [[ \$(stat -c \"%a\" fichier) == \"744\" ]]; then\n    echo \"Le deuxieme chiffre est 2\"\nelse\n    echo \"Les permissions ne sont pas correctes. Reessayez.\"\nfi" > verification_2.sh
chmod +x verification_2.sh
cd ..

# Script verification_3.sh pour vérifier le déplacement du fichier 3eme_chiffre
cd 3eme_chiffre
echo -e "#!/bin/bash\n\nif [[ -f \"trois/fichier\" ]]; then\n    echo \"Le troisieme chiffre est 5\"\nelse\n    echo \"Le fichier n'est pas dans le bon dossier. Reessayez.\"\nfi" > verification_3.sh
chmod +x verification_3.sh


# Instructions finales pour le joueur
echo "L'escape game est prêt ! Suivez les instructions ci-dessous pour trouver le code à trois chiffres."
echo "Allez dans le dossier game_files et consultez bien les instruction pour chaque chiffre."

