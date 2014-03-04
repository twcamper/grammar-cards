SELECT i.infinitive AS infinitive, i.english AS english
FROM infinitive i, verbs v
WHERE i.infinitive = v.infinitive
AND v.tense = 'Presente' AND v.mood = 'Indicativo'
AND i.infinitive ~ 'ar$'
AND v.s1 = regexp_replace(i.infinitive, 'ar$', 'o')
AND v.s2 = regexp_replace(i.infinitive, 'ar$', 'as')
AND v.s3 = regexp_replace(i.infinitive, 'ar$', 'a')
AND v.p1 = regexp_replace(i.infinitive, 'ar$', 'amos')
AND v.p2 = regexp_replace(i.infinitive, 'ar$', 'áis')
AND v.p3 = regexp_replace(i.infinitive, 'ar$', 'an')
ORDER BY 1;
