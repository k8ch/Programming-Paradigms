#Question 1

# Question1.1
#Create the function cubeLess (x, b) which calculates the power of 3 and the remainder such that
#b =x^3+r and returns the remainder r.

def cubeless(x, b):
    return b - x ** 3

# Question1.2
# Use the function cubeLess from Question 1.1 to find all numbers with a cube smaller than a given limit by
# creating a new function smallerCube (b) that generates the results as a list of tuples. 

def smallerCube(b):
    return smallerCube2(b, 1, [])


def smallerCube2(b, x, l):
    if cubeless(x, b) < 0:
        return l
    l.append(tuple([x, cubeless(x, b)]))
    return smallerCube2(b, x + 1, l)

# Question1.3
# Create a helper function restSum (S) to add up all the remainders from finding all cubes up to an
# upper limit in 2.

def restSum(s):
    return helperRestSum(s, 0)


def helperRestSum(s, sum):
    if s is not None:
        for x in s:
                y = x[1]
                sum += y
    return sum

# Question1.4
# Write another function to add all the rest sums that are multiples of 3 within a range into a list. 

def showAllRestSum(r1, r2):
    return sum(r1, r2, [])


def sum(i, max, l):
    if max > i:
        if 0 == restSum(smallerCube(i)) % 3:
            l.append(tuple([i, restSum(smallerCube(i))]))
            return sum((i + 1), max, l)
        else:
            return sum((i + 1), max, l)
    else:
        return l

''' print(cubeless(2, 10))
print(smallerCube(130))
print(restSum(smallerCube(130)))
print(showAllRestSum(1, 20)) '''

