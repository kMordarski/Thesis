using DataFrames
using CSV
using Tables
using FileIO

### Zmiana katalogu
cd("./ramsza");

### Wczytanie pliku
a = load("../Julia/PD_4_1000.jld2");

### Konwersje / podejrzewam, ze mozna to zrobic znacznie lepiej
b = a["single_stored_object"];
typeof(b)

c = Tables.table(b)
typeof(c)

### Zapisywanie do pliku CSV
CSV.write("./PD_4.csv", c)
