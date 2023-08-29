from numpy import linalg

I = matrix([[1,0],[0,1]])
H = 1/sqrt(2)*matrix([[1,1],[1,-1]])
U = matrix([[1,0],[0,exp(i*pi/8)]])
T = matrix([[1,0],[0,exp(i*pi/4)]])
S = matrix([[1,0],[0,i]])
Z = matrix([[1,0],[0,-1]])

def meq(m1,m2): 
    return abs(linalg.norm(m1-m2))<0.0001

# C = H*S
# Cstar = C.n()



G = [U,T,T*U,S,S*U,S*T,S*T*U]
for i in range(len(G)):
    for k in range(len(G)):
        for m in range(len(G)):
            C = H*G[i]*H*G[k]*H*G[m]
            Cstar = C.n()

            for j in range(100):
                if abs(Cstar[0][0])>0.0001: Cstar = (1/Cstar[0][0]*Cstar).n()
                else: Cstar = (1/Cstar[1][0]*Cstar).n()
                if meq(I,Cstar):
                    print("order found!", j+1)
                    print(C)
                    print(i,k,m)
                    break
                else:
                    # print("...")
                    Cstar = Cstar*C
    