# Графи. Потоци (упр 7)

## Графи
1. Напишете функции `(indegree v g)` и `(outdegree v g)`, които намират съответно полустепените на входа и изхода за връх `v` от граф `g`.

1. Да се напише функция (predecessors v g), която връща списък с всички предшественици на върха v в графа g:
(predecessors 'e G) -> '(b f)

1. Напишете функция `(graph-transpose g)`, която връща [транспонирания][t1] граф на `g`.

[t1]: https://en.wikipedia.org/wiki/Transpose_graph

3. Напишете функция `(acyclic? g)`, която проверява дали графът `g` е ацикличен, тоест няма цикъл.

4. Напишете функция `(shortest-path g u v)`, която намира най-късият път от върха `u` до върха `v` в графа `g`.
> Упътване: тъй като боравим с графи без тегла, най-късият път от `u` до `v` се намира като пуснем `bfs` в `u`.

## Потоци
1. Дефинирайте `ones` - поток от единици: `[1,1,1,1,1,1,1,...]`

2. Дефинирайте `nats` - потокът на естествените числа: `[0,1,2,3,...]`

3. Напишете функция `from`, която приема число и връща потокът със всички естествени числа п-големи или равни на числото.
   ```scheme
   (from 5) -> [5,6,7,8,9,10,...]
   ```

4. Дефинирайте `fibs` - потокът на числата на фибоначи: `[0,1,1,2,3,5,8,13,...]`

5. Дефинирайте `primes` - потокът на простите числа: `[2,3,5,7,11,13,...]`
> Упътване: можете да ползвате [решето на Ератостен][sieve]

[sieve]: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

6. Дефинирайте `pythagorean-triples` - поток от Питагоровите тройки. Питагорова тройка е наредена тройка (a, b, c), за която a^2 + b^2 = c^2.
