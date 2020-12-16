import numpy as np
import networkx as nx


def AdjMat2Edges(adj_mat):
	edges = []
	for i in range(adj_mat.shape[0]):
		for j in range(i+1, adj_mat.shape[1]):
			if adj_mat[i, j] and adj_mat[j, i]:
				edges.append([i, j])
				edges.append([j, i])
			elif adj_mat[i, j]:
				edges.append([i, j])
			elif adj_mat[j, i]:
				edges.append([j, i])
				
	return edges

def ChainCom(v, G):
	A = [v]
	B = []
	for node in G.nodes:
		if node not in A:
			B.append(node)
			
	while len(B) != 0:        
		T = []
		for a in A:
			T.extend([neighbor for neighbor in G.neighbors(a) if neighbor in B])


		T = list(set(T))
					
#		for t in T:
#			if t not in B:
#				T.remove(t)


		for t in T:
			for a in A:
				if (t, a) in G.edges():
					G.remove_edge(t, a)
					
		flag = True			
		while flag:
			flag = False
			for (y, z) in G.subgraph(T).edges():				
				for x in G.node():
					if (y, z) in G.edges() and (z, y) in G.edges() \
					and (x, z) not in G.edges() and (z, x) not in G.edges() \
					and (x, y) in G.edges() and (y, x) not in G.edges():	 							
							G.remove_edge(z, y)							  
							flag = True									  

		A = T
		B_ = []
		for b in B:
			if b not in T:
				B_.append(b)
		B = B_.copy()
			
	return CPDAG2ConnComp(G)	

def SizeCom(comp):

	p = len(comp.nodes)	
	n = len(comp.edges)
	
	if n == p - 1:
		return p
	if n == p:
		return 2*p
	if n == p*(p - 1)/2:	
		return np.math.factorial(p)
	if n == p * (p - 1) / 2 - 1:
		return 2 * np.math.factorial(p - 1) - np.math.factorial(p - 2)
	if n == p * (p - 1) / 2 - 2:
		return (p**2 - p - 4) * np.math.factorial(p - 3)
	

	size_total = 0
	for v in range(p):
		comps = ChainCom(v, comp.to_directed())		
		size = 1
		for c in comps:		
			size *= SizeCom(c)
		size_total += size
	return size_total

def CPDAG2ConnComp(CPDAG):
	
	adj_mat = nx.adjacency_matrix(CPDAG).todense()
	comp_mat = np.zeros_like(adj_mat)
	
	for i in range(adj_mat.shape[0]):
		for j in range(adj_mat.shape[1]):
			if adj_mat[j,i] * adj_mat[i, j]:
				comp_mat[i, j] = 1
				
	return [comp for comp in nx.connected_component_subgraphs(nx.from_numpy_matrix(comp_mat))]
	


def SizeMEC (CPDAG):
	
	connected_components = CPDAG2ConnComp(CPDAG)
	size = 1
	for i in range(len(connected_components)):
		size = size * SizeCom(connected_components[i])		
	return size
