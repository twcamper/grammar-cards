SELECT i.infinitive AS infinitive, i.english AS english
FROM infinitive i, verbs v
WHERE i.infinitive = v.infinitive
AND v.tense = 'Presente' AND v.mood = 'Indicativo'
AND i.infinitive ~ 'er$'
AND v.s1 = regexp_replace(i.infinitive, 'er$', 'o')
AND v.s2 = regexp_replace(i.infinitive, 'er$', 'es')
AND v.s3 = regexp_replace(i.infinitive, 'er$', 'e')
AND v.p1 = regexp_replace(i.infinitive, 'er$', 'emos')
AND v.p2 = regexp_replace(i.infinitive, 'er$', 'éis')
AND v.p3 = regexp_replace(i.infinitive, 'er$', 'en')
ORDER BY 1;

