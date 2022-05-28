/* Clean the vaccine hesitancy data */


-- The vaccine hesitancy data gets specific with each county for each state --
-- So I grouped them up by state to match the literacy rate data and took the average values --
-- for the hesitancy data by each state --

SELECT State, AVG(Estimated_hesitant) AS hesitant, AVG(Estimated_hesitant_or_unsure) AS unsure,
AVG(Estimated_strongly_hesitant) AS strongly_hesitant
FROM `focus-standard-319913.covid_vax.vaccine_hesitancy`
GROUP BY State


-- Now let's combine the data --

SELECT lit.State, lit.literacyRate, AVG(hes.Estimated_hesitant) AS hesitant, AVG(hes.Estimated_hesitant_or_unsure) AS unsure,
AVG(hes.Estimated_strongly_hesitant) AS strongly_hesitant
FROM `focus-standard-319913.covid_vax.vaccine_hesitancy` as hes
FULL OUTER JOIN `focus-standard-319913.covid_vax.literacy_rate` as lit
  ON hes.State = lit.State
WHERE lit.literacyRate is not null
GROUP BY lit.State, lit.literacyRate
ORDER BY lit.State ASC