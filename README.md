# The Reliability of Computational Replications

Part of the Crowdsourced Replication Initiative (Authors Omitted) investigating the reliability of research. Includes a direct replication of Brady and Finnigan ([2014](https://journals.sagepub.com/doi/full/10.1177/0003122413513022)) undertaken by 85 independent research teams to verify their original numerical results testing the hypothesis that immigration undermines support for social policy in rich/Global North democracies. There was an experimental condition varying the transparency of the replication materials provided. 


## Paper Abstract

This paper reports findings from a crowdsourced replication with two randomized conditions. Eighty-five independent teams attempted a computational replication of results reported in an original study of policy preferences and immigration by fitting the same statistical models to the same data. Replication teams were randomly grouped into a ‘transparent group’ that received the original study and code, or an ‘opaque group’ receiving only a methods section, descriptive results and no code. Although minor error across researchers is not surprising, we show this occurs where it is least expected in the case of computational reproduction. The transparent group mostly verified the numerical results of the original study with the same sign and p-value threshold (95.7%), while the opaque group had less success (89.3%). Exact numerical reproductions to the second decimal place were far less common (76.9% and 48.1%), and the number of teams who verified at least 95% of all effects in all models they ran was 79.5% and 65.2% respectively. Qualitative investigation of the teams’ workflows reveals many causes of error including mistakes and procedural variations. When curating mistakes or trimming outliers, we still find only the transparent group produced reproductions that could be categorized as reliably successful. Some key methodological steps were only available in the code. Our findings imply a need for transparency, but that transparency alone is not sufficient to make computational reproduction reliable. Institutional checks and less subjective difficulty in completing the tasks, meaning improving the training of scholars starting early on, are also necessary. We also highlight the need for a humbler awareness of the complexity of the research process and the fallacy of ‘push button’ replications at the meta-level.

## User Notes

The workflow is captured in the folder 'codes' with Rmd files that should be run in order starting with 00 through 02. These files have been run and knitted into html output which can be read in any browser. More information about the original data files are available in each code file. To see these open the [code](../code/) folder or follow the following links:

| File | Description |
| [00_Qualitative_Coding.Rmd](../code/00_Qualitative_Coding.html) | Extracts and counts qualitative categorizations of error by team |
| [01_Data_Prep.Rmd](../code/01_Data_Prep.html) | Prepares and combines participant survey results and replicated numerical effects by team |
| [02_Analysis.Rmd](../code/02_Analysis.html) | Correlations and regressions predicting our three reliability measures and two qualitative categories |
| [03_Figures.Rmd](../code/03_Figures.html) | Produces figures and additional tables |
