SELECT i.infinitive AS infinitive, i.infinitive_english AS english
FROM infinitive i, verbs v
WHERE i.infinitive = v.infinitive
AND v.tense = 'Presente' AND v.mood = 'Indicativo'
AND i.infinitive ~ 'ir$'
AND v.form_1s = regexp_replace(i.infinitive, 'ir$', 'o')
AND v.form_2s = regexp_replace(i.infinitive, 'ir$', 'es')
AND v.form_3s = regexp_replace(i.infinitive, 'ir$', 'e')
AND v.form_1p = regexp_replace(i.infinitive, 'ir$', 'imos')
AND v.form_2p = regexp_replace(i.infinitive, 'ir$', 'ís')
AND v.form_3p = regexp_replace(i.infinitive, 'ir$', 'en')
ORDER BY 1;
