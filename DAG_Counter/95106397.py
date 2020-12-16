import numpy as np
from matplotlib import pyplot
import tools
import networkx as nx





CPDAG0 = nx.DiGraph()
CPDAG0.add_nodes_from([0, 1, 2, 3, 4, 5])
CPDAG0.add_edges_from([[0,5],[1,3],[2,5],[3,1],[4,3],[4,1],[5,0],[5,1],[5,2],[5,3]])

adj_mat = nx.adj_matrix(CPDAG0).todense()


pyplot.figure()
pyplot.imshow(adj_mat, cmap='gray')

edges = tools.AdjMat2Edges(adj_mat)

CPDAG = nx.DiGraph()
CPDAG.add_nodes_from(range(len(adj_mat)))
CPDAG.add_edges_from(edges)

print(tools.SizeMEC(CPDAG))

pyplot.figure()
nx.draw_shell(CPDAG, with_labels=True)
