using DataFrames
using CSV
using Tables
using FileIO
using JLD2

### Zmiana katalogu
cd("./ramsza");

### Wczytanie pliku
a = load_object("../PD_4_2000_b_fixed.jld2");
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
        CSV.write("./PD_04b_0$k.csv", DataFrame(g, :auto))
    else
        CSV.write("./PD_04b_$k.csv", DataFrame(g, :auto))  
    end
end 

