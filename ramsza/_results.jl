using DataFrames
using CSV
using Tables
using FileIO
using JLD2

### Zmiana katalogu
cd("./ramsza");

### Wczytanie pliku
a = load_object("../Julia/PD_16_1000.jld2")
length(a) # parametryzacje / wypłaty
a[1] # pojedyncza parametryzacja

for k in 1:20
    for n in 1:100
        if n == 1
            global g = a[k][n]
        else
            g = vcat(g, a[k][n])
        end
    end
    if k < 10
        CSV.write("./data/PD_16_1000_0$k.csv", DataFrame(g, :auto))
    else
        CSV.write("./data/PD_16_1000_$k.csv", DataFrame(g, :auto))  
    end
end 

