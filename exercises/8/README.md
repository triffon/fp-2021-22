# Упражнения на Компютърни Науки, курс 2, поток 2, група 8

За често задавани въпроси вижте [FAQ](#FAQ).

## График

07.10.2021 :school: Упражнение 1 - [Въведение в Scheme](01-introduction-to-scheme/),
[линейна рекурсия и линеен итеративен процес :arrows_counterclockwise:](02-linear-iterative-process/)

14.10.2021 :school: Упражнение 2 - Упражняваме
[линейна рекурсия и линеен итеративен процес :arrows_counterclockwise:](02-linear-iterative-process/).
Продължаваме с [дървовидна рекурсия](03-tree-recursion/)
и [функции от по-висок ред](04-higher-order-functions/).

21.10.2021 :computer: :school: Упражнение 3 - Решихме задачите за [функции от по-висок ред](04-higher-order-functions/)
и се запознахме с [наредени двойки и списъци](05-lists/).

28.10.2021 :computer: :school: Упражнение 4 - Упражняваме [наредени двойки и списъци](05-lists/). Надграждаме със задачи за [списъци от списъци (матрици)](06-matrices/)

04.11.2021 :computer: :school: Упражнение 5 - Продължаваме със задачи върху [списъци](05-lists/), [матрици](06-matrices/) и [асоциативни списъци](07-07-associative-lists/).

## FAQ

### За Haskell

#### Как да програмирам на Haskell на моята машина

- VSCode
  - [Setting up Haskell in VS Code on a Unix-based OS](https://medium.com/@dogwith1eye/setting-up-haskell-in-vs-code-on-macos-d2cc1ce9f60a)
  - Extensions like Haskero, Haskell Highliting
- GHCi за интерпретатор
  - Нужно ви е да инсталирате [Haskell Platform](https://www.haskell.org/platform/)
- repl.it/haskell - в Интернет

#### Къде мога да намеря документацията на стандартните функции в езика

- [Hoogle](https://hoogle.haskell.org/)
  - има го и като пакет в `cabal` за offline ползване през терминала

### За Scheme

#### Как да програмирам на Scheme на моята машина

- DrRacket
- VSCode + Racket build task (или команда в терминала)
- repl.it/scheme - в Интернет

#### Как да накарам VSCode да интерпретира Scheme файлове

Отворете `.scm` файла във VSCode и натиснете клавишната комбинация
`Ctrl` + `Shift` + `B`. Първият път ще имате само опцията
`No build task to run found. Configure Build Task...`, изберете я с `Enter`.
След това изберете `Open tasks.json file` и поставете следната конфигурация
или ако вече имате предходни конфигурации, просто добавете новата:

```json
{
  // See https://go.microsoft.com/fwlink/?LinkId=733558
  // for the documentation about the tasks.json format
  "version": "2.0.0",
  "tasks": [
    {
      "label": "run racket",
      "type": "shell",
      "command": "racket -r ${file}",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```
