import Graphs
import TikzPictures 
using GraphPlot, Compose
using Cairo, Fontconfig


BAM = Graphs.SimpleGraphs.barabasi_albert(1000, 5, 2, is_directed = true)


print(BAM)


draw(PNG("BAM_1.png", 16cm, 16cm),gplot(BAM))



# Creating Scale-Free Network in compliance with preferential attachment and growth rules. Each vertex corresponds 

# Defining games that will be played throughout the population (snowdrift or prisoners dillema) in order to show the emergence of
# cooperations 

#

#