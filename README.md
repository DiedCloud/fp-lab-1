# Решение задач Project Euler на Gleam

## Лабораторная работа #1

- **Вариант:** _6_, _25_  
- **Преподаватель** Пенской Александр Владимирович  
- **Выполнил** `Фролов Кирилл Дмитриевич`, `367590`
- ИТМО, Санкт-Петербург, 2025

## Описание работы

Данная лабораторная работа направлена на применение различных подходов функционального программирования для решения задач из Project Euler. Решенные задачи:
1. [**Задача 6**](./task6/README.md): Нахождение разности квадрата суммы n чисел и суммы квадратов n чисел
2. [**Задача 25**](./task25/README.md): Индекс первого числа Фибоначчи длиной >= n символов

## Структура проекта

- [**task6/**](./task6/README.md) и [**task25/**](./task25/README.md) — директории с решениями задач 6 и 25 соответственно.
    - **src/** — модули и файлы с реализациями различных подходов
    - **test/** — тесты для проверки решений

---


## [Решение задачи 6](./task6/README.md)
Ниже приведены тематические особенности реализаций (где использована рекурсия, хвостовая рекурсия, модульное решение и пр.)
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
которая позволяет удобно создать список и потом получить из него обычный gleam/list

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
  sum_n = (n * (n+1)) / 2
  return int(sum_n ** 2)

def sum_of_squares(n):
  return sum(map(lambda x: x ** 2, range(1, n+1)))

print(square_of_sum(100) - sum_of_squares(100))  # 25164150
```

## [Решение задачи 25](./task25/README.md)
Ниже приведены тематические особенности реализаций (где использована рекурсия, хвостовая рекурсия, модульное решение и пр.)
### [Реализация рекурсией](./task25/src/recursion.gleam)

```gleam

```

### [Реализация хвостовой рекурсией](./task25/src/tail_recursion.gleam)

```gleam

```

### [Модульная реализация](./task25/src/moduled.gleam)

```gleam

```

### [map](./task25/src/mapped.gleam)

```gleam

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

Для запуска тестов с использованием gleam:

```bash
gleam test
```

## Заключение

Представленные решения демонстрируют различные подходы к решению задач с использованием функционального программирования на Gleam.
Эти примеры показывают, как рекурсия, циклы и функции высшего порядка могут эффективно решать математические задачи.

## Зависимости

Для сборки и запуска проекта использовались:
- gleam 1.12.0
- Erlang OTP 28.1
