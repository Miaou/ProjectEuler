Salut ! C'est le Project Euler... (https://projecteuler.net/)

Notre but est de traiter certains des problèmes, et de les implémenter dans différents langages de progra,
afin de tous progresser *gaiement*.

PAB, EBI, JAL, MAR, VLA

---------
Structure
---------

Voici l'arborescence retenue : ::

    .
    |- doc/ # Résultats formatés ?
    |- pb_xxx_<descr>/ # Un dossier par pb numéro xxx, <descr> est une short description (ex. nth_prime)
       |- PROBLEM # Description plus complète du pb
       |- jal_<method>.c
       |-             .xx
       |- ebi_<method>.sh
       |- pab_<method>.py
       |- out/ # pour la génération des fichiers compilés et fichiers temporaires
       |- makefile # ou autre script de génération des résultats et des codes intermediaires

----------
Avancement
----------

Décision de faire des wrappers pour les mesures de temps et le format des outputs.
Pour chaque langage, on crée un module/package/jmenbalek qui systématise et évite les gros copiers-collers de porc
pour les analyses des arguments venus de bash, etc.
La forme est encore à définir.
Permettra également de faciliter une *éventuelle* analyse auto.
On fournira un script pour les langages qui ne supportent pas l'appel à clock() ou équivalent.

Il faut aussi voir pour un makefile générique (semi-générique, avec un pré-setup).

-----
TODO
-----

 - gérer les résultats : but autogen LaTeX

   - définir la forme des résultats

     - table liste des résultats
     - table comparative
     - utilisation de pb_xxx_/PROBLEM ?

   - voir ce qu'on peut faire pour que stdout puisse être parsé tout seul...

     - exemple de sortie:
         nom_methode(entree) = sortie
         user 0.129s
     - descendre à la ms pour la comparaison entre les méthodes (même si on est conscient que c'est absolument
       pas reproductible à la ms près)

       - éventuellement prévoir plusieurs batchs pour contrer ceci

------------
Problem list
------------

- pb_007: find the i-th prime, where i is 10 001.
- pb_050: find the longest sum of consectuive primes which results to a prime below 1,000,000.

.. <!--- vim: set spelllang=fr spell : --->
