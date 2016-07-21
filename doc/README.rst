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

-----------------
Gestion du projet
-----------------

Décision de faire des wrappers pour les mesures de temps et le format des outputs.
Pour chaque langage, on crée un module/package/jmenbalek qui systématise et évite les gros copiers-collers de porc
pour les analyses des arguments venus de bash, etc.
La forme est encore à définir.
Permettra également de faciliter une *éventuelle* analyse auto.
On fournira un script pour les langages qui ne supportent pas l'appel à clock() ou équivalent.

Il faut aussi voir pour un makefile générique (semi-générique, avec un pré-setup).

Chaque codeur code dans sa branche ses petites avancées, qu'il peut pousser pour montrer à ses petits camarades.
Ensuite, afin de limiter la quantité de commit foirés, il rebase -i et squash/merge/jmenbalek les commits avant
de rebase sur master.
Et tout le monde est content.

On *peut* dire qu'un changement est prêt à aller sur master quand la solution du problème est trouvée
par une méthode donnée et que cette solution utilise les librairies proposées pour gérer ses I/O
(mais pas encore implémentées).
C'est l'occasion de rebase sur master (*éventuellement* avec un nombre plus petit de commits), *vérifier* que
ça marche toujours, et git merge --no-ff master pour créer un point de ralliement avec master avec
*une description explicite* des commits ajoutés (voir par exemple ce commit_).

.. _commit: https://github.com/Miaou/ProjectEuler/commit/b414fb7f5170442bafcd135cc0f2bea74cdad08f

-----
TODO
-----

- Gérer les résultats : but autogen LaTeX

  - définir la forme des résultats

    - table liste des résultats
    - table comparative
    - utilisation de pb_xxx_/PROBLEM ?

- Continuer pour que stdout puisse être parsé tout seul :

  - Prévoir plusieurs batchs pour pouvoir mesurer les temps faibles,
  - Trouver un moyen d'éviter que make dise ce qu'il fait sur stdout, mais plutôt sur stderr :

    - si c'est possible, make prend la responsabilité d'afficher le nom du programme avant ses résultats, pour le parsing,
    - sinon, il faut prévoir dans les libs de langage que le nom du prg soit print.

------------
Problem list
------------

- pb_007: find the i-th prime, where i is 10 001.
- pb_050: find the longest sum of consectuive primes which results to a prime below 1,000,000.

.. <!--- vim: set spelllang=fr spell : --->
