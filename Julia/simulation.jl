# Symulacje do pracy licencjackiej

import Distributions
using Pkg
import Graphs
using Graphs
using Plots
import TikzPictures 
using GraphPlot, Compose
using Cairo, Fontconfig
using Random
using Base.Iterators: partition
using DataStructures

# Parametrisation (for the PD game)

T_PD = 1.1 # This parameter is the advantage of defectors over cooperators, being typically constrained to the interval 1 < b <= 2
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

# Distribution of the strategies
strategies = rand([1,2], 10000)

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

edge

#Defining functions to map strategies onto edges

function transform(e)

    p = [src(e), dst(e)]

end

function strat(e::Vector{Vector{Int16}})
    p = [strategies[e[1]],strategies[e[2]]]
end

@time begin
edges_new = map(transform, edge)
end

edges_new

@time begin
    edges_with_strat = map(strat, edges_new)
end

payoffs_PD[edges_with_strat[4][1], edges_with_strat[4][2]]

typeof(edges_new)

function games(x::Vector{Vector{Int64}}, y::Vector{Vector{Int8}}, V::Matrix{Float64}) # V is an array of cummulated payoffs, x is an array of edges, y is an array of strategies
    for n in 1:length(x)
        V[y[n][1]] += payoffs_PD[x[n][1], x[n][2]][1]
        V[y[n][2]] += payoffs_PD[x[n][1], x[n][2]][2]
    end
    return V
end

@time begin
acc_payoffs_new = games(edges_with_strat, edges_new, acc_payoffs)
end

# Defining a function to look for a neighbor with different strategy than agent selected

n = neighbors(BAM, 100)

function check_strat(a::Int64, y::Vector{Int64}, BAM::SimpleGraph{Int16}) # a is a randomly chosen vertex, y is an array of strategies, BAM is a Barabassi-Albert network, V is an array of cummulated payoffs

    neigh = shuffle(neighbors(BAM, a))
    for n in neigh
    if y[a] != y[n]
            global b = n
            break
        end
    end
    
    if G == "PD"
        D = T_PD
    elseif G == "SG"
        D = T_SG
    end

    k = max(length(neighbors(BAM, a)), length(neighbors(BAM, b)))

    if acc_payoffs[a] > acc_payoffs[b]
        prob = (acc_payoffs[a] - acc_payoffs[b])/D*k
        if rand() <= prob
            y[b] = y[a]
        end
    elseif acc_payoffs[a] < acc_payoffs[b]
        prob = (acc_payoffs[b] - acc_payoffs[a])/D*k
        if rand() <= prob
            y[a] = y[b]
        end
    end
    return b
end
# defining which game is to be played

G = "PD"

A = [1,2,3,4,5]
B = [2,3,4,5,6]
D = [3,4,5,6,7]

C = [A,B]

C = push!(C, D)


# Loop that performs simulations
@time begin
#    for j in 1:100 # This loop controlles building new NF SOC'sq and mapping their edges to define the stratgies

        BAM = Graphs.SimpleGraphs.barabasi_albert(N, m0, m0, is_directed = false) # Generating SF NOC

        strategies = rand([1,2], N)

        all_edges = collect(edges(BAM))

        all_edges_final = map(transform, all_edges)

        all_edges_strats = map(strat, all_edges_final)
        
        #if j == 1
        #    global Arr_paths = [track]
        #elseif j > 1
        #    Arr_paths = push!(Arr_paths, track)
        #end

        global track = zeros(Float16,1000) # Keeping track of the coop/def proportion

        # This loop is responsible for evaluating results of games

        for k in 1:11000

            acc_payoffs_new = games(edges_with_strat, edges_new, acc_payoffs)
            
            a = rand(1:10000)

            check_strat(a, strategies, BAM)

            if k > 10000
                c_d = counter(strategies)[1]/(counter(strategies)[2] + counter(strategies)[1])

                track[k-10000] = c_d
            end
        end
#    end
end

track

rand(1:10000)

track = zeros(Float64,1000)

@time begin
track[1] = 1
end
# Creating Scale-Free Network in compliance with preferential attachment and growth rules. Each vertex corresponds 

# Defining games that will be played throughout the population (snowdrift or prisoners dillema) in order to show the emergence of
# cooperations 