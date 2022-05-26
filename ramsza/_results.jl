using DataFrames
using CSV
using Tables
using FileIO
using JLD2

### Zmiana katalogu
cd("./ramsza");

### Wczytanie pliku
path_file = "SG_16_2000.jld2";
path_dir = "../die_neuste_ergebnisse/";
path_dir_out = "./data/";

a = load_object(string(path_dir, path_file));
n_top = length(a); # parametryzacje / wypłaty
n_bottom = length(a[1]); # pojedyncza parametryzacja

for k in 1:n_top
    for n in 1:n_bottom
        if n == 1
            global g = a[k][n]
        else
            g = vcat(g, a[k][n])
        end
    end
    
    if k < 10
        temp_name =  string(path_dir_out, chop(path_file, tail = 5), "___", "0$k.csv");
        CSV.write(temp_name, DataFrame(g, :auto))
    else
        temp_name =  string(path_dir_out, chop(path_file, tail = 5), "___", "$k.csv");
        CSV.write(temp_name, DataFrame(g, :auto))  
    end
end 
