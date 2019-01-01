using Plots

imax = 11
jmax = 11
x = range(0.0, stop=1.0, length=imax)
y = range(0.0, stop=1.0, length=jmax)

function f(x::Float64, y::Float64)
    if x >= y
        x*y-x*x
    else
        x*x-y*y-2*x*y
    end
end

function g(x, y)
    x*y
end
Ix = Array{Float64}(undef, imax, jmax)
for j=1:jmax
    for i=1:imax
        Ix[i, j] = f(x[i], y[j])
    end
end


plot(x, y, Ix[:, :], legend=:none)
