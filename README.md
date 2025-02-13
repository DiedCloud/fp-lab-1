# Решение задач Project Euler на OCaml

## Лабораторная работа #1

- **Вариант:** _11_, _20_  
- **Преподаватель** Пенской Александр Владимирович  
- **Выполнил** `Фролов Кирилл Дмитриевич`, `367590`
- ИТМО, Санкт-Петербург, 2025

## Описание работы

Данная лабораторная работа направлена на применение различных подходов функционального программирования для решения задач из Project Euler. Решенные задачи:
1. [**Задача 11**](./task11/README.md): Нахождение максимального произведения 4-х чисел стоящих подряд в одной линии.
2. [**Задача 20**](./task20/README.md): Сумма цифр факториала.

## Структура проекта

- [**task11/**](./task11/README.md) и [**task20/**](./task20/README.md) — директории с решениями задач 11 и 20 соответственно.
    - **lib/** — модули и файлы с реализациями различных подходов:
    - **test/** — тесты для проверки решений, написанные с использованием `OUnit2`.*

---


## [Решение задачи 11](./task11/README.md)
Ниже приведены тематические особенности реализаций (где использована рекурсия, хвостовая рекурсия, модульное решение и пр.)
### [Реализация рекурсией](./task11/lib/recursion.ml)

```ocaml
let rec max_product_recursive grid rows cols i j =
  if i >= rows then 0
  else if j >= cols then max_product_recursive grid rows cols (i + 1) 0
  else
    let max_in_position =
      let max_val = ref 0 in
      (* Горизонтально *)
      if j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i).(j+1) * grid.(i).(j+2) * grid.(i).(j+3));
      (* Вертикально *)
      if i + 3 < rows then
        max_val := max !max_val (grid.(i).(j) * grid.(i+1).(j) * grid.(i+2).(j) * grid.(i+3).(j));
      (* Диагональ вправо вниз *)
      if i + 3 < rows && j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i+1).(j+1) * grid.(i+2).(j+2) * grid.(i+3).(j+3));
      (* Диагональ вправо вверх *)
      if i - 3 >= 0 && j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i-1).(j+1) * grid.(i-2).(j+2) * grid.(i-3).(j+3));
      !max_val
    in
    max max_in_position (max_product_recursive grid rows cols i (j + 1))
```

### [Реализация хвостовой рекурсией](./task11/lib/tail_recursion.ml)

```ocaml
let rec max_product_recursive grid rows cols i j acc =
  if i >= rows then acc
  else if j >= cols then max_product_recursive grid rows cols (i + 1) 0 acc
  else
    let max_in_position =
      let max_val = ref 0 in
      (* Горизонтально *)
      if j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i).(j+1) * grid.(i).(j+2) * grid.(i).(j+3));
      (* Вертикально *)
      if i + 3 < rows then
        max_val := max !max_val (grid.(i).(j) * grid.(i+1).(j) * grid.(i+2).(j) * grid.(i+3).(j));
      (* Диагональ вправо вниз *)
      if i + 3 < rows && j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i+1).(j+1) * grid.(i+2).(j+2) * grid.(i+3).(j+3));
      (* Диагональ вправо вверх *)
      if i - 3 >= 0 && j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i-1).(j+1) * grid.(i-2).(j+2) * grid.(i-3).(j+3));
      !max_val
    in
    let new_acc = max acc max_in_position in
    max_product_recursive grid rows cols i (j + 1) new_acc
```

### [Модульная реализация](./task11/lib/moduled.ml)

```ocaml
(* Функция генерации всех направлений *)
let generate_directions grid =
  let rows = Array.length grid in
  let cols = Array.length grid.(0) in
  let directions = ref [] in
  for i = 0 to rows - 1 do
    for j = 0 to cols - 1 do
      if j + 3 < cols then (* Горизонтально *)
        directions := (grid.(i).(j), grid.(i).(j+1), grid.(i).(j+2), grid.(i).(j+3)) :: !directions;
      if i + 3 < rows then (* Вертикально *)
        directions := (grid.(i).(j), grid.(i+1).(j), grid.(i+2).(j), grid.(i+3).(j)) :: !directions;
      if i + 3 < rows && j + 3 < cols then (* Диагональ вправо вниз *)
        directions := (grid.(i).(j), grid.(i+1).(j+1), grid.(i+2).(j+2), grid.(i+3).(j+3)) :: !directions;
      if i - 3 >= 0 && j + 3 < cols then (* Диагональ вправо вверх *)
        directions := (grid.(i).(j), grid.(i-1).(j+1), grid.(i-2).(j+2), grid.(i-3).(j+3)) :: !directions
    done
  done;
  !directions

(* Вычисление произведения для каждой четверки *)
let product (a, b, c, d) = a * b * c * d

let max_product grid =
  let directions = generate_directions grid in
  List.fold_left (fun acc quadruple -> max acc (product quadruple)) 0 directions;;
```

### [map](./p11/lib/mapped.ml)

```ocaml
let generate_row_products grid rows cols =
  Array.init rows (fun i ->
    Array.init (cols - 3) (fun j ->
      grid.(i).(j) * grid.(i).(j+1) * grid.(i).(j+2) * grid.(i).(j+3)))

let generate_col_products grid rows cols =
  Array.init (rows - 3) (fun i ->
    Array.init cols (fun j ->
      grid.(i).(j) * grid.(i+1).(j) * grid.(i+2).(j) * grid.(i+3).(j)))

let generate_main_diagonal_products grid rows cols =
  Array.init (rows - 3) (fun i ->
    Array.init (cols - 3) (fun j ->
      grid.(i).(j) * grid.(i+1).(j+1) * grid.(i+2).(j+2) * grid.(i+3).(j+3)))

let generate_second_diagonal_products grid rows cols =
  Array.init (rows - 3) (fun i ->
    Array.init (cols - 3) (fun j ->
      grid.(i).(cols - 1 - j) * grid.(i+1).(cols - 2 - j) * grid.(i+2).(cols - 3 - j) * grid.(i+3).(cols - 4 - j)))


let max_product grid =
  let rows = Array.length grid in
  let cols = Array.length grid.(0) in
  let all_products = List.flatten [
    Array.to_list (generate_row_products grid rows cols);
    Array.to_list (generate_col_products grid rows cols);
    Array.to_list (generate_main_diagonal_products grid rows cols);
    Array.to_list (generate_second_diagonal_products grid rows cols);
  ] in
  List.fold_left max 0 (List.map (Array.fold_left max 0) all_products)
```

### [Ленивые коллекции](./task11/lib/lazy.ml)

```ocaml
let generate_sequences grid =
  let rows = Array.length grid in
  let cols = Array.length grid.(0) in

  (* Создаём ленивую последовательность всех комбинаций (i, j, dx, dy) *)
  let seq =
    Seq.concat (List.to_seq
      [ (* Горизонтально *)
        Seq.init (rows * (cols - 3)) (fun k ->
            let i = k / (cols - 3) in
            let j = k mod (cols - 3) in
            (i, j, 0, 1));

        (* Вертикально *)
        Seq.init ((rows - 3) * cols) (fun k ->
            let i = k / cols in
            let j = k mod cols in
            (i, j, 1, 0));

        (* Диагональ вправо-вниз *)
        Seq.init ((rows - 3) * (cols - 3)) (fun k ->
            let i = k / (cols - 3) in
            let j = k mod (cols - 3) in
            (i, j, 1, 1));

        (* Диагональ вправо-вверх *)
        Seq.init ((rows - 3) * (cols - 3)) (fun k ->
            let i = 3 + (k / (cols - 3)) in
            let j = k mod (cols - 3) in
            (i, j, -1, 1))
      ])
  in

  (* Создаём последовательность произведений *)
  Seq.map
    (fun (i, j, di, dj) ->
      grid.(i).(j) *
      grid.(i + di).(j + dj) *
      grid.(i + 2 * di).(j + 2 * dj) *
      grid.(i + 3 * di).(j + 3 * dj))
    seq

(* Функция нахождения максимального произведения *)
let max_product grid =
  generate_sequences grid |> Seq.fold_left max 0
```

### [Итеративная реализация](./task11/lib/iterative.ml)
```ocaml
let max_product grid =
  let rows = Array.length grid in
  let cols = Array.length grid.(0) in
  let max_val = ref 0 in
  for i = 0 to rows - 1 do
    for j = 0 to cols - 1 do
      (* Горизонтально *)
      if j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i).(j+1) * grid.(i).(j+2) * grid.(i).(j+3));
      (* Вертикально *)
      if i + 3 < rows then
        max_val := max !max_val (grid.(i).(j) * grid.(i+1).(j) * grid.(i+2).(j) * grid.(i+3).(j));
      (* Диагональ вправо вниз *)
      if i + 3 < rows && j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i+1).(j+1) * grid.(i+2).(j+2) * grid.(i+3).(j+3));
      (* Диагональ вправо вверх *)
      if i - 3 >= 0 && j + 3 < cols then
        max_val := max !max_val (grid.(i).(j) * grid.(i-1).(j+1) * grid.(i-2).(j+2) * grid.(i-3).(j+3))
    done
  done;
  !max_val;;
```

### [Реализация на Python](./task11/commpn.py)

```python
def greatest_product(grid):
    max_product = 0
    rows, cols = len(grid), len(grid[0])
    
    for i in range(rows):
        for j in range(cols):
            # Горизонтально
            if j + 3 < cols:
                max_product = max(max_product, grid[i][j] * grid[i][j+1] * grid[i][j+2] * grid[i][j+3])
            # Вертикально
            if i + 3 < rows:
                max_product = max(max_product, grid[i][j] * grid[i+1][j] * grid[i+2][j] * grid[i+3][j])
            # Диагональ вправо вниз
            if i + 3 < rows and j + 3 < cols:
                max_product = max(max_product, grid[i][j] * grid[i+1][j+1] * grid[i+2][j+2] * grid[i+3][j+3])
            # Диагональ вправо вверх
            if i - 3 >= 0 and j + 3 < cols:
                max_product = max(max_product, grid[i][j] * grid[i-1][j+1] * grid[i-2][j+2] * grid[i-3][j+3])
    
    return max_product
```

## [Решение задачи 20](./task20/README.md)
Ниже приведены тематические особенности реализаций (где использована рекурсия, хвостовая рекурсия, модульное решение и пр.)
### [Реализация рекурсией](./task20/lib/recursion.ml)

```ocaml
let rec scale digits factor carry =
  match digits with
  | [] -> if carry > 0 then (carry mod 10) :: scale [] factor (carry / 10) else []
  | hd :: tl ->
      let prod = hd * factor + carry in
      (prod mod 10) :: scale tl factor (prod / 10)

let rec multiply acc i n =
  if i > n then acc
  else multiply (scale acc i 0) (i + 1) n

let rec sum_of_digits = function
  | [] -> 0
  | hd :: tl -> hd + sum_of_digits tl
```

### [Реализация хвостовой рекурсией](./task20/lib/tail_recursion.ml)

```ocaml
let rec scale digits factor carry acc =
  match digits with
  | [] -> if carry > 0 then scale digits factor (carry / 10) ((carry mod 10) :: acc) else acc
  | hd :: tl ->
      let prod = hd * factor + carry in
      scale tl factor (prod / 10) ((prod mod 10) :: acc)

let scale_tail digits factor =
  List.rev (scale digits factor 0 [])

let rec multiply acc i n =
  if i > n then acc
  else multiply (scale_tail acc i) (i + 1) n

let rec sum_of_digits digits acc =
  match digits with
  | [] -> acc
  | hd :: tl -> sum_of_digits tl (hd + acc)
```

### [Модульная реализация](./task20/lib/moduled.ml)

```ocaml
let factorial n =
  List.fold_left ( * ) 1 (List.init n (fun i -> i + 1))

let sum_of_digits n =
  string_of_int n
  |> String.to_seq
  |> List.of_seq
  |> List.map (fun c -> int_of_char c - int_of_char '0')
  |> List.fold_left ( + ) 0
```

### [map](./task20/lib/mapped.ml)

```ocaml
let factorial n =
  Array.init n (fun i -> i + 1)
  |> Array.fold_left ( * ) 1

let sum_of_digits n =
  String.to_seq (string_of_int n)
  |> Array.of_seq
  |> Array.map (fun c -> Char.code c - Char.code '0')
  |> Array.fold_left ( + ) 0
```

### [Итеративная реализация](./task20/lib/iterative.ml)
```ocaml
let scale digits factor =
  let acc = ref [] in
  let carry = ref 0 in
  List.iter (fun hd ->
    let prod = hd * factor + !carry in
    acc := (prod mod 10) :: !acc;
    carry := prod / 10
  ) digits;
  while !carry > 0 do
    acc := (!carry mod 10) :: !acc;
    carry := !carry / 10
  done;
  List.rev !acc

let factorial n =
  let result = ref [1] in
  for i = 2 to n do
    result := scale !result i
  done;
  !result

let sum_of_digits digits =
  let sum = ref 0 in
  List.iter (fun d -> sum := !sum + d) digits;
  !sum
```

### [Реализация на Python](./task20/solution.py)

```python
def sum_of_digits_in_factorial(n):
    factorial = math.factorial(n)
    return sum(int(digit) for digit in str(factorial))
```

## Запуск тестов

Для запуска тестов с использованием OUnit2:

```bash
dune runtest
```

## Заключение

Представленные решения демонстрируют различные подходы к решению задач с использованием функционального программирования на OCaml. Эти примеры показывают, как рекурсия, циклы и функции высшего порядка могут эффективно решать математические задачи.

## Зависимости

Для сборки и запуска проекта необходимо иметь:
- OCaml >= 4.12.0
- Dune >= 2.0
- OUnit2
- ppx_inline_test
