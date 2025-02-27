# The Reliability of Computational Replications

Nate Breznau<br>
Eike Mark Rinke<br>
Alexander Wuttke<br>

[Working Paper](https://osf.io/preprints/socarxiv/j7qta)

Preregistered Crowdsourced Replication Initiative ([Breznau, Rinke and Wuttke 2019](https://osf.io/preprints/socarxiv/6j9qb/)) investigating the reliability of research. Includes a direct replication of Brady and Finnigan ([2014](https://journals.sagepub.com/doi/full/10.1177/0003122413513022)) undertaken by 85 independent research teams to verify their original numerical results testing the hypothesis that immigration undermines support for social policy in rich/Global North democracies. There was an experimental condition varying the transparency of the replication materials provided. 

[Appendix A & B communications and further tables](https://github.com/nbreznau/how_many_replicators/blob/main/results/Appendix%20For%20Main%20Paper.pdf)

[Append C - team codes](https://github.com/nbreznau/how_many_replicators/blob/main/results/Breznau%20How%20Many%20Replicators%20Appendix%20C.pdf)

## Participant Replicators

<details>
<summary>Click arrow to see all</summary>

Muna Adem, Jule Adriaans, Esra Akdeniz, Amalia Alvarez-Benjumea, Henrik Andersen, Daniel Auer, Flavio Azevedo, Oke Bahnsen, Ling Bai, Dave Balzer, Paul C. Bauer, Gerrit Bauer, Markus Baumann, Sharon Baute, Verena Benoit, Julian Bernauer, Carl Berning, Anna Berthold, Felix S. Bethke, Thomas Biegert, Katharina Blinzler, Johannes N. Blumenberg, Licia Bobzien, Andrea Bohman, Thijs Bol, Amie Bostic, Zuzanna Brzozowska, Katharina Burgdorf, Kaspar Burger, Kathrin Busch, Juan Castillo, Nathan Chan, Pablo Christmann, Roxanne Connelly, Christian Czymara, Elena Damian, Eline de Rooij, Alejandro Ecker, Achim Edelmann, Christine Eder, Maureen A. Eger, Simon Ellerbrock, Anna Forke, Andrea Forster, Danilo Freire, Chris Gaasendam, Konstantin Gavras, Vernon Gayle, Theresa Gessler, Timo Gnambs, Amélie Godefroidt, Max Grömping, Martin Groß, Stefan Gruber, Tobias Gummer, Andreas Hadjar, Verena Halbherr, Jan Paul Heisig, Sebastian Hellmeier, Stefanie Heyne, Magdalena Hirsch, Mikael Hjerm, Oshrat Hochman, Jan H. Höffler, Andreas Hövermann, Sophia Hunger, Christian Hunkler, Nora Huth, Zsofia Ignacz, Sabine Israel, Laura Jacobs, Jannes Jacobsen, Bastian Jaeger, Sebastian Jungkunz, Nils Jungmann, Jennifer Kanjana, Mathias Kauff, Sayak KhatuaManuel Kleinert, Julia Klinger, Jan-Philipp Kolb, Marta Kołczyńska, John Kuk, Katharina Kunißen, Jennifer Kanjana, Salman Khan, Dafina Kurti, Alexander Langenkamp, Robin Lee, David Liu, Philipp Lersch, Lea-Maria Löbel, Philipp Lutscher, Matthias Mader, Joan Madia, Natalia Malancu, Luis Maldonado, Helge Marahrens, Nicole Martin, Paul Martinez, Jochen Mayerl, Oscar J. Mayorga, Robert McDonnell, Patricia McManus, Kyle McWagner, Cecil Meeusen, Daniel Meierrieks, Jonathan Mellon, Friedolin Merhout, Samuel Merk, Daniel Meyer, Jonathan Mijs, Cristobal Moya, Marcel Neunhoeffer, Daniel Nüst, Olav Nygård, Fabian Ochsenfeld, Gunnar Otte, Anna Pechenkina, Mark Pickup, Christopher Prosser, Louis Raes, Kevin Ralston, Miguel Ramos, Frank Reichert, Leticia Rettore Micheli, Arne Roets, Jonathan Rogers, Guido Ropers, Robin Samuel, Gregor Sand, Constanza Sanhueza Petrarca, Ariela Schachter, Merlin Schaeffer, David Schieferdecker, Elmar Schlueter, Katja Schmidt, Regine Schmidt, Alexander Schmidt-Catran, Claudia Schmiedeberg, Jürgen Schneider, Martijn Schoonvelde, Julia Schulte-Cloos, Sandy Schumann, Reinhard Schunck, Jürgen Schupp, Julian Seuring, Henning Silber, Willem Sleegers, Nico Sonntag, Alexander Staudt, Nadia Steiber, Nils Steiner, Sebastian Sternberg, Dieter Stiers, Dragana Stojmenovska, Nora Storz, Erich Striessnig, Anne-Kathrin Stroppe, Jordan W Suchow, Janna Teltemann, Andrey Tibajev, Brian Tung, Giacomo Vagni, Jasper Van Assche, Meta van der Linden, Jolanda van der Noll, Arno Van Hootegem, Stefan Vogtenhuber, Bogdan Voicu, Fieke Wagemans, Nadja Wehl, Hannah Werner, Brenton Wiernik, Fabian Winter, Christof Wolf, Cary Wu, Yuki Yamada, Nan Zhang, Conrad Ziller, Björn Zakula, Stefan Zins, Tomasz Żółtak
</details>



## Paper Abstract

This paper reports findings from a crowdsourced replication. Eighty-five independent teams attempted a computational replication of results reported in an original study of policy preferences and immigration by fitting the same statistical models to the same data. The replication involved an experimental condition. Random assignment put participating teams into either the transparent group that received the original study and code, or the opaque group receiving only a methods section, rough results description and no code. The transparent group mostly verified the numerical results of the original study with the same sign and p-value threshold (95.7%), while the opaque group had less success (89.3%). Exact numerical reproductions to the second decimal place were far less common (76.9% and 48.1%), and the number of teams who verified at least 95% of all effects in all models they ran was 79.5% and 65.2% respectively. Therefore, the reliability we quantify depends on how reliability is defined, but most definitions suggest it would take a minimum of three independent replications to achieve reliability. Qualitative investigation of the teams’ workflows reveals many causes of error including mistakes and procedural variations. Although minor error across researchers is not surprising, we show this occurs where it is least expected in the case of computational reproduction. Even when we curate the results to boost ecological validity, the error remains large enough to undermine reliability between researchers to some extent. The presence of inter-researcher variability may explain some of the current “reliability crisis” in the social sciences because it may be undetected in all forms of research involving data analysis. The obvious implication of our study is more transparency. Broader implications are that researcher variability adds an additional meta-source of error that may not derive from conscious measurement or modeling decisions, and that replications cannot alone resolve this type of uncertainty.

## User Notes

The workflow is captured in the folder 'codes' with Rmd files that should be run in order starting with 00 through 02. These files have been run and knitted into html output which can be read in any browser. More information about the original data files are available in each code file. To see these open the [code](../code/) folder or follow the following links:

| File | Description |
| ----------- | ----------- |
| [00_Qualitative_Coding.Rmd](../code/00_Qualitative_Coding.html) | Extracts and counts qualitative categorizations of error by team |
| [01_Data_Prep.Rmd](../code/01_Data_Prep.html) | Prepares and combines participant survey results and replicated numerical effects by team |
| [02_Analysis.Rmd](../code/02_Analysis.html) | Correlations and regressions predicting our three reliability measures and two qualitative categories |
| [03_Figures.Rmd](../code/03_Figures.html) | Produces figures and additional tables |
