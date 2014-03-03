SELECT i.infinitive AS infinitive, i.infinitive_english AS english
FROM infinitive i, verbs v
WHERE i.infinitive = v.infinitive
AND v.tense = 'Presente' AND v.mood = 'Indicativo'
AND i.infinitive ~ 'ar$'
AND v.form_1s = regexp_replace(i.infinitive, 'ar$', 'o')
AND v.form_2s = regexp_replace(i.infinitive, 'ar$', 'as')
AND v.form_3s = regexp_replace(i.infinitive, 'ar$', 'a')
AND v.form_1p = regexp_replace(i.infinitive, 'ar$', 'amos')
AND v.form_2p = regexp_replace(i.infinitive, 'ar$', 'áis')
AND v.form_3p = regexp_replace(i.infinitive, 'ar$', 'an')
ORDER BY 1;
