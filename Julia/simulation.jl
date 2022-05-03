# Symulacje do pracy licencjackiej

import Graphs
using Graphs
using Plots
import TikzPictures 
using GraphPlot, Compose
using Cairo, Fontconfig
using Random
using Base.Iterators: partition

# Parametrisation (for the PD game)

T_PD = 1.5 # This parameter is the advantage of defectors over cooperators, being typically constrained to the interval 1 < b <= 2
R_PD = 1
P_PD = 0
S_PD = 0

# Parametrisation (for the SG game)

beta = 1.5 # Just an example
T_SG = beta
R_SG = beta - 0.5
S_SG = beta - 1
P_SG = 0
r = 1/(2 * beta - 1)

# Parametrisation of SF NOC's (Barabassi-Albert models)

z = 16
m0 = Int16(z/2)
N = 10000
st = N-m0

# Tracking of the game results

result_C = 0
result_D = 0

BAM = Graphs.SimpleGraphs.barabasi_albert(10000, m0, m0)

nv(BAM)


players = collect(partition(randperm(10000), 5000)) # distribution of strategies across the network

coop_strat = Dict( (players[1][i] => "c" for i=1:5000) )# Half of the players get the coop strategy
def_strat = Dict( (players[2][i] => "d" for i=1:5000) ) # The other half get the defect strategy
all_strats = merge(coop_strat, def_strat)

get(all_strats, 4986, 0)

neigh = neighbors(BAM, keys(all_strats)[500])
all_strats[1]
keys(all_strats)

findall(x->x==1, first_1)

intersect(first_2, first_1)

function g(x, y, t) # first player is a coop (x), the second player is def (y), t is the type of game (either SG or PD)
    payoffs_SG = [T_SG, R,SG, S_SG, P_SG]
    payoffs_PD = [T_PD, R_PD, S_PD, P_PD]    
    
    g + y
end

b = 1:10

b_s = shuffle(b)

# Defining a function to look for a neighbor with different strategy than agent selected

function check_strat(a, all_strats, BAM)

    neigh = shuffle(neighbors(BAM, a))

    for i in neigh
        if get(all_strats, a, 0) != get(all_strats, i, 0)    
            
            global b = i

            break
        end
    end
    print(b)
    return(b)
end

check_strat(100, all_strats, BAM)

# Loop that performs simulations

for j in 1:100 # This loop controlles building new NF SOC's

    BAM = Graphs.SimpleGraphs.barabasi_albert(N, m0, m0, is_directed = false) # Generating SF NOC

    players = collect(partition(randperm(10000), 5000)) # distribution of strategies across the network
    coop_strat = Dict( (players[1][i] => "c" for i=1:5000) )# Half of the players get the coop strategy
    def_strat = Dict( (players[2][i] => "d" for i=1:5000) ) # The other half get the defect strategy
    all_strats = merge(coop_strat, def_strat)

    # This loop is responsible for evaluating results of games

    for k in 1:11000
        player_n = rand(1:10000)
        
        player_k = check_strat(player_n, all_strats, BAM)
    
    end
end

rand(1:10000)

rand(all_strats)

values(all_strats)

# Creating Scale-Free Network in compliance with preferential attachment and growth rules. Each vertex corresponds 

# Defining games that will be played throughout the population (snowdrift or prisoners dillema) in order to show the emergence of
# cooperations 

#

#