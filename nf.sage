from numpy import linalg


def meq(m1,m2): 
    return abs(linalg.norm(m1-m2))<0.0001

omega = exp(i*pi/4)
omegadagger = exp(-i*pi/4)
I = matrix([[1,0],[0,1]])
H = 1/sqrt(2)*matrix([[1,1],[1,-1]])
S = matrix([[1,0],[0,i]])
Sdagger= matrix([[1,0],[0,-i]])
T = matrix([[1,0],[0,exp(i*pi/4)]])
Tdagger = matrix([[1,0],[0,exp(-i*pi/4)]])
U = matrix([[1,0],[0,exp(i*pi/8)]])
Udagger = matrix([[1,0],[0,exp(-i*pi/8)]])

I = matrix([[1,0],[0,1]])
H = 1/sqrt(2)*matrix([[1,1],[1,-1]])
U = matrix([[1,0],[0,exp(i*pi/8)]])
U0 = I
U1 = U0*U
U2 = U1*U
U3 = U2*U
U4 = U3*U
U5 = U4*U
U6 = U5*U
U7 = U6*U

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


def computeNF(word):
    U = I
    for k in word:
        U *= H*matrix([[1,0],[0,exp(i*k*pi/8)]])
    return U.n()

def firstBiggerThan7(word):
    k = 0
    while k<len(word):
        if word[k]>=7: k += 1
        else: return k
    return k

def checkAllNFs(lenght):
    emptyword = [1 for i in range(lenght)]
    emptyword[0] = 0
    emptyword[-1] = 0
    word = emptyword.copy()
    while not all(v==7 for v in word):
        while word[0] <= 7:
            print(word)
            if meq(I,computeNF(word)):
                print("---- Identity normal form found! ----")
                print(word)
                return True
            else:
                word[0] += 1
        k = firstBiggerThan7(word)
        if k>=lenght: return True
        word[k] += 1
        if  word[k]==2: word[k] = 3
        for i in range(k): word[i] = emptyword[i]


lenght = 5
checkAllNFs(lenght)
