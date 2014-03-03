SELECT i.infinitive AS infinitive, i.infinitive_english AS english
FROM infinitive i, verbs v
WHERE i.infinitive = v.infinitive
AND v.tense = 'Presente' AND v.mood = 'Indicativo'
AND i.infinitive ~ 'er$'
AND v.form_1s = regexp_replace(i.infinitive, 'er$', 'o')
AND v.form_2s = regexp_replace(i.infinitive, 'er$', 'es')
AND v.form_3s = regexp_replace(i.infinitive, 'er$', 'e')
AND v.form_1p = regexp_replace(i.infinitive, 'er$', 'emos')
AND v.form_2p = regexp_replace(i.infinitive, 'er$', 'éis')
AND v.form_3p = regexp_replace(i.infinitive, 'er$', 'en')
ORDER BY 1;

