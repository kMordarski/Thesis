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
r = 1/(2 * beta - 1) # Cost to benefit ratio of mutual cooperation

# Parametrisation of SF NOC's (Barabassi-Albert models)

z = 16
m0 = Int16(z/2)
N = 10000
st = N-m0

# Tracking of the game results

acc_payoffs = zeros(Float64, 1, 100000)

BAM = Graphs.SimpleGraphs.barabasi_albert(10000, m0, m0)

nv(BAM)

edge = collect(edges(BAM))

edge_1 = edge[1]

edge_1

typeof(edge_1)

typeof(edges)

for n in edge
    print(n)
end

function transform(e)

    p = [src(e), dst(e)]

end

function strat(e)
    p = [strategies[e[1]],strategies[e[2]]]
end

@time begin
edges_new = map(transform, edge)
end

@time begin
    edges_with_strat = map(strat, edges_new)
end

edges_new[1][2]

strategies = rand([1,2], 10000)

payoffs_PD[edges_with_strat[4][1], edges_with_strat[4][2]]

edges_with_strat[4]
edges_new[4]

function games(x, y, V)
    for n in 1:length(x)
        V[y[n][1]] += payoffs_PD[x[n][1], x[n][2]][1]
        V[y[n][2]] += payoffs_PD[x[n][1], x[n][2]][2]
    end
    return V
end

@time begin
acc_payoffs_new = games(edges_with_strat, edges_new, acc_payoffs)
end


findmax(acc_payoffs_new)

# Payoffs matrix for the PD game

payoffs_PD = Array{Array{Float64,1},2}(undef, 2,2)

payoffs_PD[1,1] = [R_PD, R_PD]
payoffs_PD[1,2] = [S_PD, T_PD]
payoffs_PD[2,1] = [T_PD, S_PD]
payoffs_PD[2,2] = [P_PD, P_PD]

payoffs_PD[1,2]

# Payoffs matrix for the SG game

payoffs_SG = Array{Array{Float64,1},2}(undef, 2,2)
payoffs_SG[1,1] = [R_SG, R_SG]
payoffs_SG[1,2] = [T_SG, S_SG]
payoffs_SG[2,1] = [S_SG, T_SG]
payoffs_SG[2,2] = [P_SG, P_SG]

payoffs_SG

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

    # This loop is responsible for evaluating results of games

    for k in 1:11000
    
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