from numpy import linalg

EPS = 0.0001

I = matrix([[1,0],[0,1]])
H = 1/sqrt(2)*matrix([[1,1],[1,-1]])
X = matrix([[0,1],[1,0]])
Y = matrix([[0,-i],[i,0]])
U = matrix([[1,0],[0,exp(i*pi/8)]])
T = matrix([[1,0],[0,exp(i*pi/4)]])
S = matrix([[1,0],[0,i]])
Z = matrix([[1,0],[0,-1]])
ZS= matrix([[1,0],[0,-i]])
ZST = matrix([[1,0],[0,exp(-i*pi/4)]])
ZSTU = matrix([[1,0],[0,exp(-i*pi/8)]])

Clifford = [I,Z,S,ZS,X,Y,X*S,X*ZS,H*S*H,H*ZS*H,H*S*H*Z,H*ZS*H*Z,H*S*H*S,H*ZS*H*ZS,H*ZS*H*S,H*S*H*ZS,H,H*X,H*Z,H*Y,H*S,H*ZS,H*X*S,H*X*ZS]
approxClifford = []
for C in Clifford:
    approxClifford.append(C.n())

def isIdentity(m):
    if abs(m[0][0])>EPS: return abs(linalg.norm(matrix([[1,0],[0,1]])-(1/m[0][0]*m).n()))<EPS
    else: return False

def isEqual(m1,m2):
    if abs(m1[0][0])>EPS: m1 = (1/m1[0][0]*m1).n()
    else: m1 = (1/m1[1][0]*m1).n()
    if abs(m2[0][0])>EPS: m2 = (1/m2[0][0]*m2).n()
    else: m2 = (1/m2[1][0]*m2).n()
    return abs(linalg.norm(m1-m2))<EPS

def computeNF(word):
    U = matrix([[1,0],[0,exp(i*word[0]*pi/8)]])
    for k in range(1,len(word)):
        U *= H*matrix([[1,0],[0,exp(i*word[k]*pi/8)]])
    return U.n()

def firstBiggerThan7(word):
    k = 0
    while k<len(word):
        if word[k]>=7: k += 1
        else: return k
    return k

def checkAllNFs(lenght):
    emptyword = [int(i!=0) for i in range(lenght)]
    word = emptyword.copy()
    while all(v<8 for v in word):
        print(word)
        NF = computeNF(word)
        for C in approxClifford:
            if isIdentity(NF*C):
                print("---- Identity normal form found! ----")
                print(word)
                return True
        k = firstBiggerThan7(word)
        if k>=lenght: return True
        word[k] += 1
        if k!=0 and word[k]==4: word[k] = 5
        for i in range(k): word[i] = emptyword[i]


lenght = 7
checkAllNFs(lenght)










# I = matrix([[1,0],[0,1]])
# H = 1/sqrt(2)*matrix([[1,1],[1,-1]])
# U = matrix([[1,0],[0,exp(i*pi/8)]])
# U0 = I
# U1 = U0*U
# U2 = U1*U
# U3 = U2*U
# U4 = U3*U
# U5 = U4*U
# U6 = U5*U
# U7 = U6*U


# print(matrix([[1,0],[0,exp(i*5*pi/8)]]))

# print(U*U)
# print(T)

# Uinit = [U0,U1,U2,U3,U4,U5,U6,U7]
# Umid = [U1,U2,U3,U5,U6,U7]

# nf1 = (U3*H*U1*H*U7*H*U2*H*U6*H*U6*H).n()

# # print(nf1.n())

# for i in range(1000):
#     l = randint(1, 30)
#     nf2 = I.n()
#     if randint(0, 1)==0: nf2 *= Ui[randint(0, 7)].n()
#     for j in range(l):
#         nf2 *= H*Uj[randint(0, 5)].n()
#     if randint(0, 1)==0: nf2 *= H.n()
#     if meq(nf1,nf2):
#         print("found")
#     else:
#         print(i,"not found yet")