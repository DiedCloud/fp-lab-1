# Решение задач Project Euler на Gleam

## Лабораторная работа #1

- **Вариант:** _6_, _25_
- **Преподаватель:** Пенской Александр Владимирович
- **Выполнил:** `Фролов Кирилл Дмитриевич`, `367590`
- ИТМО, Санкт-Петербург, 2025

## Описание работы

Данная лабораторная работа направлена на применение различных подходов функционального программирования для решения
задач из Project Euler. Решенные задачи:

1. [**Задача 6**](./task6/README.md): Нахождение разности квадрата суммы n чисел и суммы квадратов n чисел
2. [**Задача 25**](./task25/README.md): Индекс первого числа Фибоначчи длиной >= n символов

## Структура проекта

- [**task6/**](./task6/README.md) и [**task25/**](./task25/README.md) — директории с решениями задач 6 и 25
  соответственно.
    - **src/** — модули и файлы с реализациями различных подходов
    - **test/** — тесты для проверки решений

---

## [Решение задачи 6](./task6/README.md)

Ниже приведены выдержки из реализаций
(где использована рекурсия, хвостовая рекурсия, модульное решение и пр.)

### [Реализация рекурсией](./task6/src/recursion.gleam)

Расчёт суммы n чисел для последующего возведения в квадрат

```gleam
fn sum_rec(n: Int) -> Int {
  case n > 0 {
    True -> n + sum_rec(n - 1)
    False -> n
  }
}
```

Расчёт суммы квадратов n чисел

```gleam
fn sum_of_squares(n: Int) -> Int {
  case n > 0 {
    True -> n * n + sum_of_squares(n - 1)
    False -> n
  }
}
```

### [Реализация хвостовой рекурсией](./task6/src/tail_recursion.gleam)

Расчёт суммы n чисел для последующего возведения в квадрат

```gleam
fn sum_tailrec_impl(n: Int, acc: Int) -> Int {
  case n > 0 {
    True -> sum_tailrec_impl(n - 1, acc + n)
    False -> acc
  }
}
```

Расчёт суммы квадратов n чисел

```gleam
fn sum_of_squares_impl(n: Int, acc: Int) -> Int {
  case n > 0 {
    True -> sum_of_squares_impl(n - 1, acc + n * n)
    False -> acc
  }
}
```

### [Модульная реализация](./task6/src/moduled.gleam)

Генерация 2 разных последовательностей

```gleam
fn get_seq_impl(n: Int, acc: List(Int)) -> List(Int) {
  case n > 0 {
    True -> get_seq_impl(n - 1, [n, ..acc])
    False -> acc
  }
}

fn get_seq_squred_impl(n: Int, acc: List(Int)) -> List(Int) {
  case n > 0 {
    True -> get_seq_squred_impl(n - 1, [square(n), ..acc])
    False -> acc
  }
}
```

Сворачиваем каждую из них.
Ту, что должна стать квадратом суммы, направляем в функцию square.

```gleam
fn square(x: Int) -> Int { x * x }
fn add(count: Int, e: Int) -> Int { count + e }

pub fn solve(n: Int) -> Int {
  let square_of_sum = get_seq(n) |> list.fold(0, add) |> square
  let sum_of_squares = get_seq_squred(n) |> list.fold(0, add)
  square_of_sum - sum_of_squares
}
```

### [map](./task6/src/mapped.gleam)

В отличие от прошлого модульного варианта, сгенерируем одну последовательность
и потом для получения суммы квадратов применим к ней map с функцией square

```gleam
import gleam/list

fn get_seq_impl(n: Int, acc: List(Int)) -> List(Int) {
  case n > 0 {
    True -> get_seq_impl(n-1, [n, ..acc])
    False -> acc
  }
}

fn get_seq(n: Int) -> List(Int) {
  get_seq_impl(n, [])
}

fn square(x: Int) -> Int { x * x }
fn add(count: Int, e: Int) -> Int { count + e }

pub fn solve(n: Int) -> Int {
  let seq = get_seq(n)
  let square_of_sum = seq |> list.fold(0, add) |> square
  let sum_of_squares = seq |> list.map(square) |> list.fold(0, add)
  square_of_sum - sum_of_squares
}
```

### [Ленивые коллекции](./task6/src/lazy.gleam)

А для ленивых коллекций есть библиотека [gens](https://hexdocs.pm/gens/index.html),
которая позволяет удобно создать ленивый список и потом получить из него обычный gleam/list

```gleam
import gens/lazy

fn square(x: Int) -> Int { x * x }
fn add(count: Int, e: Int) -> Int { count + e }

fn sum_of_squares(n: Int) -> Int {
  lazy.new()
  |> lazy.map(square)
  |> lazy.take(n+1)
  |> list.fold(0, add)
}

fn square_of_sum(n: Int) -> Int {
  lazy.new()
  |> lazy.take(n+1)
  |> list.fold(0, add)
  |> square
}
```

### [Математика](./task6/src/task6.gleam)

Так как в Gleam нет особого синтаксиса для циклов,
для разнообразия воспользуемся формулой суммы n чисел

```gleam
fn square_of_sum(n: Int) -> Int {
  { { n * { n + 1 } } / 2 } * { { n * { n + 1 } } / 2 }
}
```

### [Реализация на Python](./task6/common.py)

```python
def square_of_sum(n):
    sum_n = (n * (n + 1)) / 2
    return int(sum_n ** 2)


def sum_of_squares(n):
    return sum(map(lambda x: x ** 2, range(1, n + 1)))


print(square_of_sum(100) - sum_of_squares(100))  # 25164150
```

## [Решение задачи 25](./task25/README.md)

Ниже приведены выдержки из реализаций
(где использована рекурсия, хвостовая рекурсия, модульное решение и пр.)

### [Реализация рекурсией](./task25/src/recursion.gleam)

Сам расчёт числа Фибоначчи реализуется всё-таки через хвостовую рекурсию,
так как иначе программа создаёт много фреймов и тратит много времени, многократно пересчитывая одно и то же число.

```gleam
fn get_fib_impl(n: Int, f1: Int, f2: Int) -> Int {
  case n {
    0 -> f1
    1 -> f2
    _ -> get_fib_impl(n - 1, f2, f1 + f2)
  }
}

pub fn get_fib(n: Int) -> Int {
  get_fib_impl(n, 0, 1)
}

fn get_index(n: Int, i: Int) -> Int {
  let len = get_fib(i) |> int.to_string |> string.length
  case len >= n {
    True -> i
    False -> get_index(n, i + 1)
  }
}

pub fn solve(n: Int) -> Int {
  get_index(n, 0)
}
```

### [Реализация хвостовой рекурсией](./task25/src/tail_recursion.gleam)

Почти прямой аналог реализации на python через цикл while.

```gleam
fn get_index_impl(n: Int, i: Int, f1: Int, f2: Int) -> Int {
  let len = f2 |> int.to_string |> string.length
  case len >= n {
    True -> i
    False -> get_index_impl(n, i + 1, f2, f1 + f2)
  }
}

fn get_index(n: Int) -> Int {
  get_index_impl(n, 1, 0, 1)
}

pub fn solve(n: Int) -> Int {
  get_index(n)
}
```

### [Модульная реализация](./task25/src/moduled.gleam)

Генерация последовательности "пока не встретим число нужной длины".
После свёртка последовательности функцией `list.length()` для получения индекса.

```gleam
fn get_fib_seq_impl(n: Int, acc: List(Int)) -> List(Int) {
  let l = list.first(acc) |> result.unwrap(0) |> int.to_string |> string.length
  case acc {
    _ if l >= n -> acc
    [] -> get_fib_seq_impl(n, [1])
    [_] -> get_fib_seq_impl(n, [1, 1])
    [f1, f2, ..] -> get_fib_seq_impl(n, [f1 + f2, ..acc])
  }
}

fn get_fib_seq(n: Int) -> List(Int) {
  get_fib_seq_impl(n, [])
}

pub fn solve(n: Int) -> Int {
  get_fib_seq(n) |> list.length
}
```

### [map](./task25/src/mapped.gleam)

Генерация отрезков размером batch из натуральных чисел.
После - преобразование натуральных чисел в числа Фибоначчи с такими индексами.
Если числа Фибоначчи нужной длины нет - генерируем следующий batch.

```gleam
fn length(n: Int) -> Int {
  n |> int.to_string |> string.length
}

fn get_seq(upper_bound: Int, acc: List(Int)) -> List(Int) {
  case acc {
    [] -> get_seq(upper_bound, [1])
    [f1, ..] if f1 >= upper_bound -> acc
    [f1, ..] -> get_seq(upper_bound, [f1 + 1, ..acc])
  }
}

fn find_index_of_first_with_length_less_than_n(
  n: Int,
  seq: List(Int),
  initial_length: Int,
) -> Result(Int, Nil) {
  case seq {
    [] -> Error(Nil)
    [a, ..tail] ->
    case length(a) < n {
      True -> Ok(initial_length - list.length(seq))
      False ->
        find_index_of_first_with_length_less_than_n(n, tail, initial_length)
    }
  }
}

fn solve_batch(n: Int, start_index: Int, batch_size: Int) -> Int {
  let indexes = get_seq(start_index + batch_size, [start_index])
  let last_index = list.first(indexes) |> result.unwrap(0)

  let fibs = indexes |> list.map(recursion.get_fib)
  let last_fib_length = list.first(fibs) |> result.unwrap(0) |> length

  case last_fib_length >= n {
    True -> {
      let rest_index_amount_res =
        find_index_of_first_with_length_less_than_n(n, fibs, list.length(fibs))

      case rest_index_amount_res |> result.is_ok {
        True -> last_index - result.unwrap(rest_index_amount_res, 0) + 1
        False -> solve_batch(n, last_index + 1, batch_size)
      }
    }

    False -> solve_batch(n, last_index + 1, batch_size)
  }
}

pub fn solve(n: Int) -> Int {
  solve_batch(n, 0, 100)
}
```

### [Ленивые коллекции](./task6/src/lazy.gleam)

Для ленивых коллекций есть библиотека [gens](https://hexdocs.pm/gens/index.html).
На это раз создадим бесконечный список, который называется Stream

```gleam
import gens/stream
import gleam/list
import gleam/result

import gleam/int
import gleam/pair
import gleam/string

fn length(n: Int) -> Int {
  n |> int.to_string |> string.length
}

fn get_fib_stream() -> stream.Stream(#(#(Int, Int), #(Int, Int))) {
  stream.Stream(head: fn() { #(#(1, 1), #(2, 1)) }, tail: fn() {
    stream.map(get_fib_stream(), fn(int_pair) {
      case int_pair {
        #(#(i1, f1), #(i2, f2)) -> #(#(i1 + 1, f2), #(i2 + 1, f1 + f2))
      }
    })
  })
}

pub fn solve(n: Int) -> Int {
  let i =
  stream.while(get_fib_stream(), fn(int_pair) {
    int_pair |> pair.second |> pair.second |> length < n
  })
  |> list.last
  |> result.unwrap(#(#(0, 0), #(0, 0)))
  |> pair.second
  |> pair.first
  // + 1 так как stream.while до момента, пока условие не выполнено
  i + 1
}
```

### [Реализация на Python](./task25/common.py)

```python
def get_index_of_first_fibonacci_term_length_n(n):
    i = 1
    f_i = 0
    f_i2 = 1
    while len(str(f_i2)) < n:
        f_i, f_i2 = f_i2, f_i + f_i2
        i += 1
    return i


print(get_index_of_first_fibonacci_term_length_n(1000))  # 4782
```

## Запуск тестов

Для запуска тестов с использованием gleam (`<task_dir>` - `./task6` или `./task25`):

```bash
cd <task_dir>
gleam test
```

## Заключение

Представленные решения демонстрируют различные подходы к решению задач
с использованием функционального программирования на Gleam.
Эти примеры показывают, как рекурсия, циклы и функции высшего порядка могут эффективно решать математические задачи.

## Зависимости

Для сборки и запуска проекта использовались:

- gleam 1.12.0
- Erlang OTP 28.1
