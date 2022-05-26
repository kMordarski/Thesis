# Symulacje do pracy licencjackiej

using Distributions
using Pkg
import Graphs
using Graphs
using Plots
# using TikzPictures 
# using GraphPlot, Compose
# using Cairo, Fontconfig
using Random
using Base.Iterators: partition
using DataStructures
using JLD2

# Parametrisation (for the PD game)

T_PD = 1.6 # This parameter is the advantage of defectors over cooperators, being typically constrained to the interval 1 < b <= 2
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

z = 4
m0 = Int16(z/2)
N = Int64(1000)
st = N-m0

print("This is $z, and this is $T_PD.")
# defining which game is to be played
G = "SG"

# Tracking of the game results

acc_payoffs = zeros(Float16, 1, 1000)

BAM = Graphs.SimpleGraphs.barabasi_albert(1000, m0, m0)
e

nv(BAM)

edge = collect(edges(BAM))

# Distribution of the strategies
strategies = rand([Int16(1),Int16(2)], 1000)

# Payoffs matrix for the PD game

payoffs_PD = Array{Array{Float16,1},2}(undef, 2,2)

payoffs_PD[1,1] = [R_PD, R_PD]
payoffs_PD[1,2] = [S_PD, T_PD]
payoffs_PD[2,1] = [T_PD, S_PD]
payoffs_PD[2,2] = [P_PD, P_PD]

payoffs_PD[1,2]
payoffs_PD

# Payoffs matrix for the SG game

payoffs_SG = Array{Array{Float16,1},2}(undef, 2,2)
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

function strat(e)
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

function games(x, y, V) # V is an array of cummulated payoffs, x is an array of strategies, y is an array of edges
    for n in 1:length(x)
        if G == "PD"
            V[y[n][1]] += payoffs_PD[Int64(x[n][1]), Int64(x[n][2])][1]
            V[y[n][2]] += payoffs_PD[x[n][1], x[n][2]][2]
        else
            V[y[n][1]] += payoffs_SG[x[n][1], x[n][2]][1]
            V[y[n][2]] += payoffs_SG[x[n][1], x[n][2]][2]
        end
    end
    return V
end

@time begin
    acc_payoffs_new = games(edges_with_strat, edges_new, acc_payoffs)
end

edges_new[1:40]
edges_with_strat[1:40]

# Defining a function to look for a neighbor with different strategy than agent selected

n = neighbors(BAM, 1)

shuffle(neighbors(BAM, 1))

function CheckStrat(a, y, BAM) # a is a randomly chosen vertex, y is an array of strategies, BAM is a Barabassi-Albert network, 

    neigh = shuffle(neighbors(BAM, a))

    global b = 0

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

    if b == 0
        return
    end

    k = max(length(neighbors(BAM, a)), length(neighbors(BAM, b)))

    if acc_payoffs_new[a] > acc_payoffs_new[b]
        prob = (acc_payoffs_new[a] - acc_payoffs_new[b])/(D*k)
        if rand() <= prob
            y[b] = y[a]
        end
    elseif acc_payoffs_new[a] < acc_payoffs_new[b]
        prob = (acc_payoffs_new[b] - acc_payoffs_new[a])/(D*k)
        if rand() <= prob
            y[a] = y[b]
        end
    else
        return
    end
    return
end

A = [1,2,3,4,5]
B = [2,3,4,5,6]
D = [3,4,5,6,7]

C = [A,B]

C = push!(C, D)

# Loop that performs simulations
A = zeros(500,1)
A = A .+ 2
B = zeros(500,1)
B = B .+ 1
C = vcat(A,B)

D = shuffle(C)

Z = [4,8,16]

@time begin
for n in Z
    
    z = n
    m0 = Int16(z/2)
    N = Int64(1000)
    st = N-m0

    for i in 1:20

        if i == 1
            global Data_to_save = Array{Vector}(undef,(20,1))
        else
            Data_to_save[i-1] = Arr_paths
        end
        # Parametrisation (for the PD game)

        T_PD = 1 + 0.05 * (i-1) # This parameter is the advantage of defectors over cooperators, being typically constrained to the interval 1 < b <= 2
        R_PD = 1
        P_PD = 0
        S_PD = 0

        # Parametrisation (for the SG game)

        r = 0.00001 + 0.05 * (i-1) # Cost to benefit ratio of mutual cooperation
        beta = (1-r)/(2*r) # Just an example
        T_SG = beta
        R_SG = beta - 0.5
        S_SG = beta - 1
        P_SG = 0
        

        # Payoffs matrix for the PD game

        payoffs_PD = Array{Array{Float16,1},2}(undef, 2,2)

        payoffs_PD[1,1] = [R_PD, R_PD]
        payoffs_PD[1,2] = [S_PD, T_PD]
        payoffs_PD[2,1] = [T_PD, S_PD]
        payoffs_PD[2,2] = [P_PD, P_PD]

        payoffs_PD[1,2]

        # Payoffs matrix for the SG game

        payoffs_SG = Array{Array{Float16,1},2}(undef, 2,2)
        payoffs_SG[1,1] = [R_SG, R_SG]
        payoffs_SG[1,2] = [T_SG, S_SG]
        payoffs_SG[2,1] = [S_SG, T_SG]
        payoffs_SG[2,2] = [P_SG, P_SG]


        for j in 1:100 # This loop controlles building new NF SOC'sq and mapping their edges to define the stratgies

            BAM = Graphs.SimpleGraphs.barabasi_albert(N, m0, m0, is_directed = false) # Generating SF NOC

            strats_coop = zeros(Int8,500,1) .+ 1
            strats_def = zeros(Int8,500,1) .+ 2
            strategies = shuffle(vcat(strats_coop, strats_def))

            all_edges = collect(edges(BAM))

            all_edges_final = map(transform, all_edges)

            all_edges_strats = map(strat, all_edges_final)

            acc_payoffs_new = zeros(Float16, 1, 1000)

            global track = zeros(Float64, 1, 100) # Keeping track of the coop/def proportion
            
            if j == 1
                global Arr_paths = [track]
            elseif j > 1
                Arr_paths = push!(Arr_paths, track)
            end

            # This loop is responsible for evaluating results of games

            for k in 1:Int64(2*N + (1/10)*N)

                acc_payoffs_new = games(all_edges_strats, all_edges_final, acc_payoffs_new)
                
                a = rand(1:N)

                CheckStrat(a, strategies, BAM)

                if k > 2*N
                    c_d = counter(strategies)[1]/(counter(strategies)[2] + counter(strategies)[1])

                    track[Int64(k-2*N)] = c_d
                end
            end
        end
        Data_to_save[i] = Arr_paths
    end
    save_object("die neuste Ergebnisse/SG_$z,_2000.jld2", Data_to_save)
    end
end


Data_to_save

# Creating Scale-Free Network in compliance with preferential attachment and growth rules. Each vertex corresponds 

# Defining games that will be played throughout the population (snowdrift or prisoners dillema) in order to show the emergence of
# cooperations 