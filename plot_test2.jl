using Plots


function f(x, y)
    tanh.(x).*(y .+ 1.0).^2
end

xlow = 0.0
xhigh = 1.0
ixmax = 11
x = [xlow + (xhigh-xlow)/ixmax*n for n in 1:ixmax]

ylow = -1.0
yhigh = 1.0
iymax = 11
y = [ylow + (yhigh-ylow)/iymax*n for n in 1:iymax]

p = Array{Float64}(undef, ixmax, iymax)

for j=iymax
    for i=ixmax
        p[i, j] = f(x[i], y[i])
    end
end


plot(x, p[:,:])
