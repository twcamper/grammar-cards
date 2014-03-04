SELECT i.infinitive AS infinitive, i.english AS english
FROM infinitive i, verbs v
WHERE i.infinitive = v.infinitive
AND v.tense = 'Presente' AND v.mood = 'Indicativo'
AND i.infinitive ~ 'ir$'
AND v.s1 = regexp_replace(i.infinitive, 'ir$', 'o')
AND v.s2 = regexp_replace(i.infinitive, 'ir$', 'es')
AND v.s3 = regexp_replace(i.infinitive, 'ir$', 'e')
AND v.p1 = regexp_replace(i.infinitive, 'ir$', 'imos')
AND v.p2 = regexp_replace(i.infinitive, 'ir$', 'ís')
AND v.p3 = regexp_replace(i.infinitive, 'ir$', 'en')
ORDER BY 1;
