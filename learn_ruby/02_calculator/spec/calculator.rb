def add (x,y)
	x+y
end

def subtract(x,y)
	x-y
end

def sum(arr)
  arr.inject(0){|sum, n|sum+n}
end

def multiply(x,y,z=1)
x*y*z
end

def power(x,y)
x**y
end

def factorial(n)
  if n == 0
    1
  else
    n * factorial(n-1)
  end
end